---
title: gem5源码解读
date: 2021-12-02 11:52:53
tags:
---
# gem5源码解读

## 1. Cycles类

```C++
/**
 * Cycles is a wrapper class for representing cycle counts, i.e. a
 * relative difference between two points in time, expressed in a
 * number of clock cycles.
 *
 * The Cycles wrapper class is a type-safe alternative to a
 * typedef, aiming to avoid unintentional mixing of cycles and ticks
 * in the code base.
 *
 * Note that there is no overloading of the bool operator as the
 * compiler is allowed to turn booleans into integers and this causes
 * a whole range of issues in a handful locations. The solution to
 * this problem would be to use the safe bool idiom, but for now we
 * make do without the test and use the more elaborate comparison >
 * Cycles(0).
 */
class Cycles
{

  private:

    /** Member holding the actual value. */
    uint64_t c;

  public:

    /** Explicit constructor assigning a value. */
    explicit constexpr Cycles(uint64_t _c) : c(_c) { }

    /** Default constructor for parameter classes. */
    Cycles() : c(0) { }

    /** Converting back to the value type. */
    constexpr operator uint64_t() const { return c; }

    /** Prefix increment operator. */
    Cycles& operator++() { ++c; return *this; }

    /** Prefix decrement operator. Is only temporarily used in the O3 CPU. */
    Cycles& operator--() { assert(c != 0); --c; return *this; }

    /** In-place addition of cycles. */
    Cycles& operator+=(const Cycles& cc) { c += cc.c; return *this; }

    /** Greater than comparison used for > Cycles(0). */
    constexpr bool
    operator>(const Cycles& cc) const
    {
        return c > cc.c;
    }

    constexpr Cycles
    operator+(const Cycles& b) const
    {
        return Cycles(c + b.c);
    }

    constexpr Cycles
    operator-(const Cycles& b) const
    {
        return c >= b.c ? Cycles(c - b.c) :
            throw std::invalid_argument("RHS cycle value larger than LHS");
    }

    constexpr Cycles
    operator <<(const int32_t shift) const
    {
        return Cycles(c << shift);
    }

    constexpr Cycles
    operator >>(const int32_t shift) const
    {
        return Cycles(c >> shift);
    }

    friend std::ostream& operator<<(std::ostream &out, const Cycles & cycles);
};
```

(1) 整个Cycles类只有一个私有成员变量：c，其余的共有函数都是支持对c的不同操作。
(2) 支持两种构造方式：（1）给定一个常数进行构造；（2）无参数的构造，c默认为0.
(3) 重载int(), ++, --, +=, >, +, >=, <<, >>等

## 2. Colcked类

```C++
/**
 * Helper class for objects that need to be clocked. Clocked objects
 * typically inherit from this class. Objects that need SimObject
 * functionality as well should inherit from ClockedObject.
 */
class Clocked
{

  private:
    // the tick value of the next clock edge (>= curTick()) at the
    // time of the last call to update()
    mutable Tick tick;

    // The cycle counter value corresponding to the current value of
    // 'tick'
    mutable Cycles cycle;

    /**
     *  Align cycle and tick to the next clock edge if not already done. When
     *  complete, tick must be at least curTick().
     */
    void
    update() const
    {
        // both tick and cycle are up-to-date and we are done, note
        // that the >= is important as it captures cases where tick
        // has already passed curTick()
        if (tick >= curTick())
            return;

        // optimise for the common case and see if the tick should be
        // advanced by a single clock period
        tick += clockPeriod();
        ++cycle;

        // see if we are done at this point
        if (tick >= curTick())
            return;

        // if not, we have to recalculate the cycle and tick, we
        // perform the calculations in terms of relative cycles to
        // allow changes to the clock period in the future
        Cycles elapsedCycles(divCeil(curTick() - tick, clockPeriod()));
        cycle += elapsedCycles;
        tick += elapsedCycles * clockPeriod();
    }

    /**
     * The clock domain this clocked object belongs to
     */
    ClockDomain &clockDomain;

  protected:

    /**
     * Create a clocked object and set the clock domain based on the
     * parameters.
     */
    Clocked(ClockDomain &clk_domain)
        : tick(0), cycle(0), clockDomain(clk_domain)
    {
        // Register with the clock domain, so that if the clock domain
        // frequency changes, we can update this object's tick.
        clockDomain.registerWithClockDomain(this);
    }

    Clocked(Clocked &) = delete;
    Clocked &operator=(Clocked &) = delete;

    /**
     * Virtual destructor due to inheritance.
     */
    virtual ~Clocked() { }

    /**
     * Reset the object's clock using the current global tick value. Likely
     * to be used only when the global clock is reset. Currently, this done
     * only when Ruby is done warming up the memory system.
     */
    void
    resetClock() const
    {
        Cycles elapsedCycles(divCeil(curTick(), clockPeriod()));
        cycle = elapsedCycles;
        tick = elapsedCycles * clockPeriod();
    }

    /**
     * A hook subclasses can implement so they can do any extra work that's
     * needed when the clock rate is changed.
     */
    virtual void clockPeriodUpdated() {}

  public:

    /**
     * Update the tick to the current tick.
     */
    void
    updateClockPeriod()
    {
        update();
        clockPeriodUpdated();
    }

    /**
     * Determine the tick when a cycle begins, by default the current one, but
     * the argument also enables the caller to determine a future cycle. When
     * curTick() is on a clock edge, the number of cycles in the parameter is
     * added to curTick() to be returned. When curTick() is not aligned to a
     * clock edge, the number of cycles in the parameter is added to the next
     * clock edge.
     *
     * @param cycles The number of cycles into the future
     *
     * @return The start tick when the requested clock edge occurs. Precisely,
     * this tick can be
     *     curTick() + [0, clockPeriod()) + clockPeriod() * cycles
     */
    Tick
    clockEdge(Cycles cycles=Cycles(0)) const
    {
        // align tick to the next clock edge
        update();

        // figure out when this future cycle is
        return tick + clockPeriod() * cycles;
    }

    /**
     * Determine the current cycle, corresponding to a tick aligned to
     * a clock edge.
     *
     * @return When curTick() is on a clock edge, return the Cycle corresponding
     * to that clock edge. When curTick() is not on a clock edge, return the
     * Cycle corresponding to the next clock edge.
     */
    Cycles
    curCycle() const
    {
        // align cycle to the next clock edge.
        update();

        return cycle;
    }

    /**
     * Based on the clock of the object, determine the start tick of the first
     * cycle that is at least one cycle in the future. When curTick() is at the
     * current cycle edge, this returns the next clock edge. When calling this
     * during the middle of a cycle, this returns 2 clock edges in the future.
     *
     * @return The start tick of the first cycle that is at least one cycle in
     * the future. Precisely, the returned tick can be in the range
     *     curTick() + [clockPeriod(), 2 * clockPeriod())
     */
    Tick nextCycle() const { return clockEdge(Cycles(1)); }

    uint64_t frequency() const { return SimClock::Frequency / clockPeriod(); }

    Tick clockPeriod() const { return clockDomain.clockPeriod(); }

    double voltage() const { return clockDomain.voltage(); }

    Cycles
    ticksToCycles(Tick t) const
    {
        return Cycles(divCeil(t, clockPeriod()));
    }

    Tick cyclesToTicks(Cycles c) const { return clockPeriod() * c; }
};
```

- 私有成员变量
  - tick:  uint64类型变量，用于记录当前仿真时间
  - cycle: Cycles类型变量，记录当前tick对应的周期
- 私有成员函数
  - update(): 更新tick和cycle
