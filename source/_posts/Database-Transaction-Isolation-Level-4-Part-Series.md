---
title: Database Transaction Isolation Level (4 Part Series)
categories:
  - 计算机体系架构
password: www
abstract: 'Welcome to my blog, enter password to read.'
message: 'Welcome to my blog, enter password to read.'
date: 2023-02-04 19:47:57
tags:
- Database
- 数据库
---

> 原文转载自：https://dev.to/tlphat/series/17071

## Part I: Overview of database transaction and ACID properties

Back when I was studying Relational Database, I found that database transaction is a very interesting topic. But things soon get complicated when we need to deal with concurrent transactions. Recently I have had a chance to reread my notes about this subject. Therefore, I decided to write a couple of posts to review the knowledge. It will be a series focusing on isolation levels.

So let's start by defining what is a database transaction.

### Transaction

Briefly speaking, transaction is an independent unit of work. It usually consists of a list of statements that attempt to read and write data. Let's take an example, with MySQL, it will be a list of SELECTs, UPDATEs, INSERTs, DELETEs, and so on.

A classic example of a database transaction is to simulate a bank transaction. Suppose Tom wants to transfer $50 from his account to Mary's. We can demonstrate such a transaction in SQL as follows:

```sql {.line-numbers}
START TRANSACTION;
UPDATE account SET balance = balance - 50 WHERE owner = 'Tom';
UPDATE account SET balance = balance + 50 WHERE owner = 'Mary';
COMMIT;
```

This is a very simplified transaction. In fact, there can also be a SELECT statement to read Tom's balance before making the transfer to guarantee that he has enough money to do so. The statements inside a transaction can also access and modify the data at different scales.

Anyway, the database management system (DBMS) should (and they tried to) guarantee that such transactions are ACID compliant. And by ACID compliance, I mean that it should satisfy 4 properties: **A**tomicity, **C**onsistency, **I**solation, and **D**urability.

In the scope of this overview blog post, I shall try to briefly explain those four concepts.

### Atomicity

A transaction is called atomic when it never occurs partially. When Tom transfers $50 to Mary, either both the UPDATE statements above are executed, or none of them is executed at all. There cannot be the case when Tom's account got subtracted $50, but Mary's account does not change.

Remember that a transaction is not guaranteed to be successfully executed. If it fails due to some reason, it must undo all the previous changes (rollback) before exiting. Anything between the BEGIN and COMMIT statements should be atomic.

### Consistency

It's easier to define the consistency of the data. When all the necessary constraints (e.g. uniqueness, range of values, etc.) of our data are satisfied. Specifically, in the beginning, when our database is empty, it can be considered as a consistent state.

Imagine we have a special camera that can capture the data at that time of the database (and let's call it a snapshot instead of a photo). Then, someone begins a transaction, making some operations on our data, and commits it. After that, we take another snapshot. The consistency property simply means that if the initial snapshot is consistent, then the snapshot after the transaction is executed is also consistent.

Up to this point, we can view transactions as ways to carry our data from a consistent state to another consistent state.

### Isolation

The level of isolation measures how much concurrent transactions can interfere with each other. Ideally, two isolated transactions that are running concurrently should not affect each other. However, as we see, this is often not the case.

We know that whenever we have concurrency, we need to deal with race conditions. To a certain extent, DBMS also suffers from race conditions between transactions. Those issues are called read phenomena, and different isolation levels will try to resolve a couple of these phenomena.

![](./Database-Transaction-Isolation-Level-4-Part-Series/2023-02-04-19-52-01.png)

This is also the focus of this series. In the next posts, we will cover 4 isolation levels, namely, READ UNCOMMITTED, READ COMMITTED, REPEATABLE READ, and SERIALIZABLE.

### Durability

What does it mean durable? It means "last for a long time". Data stored in RAM is not durable, and data stored in the hard disk is more durable. Most DBMSs try to guarantee that successful transactions will survive permanently, and by survive I mean its effects on the data will never be lost, despite system crashes. This is often implemented by certain log and recovery mechanisms.

ACID, in some way, is not separated from each other. They are related and support each other. For example, one of the situations we might encounter with the SERIALIZABLE isolation level is deadlock. And when a deadlock occurs, we expect that the transaction is rolled back properly.

That's it. We will cover dirty read and two first isolation levels next time.

## Part II: Read Uncommitted and Read Committed

First, we initialize the **account** table with some records as follows. I use MySQL to demonstrate all four isolation levels. The main concepts still apply for other RDBMS.

```sql {.line-numbers}
> describe account;
+---------+-------------+------+-----+---------+-------+
| Field   | Type        | Null | Key | Default | Extra |
+---------+-------------+------+-----+---------+-------+
| owner   | varchar(50) | NO   | PRI | NULL    |       |
| balance | int         | YES  |     | NULL    |       |
+---------+-------------+------+-----+---------+-------+
2 rows in set (0.03 sec)

> select * from account;
+-------+---------+
| owner | balance |
+-------+---------+
| Mary  |     210 |
| Tom   |     200 |
+-------+---------+
2 rows in set (0.00 sec)
```

In fact, **owner** should not be chosen as a primary key. However, for demonstration, let's simplify our schema that way.

### Read Uncommitted

This isolation level permits the transaction to read even the uncommitted data. Let's see what does it mean. We open two connections on terminals A and B, respectively. Then, apply the following command to set the isolation level to READ UNCOMMITTED.

```sql {.line-numbers}
:: BOTH TERMINALS
> set session transaction isolation level read uncommitted;
Query OK, 0 rows affected (0.00 sec)

> select @@transaction_isolation;
+-------------------------+
| @@transaction_isolation |
+-------------------------+
| READ-UNCOMMITTED        |
+-------------------------+
1 row in set (0.00 sec)
```

Now start the new transaction in both terminals. From now on, let's call the transaction in terminal A transaction A, and similarly for transaction B on terminal B.

```sql {.line-numbers}
:: BOTH TERMINALS
> begin;
Query OK, 0 rows affected (0.00 sec)
```

Now, in terminal A, add $50 to Tom's balance, and don't commit this transaction yet.

```sql {.line-numbers}
:: TERMINAL A
> update account set balance = balance + 50 where owner = 'Tom';
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0
```

Now if we take a look at Tom's balance on transaction B, we see that his balance has also increased to $250.

```sql {.line-numbers}
:: TERMINAL B
> select * from account where owner = 'Tom';
+-------+---------+
| owner | balance |
+-------+---------+
| Tom   |     250 |
+-------+---------+
1 row in set (0.00 sec)
```

This phenomenon is called **dirty read**.

Why dirty? You might ask. Well, we know that a transaction carries our data from one consistent state to another consistent state (the C in ACID). However, transaction A has not been committed yet. It means that our transaction has not finished, and probably another UPDATE statement is waiting ahead (say, subtract 50$ from Tom's balance again).

That's the reason why Tom's current balance ($250) is not an "official" value yet. And by allowing other transactions to read such data, we might end up with a wrong condition check during transaction B or even worse, inconsistent data after the transactions have been committed.

Let's roll back both transactions and move on to the second isolation level.

```sql {.line-numbers}
:: BOTH TERMINALS
> rollback;
Query OK, 0 rows affected (0.00 sec)

> select * from account where owner = 'Tom';
+-------+---------+
| owner | balance |
+-------+---------+
| Tom   |     200 |
+-------+---------+
1 row in set (0.00 sec)
```

### Read Committed

With this isolation level, the data being read in our transaction is always guaranteed to be committed. Let's change the isolation level in both terminals to read committed.

```sql {.line-numbers}
:: BOTH TERMINALS
> set session transaction isolation level read committed;
Query OK, 0 rows affected (0.00 sec)

> select @@transaction_isolation;
+-------------------------+
| @@transaction_isolation |
+-------------------------+
| READ-COMMITTED          |
+-------------------------+
1 row in set (0.00 sec)

> begin;
Query OK, 0 rows affected (0.00 sec)
```

If we perform the same dirty read experiment, we will no longer encounter that phenomenon.

```sql {.line-numbers}
:: TERMINAL A
> update account set balance = balance + 50 where owner = 'Tom';
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0
```

```sql {.line-numbers}
:: TERMINAL B
> select * from account where owner = 'Tom';
+-------+---------+
| owner | balance |
+-------+---------+
| Tom   |     200 |
+-------+---------+
1 row in set (0.00 sec)

> select * from account where balance < 220;
+-------+---------+
| owner | balance |
+-------+---------+
| Mary  |     210 |
| Tom   |     200 |
+-------+---------+
2 rows in set (0.00 sec)
```

Here, Tom's balance is still $200. Let's commit transaction A and check the result again.

```sql {.line-numbers}
:: TERMINAL A
> commit;
Query OK, 0 rows affected (0.01 sec)
```

```sql {.line-numbers}
:: TERMINAL B
> select * from account where owner = 'Tom';
+-------+---------+
| owner | balance |
+-------+---------+
| Tom   |     250 |
+-------+---------+
1 row in set (0.00 sec)

> select * from account where balance < 220;
+-------+---------+
| owner | balance |
+-------+---------+
| Mary  |     210 |
+-------+---------+
1 rows in set (0.00 sec)
```

Now, we can have a sigh of relief that the data we read is always clean. But READ COMMITTED is not the highest level of isolation yet. Why? Because changes in one transaction can still interfere with other transactions.

Suppose that you run transaction B on a completely separate machine, without any knowledge about transaction A. You first execute those 2 queries and get some results. A few seconds later, you re-execute those 2 queries and get completely different results. It is not very reasonable behavior.

In other words, those read statements are non-repeatable. The issue with the first SELECT statement is called non-repeatable read, and the issue with the second SELECT statement is called phantom read. Non-repeatable read means that you get two different rows, and phantom read means that you get two different sets of rows.

Therefore, we need a higher isolation level to resolve those two issues. And we will mention it in the next post.

Anyway, we still have one interesting scenario left to consider. When transaction A runs in READ UNCOMMITTED and transaction B runs in READ COMMITTED level, can you guess what will happen?

It turns out that nothing really special happened. Each transaction still follows its principles. Changes by transaction A before commit still cannot be read by transaction B, and A can read the result of any UPDATE statements in B immediately. I shall left the task of verifying to you.

## Part III: Repeatable Read, Consistent Read, and Serialization Anomaly

As I mentioned earlier in the previous part, the READ COMMITTED isolation level does not guarantee that our read results are repeatable. Non-repeatable read and phantom read are the two phenomena that we would resolve in the next isolation level. It is called REPEATABLE READ.

### Repeatable Read

Let me remind you a bit about the example that we used last time for the demonstration.

```sql {.line-numbers}
> describe account;
+---------+-------------+------+-----+---------+-------+
| Field   | Type        | Null | Key | Default | Extra |
+---------+-------------+------+-----+---------+-------+
| owner   | varchar(50) | NO   | PRI | NULL    |       |
| balance | int         | YES  |     | NULL    |       |
+---------+-------------+------+-----+---------+-------+
2 rows in set (0.03 sec)

> select * from account;
+-------+---------+
| owner | balance |
+-------+---------+
| Mary  |     210 |
| Tom   |     200 |
+-------+---------+
2 rows in set (0.00 sec)
```

First, we open two connections to our local MySQL server. REPEATABLE READ is the default isolation level of the InnoDB engine. To verify this, we can run a command to check for the value of the **@@transaction_isolation** variable. In case it has been changed before, we can run the following command to make sure that the isolation level on both sessions is REPEATABLE READ.

```sql {.line-numbers}
:: BOTH TERMINALS
> set session transaction isolation level repeatable read;
Query OK, 0 rows affected (0.00 sec)

> select @@transaction_isolation;
+-------------------------+
| @@transaction_isolation |
+-------------------------+
| REPEATABLE-READ         |
+-------------------------+
1 row in set (0.00 sec)
```

In terminal B, let's re-run the two queries (which cause us some troubles in the READ COMMITTED level).

```sql {.line-numbers}
:: TERMINAL B
> begin;
Query OK, 0 rows affected (0.00 sec)

> select * from account where owner = 'Tom';
+-------+---------+
| owner | balance |
+-------+---------+
| Tom   |     200 |
+-------+---------+
1 row in set (0.00 sec)

> select * from account where balance < 220;
+-------+---------+
| owner | balance |
+-------+---------+
| Mary  |     210 |
| Tom   |     200 |
+-------+---------+
2 rows in set (0.00 sec)
```

Now let's update Tom's account in terminal A. You might be tempted to also check for the dirty read phenomena.

```sql {.line-numbers}
:: TERMINAL A
> begin;
Query OK, 0 rows affected (0.00 sec)

> update account set balance = balance + 50 where owner = 'Tom';
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0
```

```sql {.line-numbers}
:: TERMINAL B
> begin;
Query OK, 0 rows affected (0.00 sec)

> select * from account where owner = 'Tom';
+-------+---------+
| owner | balance |
+-------+---------+
| Tom   |     200 |
+-------+---------+
1 row in set (0.00 sec)

> select * from account where balance < 220;
+-------+---------+
| owner | balance |
+-------+---------+
| Mary  |     210 |
| Tom   |     200 |
+-------+---------+
2 rows in set (0.00 sec)
```

So far so good, no dirty read. Let's commit transaction A and check for the result of those two queries again (in transaction B).

```sql {.line-numbers}
:: TERMINAL A
> commit;
Query OK, 0 rows affected (0.01 sec)
```

```sql {.line-numbers}
:: TERMINAL B
> begin;
Query OK, 0 rows affected (0.00 sec)

> select * from account where owner = 'Tom';
+-------+---------+
| owner | balance |
+-------+---------+
| Tom   |     200 |
+-------+---------+
1 row in set (0.00 sec)

> select * from account where balance < 220;
+-------+---------+
| owner | balance |
+-------+---------+
| Mary  |     210 |
| Tom   |     200 |
+-------+---------+
2 rows in set (0.00 sec)
```

The results are the same as the first time we executed those two queries. We now get rid of non-repeatable read and phantom read.

Notice that if we read the standard definition of the isolation levels, we might see that REPEATABLE READ only guarantees to eliminate non-repeatable phenomena, while allowing phantom read to occur. However, some RDBMS (like MySQL and PostgreSQL) choose to also eliminate phantom read in REPEATABLE READ isolation level.

In short, with MySQL, REPEATABLE READ guarantee that our reads are consistent. However, there are a couple of things that we need to notice here.

### Consistent Read

First, I want to emphasize that "our reads are consistent". It means that when we read the row for the first time in our transaction, the DBMS will take a snapshot of that row. Then, **as long as we didn't make any change in that transaction**, later read results of that row will stay the same as that snapshot.

However, what if we **make some changes in that transaction**? Let's say we subtract $50 from Mary's balance in transaction B.

```sql {.line-numbers}
:: TERMINAL B
mysql> update account set balance = balance - 50 where owner = 'Mary';
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> select * from account where balance < 220;
+-------+---------+
| owner | balance |
+-------+---------+
| Mary  |     160 |
| Tom   |     200 |
+-------+---------+
2 rows in set (0.00 sec)
```

As we can see, Mary's balance changed to $160, while Tom's balance remains at $200. We can see one interesting property of this isolation level: the SELECT statement might return a set of rows that **never exists** in the database.

Before transaction A, those two balance values (on-disk) should be ($210, $200). After transaction A, it should be ($210, $250). And after the update in transaction B, it should be ($160, $250). The result ($160, $200) that we see is just a combination of the real Mary's balance and the snapshot of Tom's balance.

### Serialization Anomaly

So we can get the feeling of what is called "consistent read" in REPEATABLE READ. Let me ask you one more question. If we increase Tom's balance by $50 in transaction B, what would be Tom's balance after we run the SELECT statement again?

Would it be $250? Or would it be $300?

```sql {.line-numbers}
:: TERMINAL B
mysql> update account set balance = balance + 50 where owner = 'Tom';
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> select * from account where owner = 'Tom';
+-------+---------+
| owner | balance |
+-------+---------+
| Tom   |     300 |
+-------+---------+
3 rows in set (0.00 sec)
```

It was $300. So the balance value that got increased is the actual balance value that resides on the disk. Let me summarize what's happening here:

- In transaction B, we read Tom's balance and know that he has $200.
- Then we increase his balance by $50, and when we read his balance again, he suddenly has $300!!!

Our transaction somehow still gets interfered with by other transactions.

And if you don't see that it's big trouble. Let's think about this scenario (I changed the number to emphasize how bad it can be):

- I want to subtract $50 from Tom's account if he has enough money
- I open a transaction, run a SELECT statement and realize that he has $100
- At this very moment, someone opens a transaction, check and see that Tom has $100, then he subtracts $60 from Tom's balance and commits immediately
- Since I've checked that Tom got $100, I proceed to subtract $50 from this account
- Now, his on-disk balance value is -$50, which is an inconsistent state

This is a serialization anomaly. It means that transactions A & B interfere and result in an anomaly state (a state that cannot be achieved if we run A before B or B before A).

This is also the last phenomenon that we need to solve. As long as we can guarantee that there is no serialization anomaly, we can confidently say that our transactions are isolated.

The solution turns out to be very familiar: we need to apply a certain kind of locking mechanism to our read/write operations. Anyway, we will discuss the solution more in the next post, along with the last isolation level.

## Part IV: Locking Mechanism, Serializable, and Deadlock

In the post about repeatable read isolation level, I've mentioned the serialization anomaly problem. Despite having consistent read results, the writing operations can introduce unexpected behaviors or even inconsistent data states after our transaction got committed.

The last transaction isolation level is called SERIALIZABLE, and it can be used to protect our transactions from being interfered with by others when running concurrently. But before going through this isolation level, I'd like to describe the approach that MySQL uses to eliminate the interference of UPDATE statements into our read results.

### Locking mechanism

First, we might need to go through the basics of [shared lock and exclusive lock](https://dev.mysql.com/doc/refman/8.0/en/innodb-locking.html#innodb-shared-exclusive-locks). Those two locks are respectively similar to read lock and write lock in the famous readers-writers problem.

Simply put, if a transaction is holding a shared lock on a row, other transactions can only acquire the shared lock on that row, but **not the exclusive lock**. Meanwhile, if a transaction is holding an exclusive lock on a row, then no other transactions can acquire **any kind of lock** on that row.

Let's continue with the familiar example of Tom's balance in the **account** table.

```sql {.line-numbers}
> select @@transaction_isolation;
+-------------------------+
| @@transaction_isolation |
+-------------------------+
| REPEATABLE-READ         |
+-------------------------+
1 row in set (0.00 sec)

> describe account;
+---------+-------------+------+-----+---------+-------+
| Field   | Type        | Null | Key | Default | Extra |
+---------+-------------+------+-----+---------+-------+
| owner   | varchar(50) | NO   | PRI | NULL    |       |
| balance | int         | YES  |     | NULL    |       |
+---------+-------------+------+-----+---------+-------+
2 rows in set (0.03 sec)

> select * from account;
+-------+---------+
| owner | balance |
+-------+---------+
| Mary  |     160 |
| Tom   |     300 |
+-------+---------+
2 rows in set (0.00 sec)
```

We are in the REPEATABLE READ isolation level. For now, let's just stick to one terminal, and start the transaction that adds $50 to Mary's balance. However, do not commit this transaction at the moment, because we are going to see what happened after we update that row.

```sql {.line-numbers}
> begin;
Query OK, 0 rows affected (0.01 sec)

> update account set balance = balance + 50 where owner = 'Mary';
Query OK, 1 row affected (0.04 sec)
Rows matched: 1  Changed: 1  Warnings: 0
```

Now, let's make a SELECT statement to query what rows have been locked by our engine.

```sql {.line-numbers}
> select * from performance_schema.data_locks\G
*************************** 1. row ***************************
               ...
          OBJECT_NAME: account
               ...
            LOCK_TYPE: TABLE
            LOCK_MODE: IX
          LOCK_STATUS: GRANTED
            LOCK_DATA: NULL
*************************** 2. row ***************************
               ...
          OBJECT_NAME: account
               ...
            LOCK_TYPE: RECORD
            LOCK_MODE: X,REC_NOT_GAP
          LOCK_STATUS: GRANTED
            LOCK_DATA: 'Mary'
2 rows in set (0.00 sec)
```

I've added the suffix "\G" to the query to make the result is rendered in vertical format. Ignoring some irrelevant fields, I want you to notice that there are currently two locks that are active in our database.

The first lock is the TABLE lock, and it is of mode IX (which stands for **intention exclusive**). It is used to indicate that our **account** table will require a record exclusive lock. And that exclusive lock is also the second entry in the retrieved results. It is of mode X (which stands for **exclusive**), and the level of granularity is RECORD.

Let's commit the transaction and check the **performance_schema** table again.

```sql {.line-numbers}
> commit;
Query OK, 0 rows affected (0.01 sec)

> SELECT * from performance_schema.data_locks\G
Empty set (0.00 sec)
```

The locks are now released. From this, we can have a sense that whenever we make an update (or a write) on the data, our transaction will acquire an exclusive lock on the rows that we updated. And the locks are only released when we commit (or rollback) our transaction.

What happened if another transaction also wants to acquire the exclusive lock on that row (say, by trying to subtract $60 from Mary's balance)? The answer is: that transaction will be **pending**, either until **timeout** or the **exclusive lock is released by our transaction**. Feel free to verify my statement.

"But wait," you might say. "We've tried to read the row that got updated in the examples of dirty read, non-repeatable read, and phantom read. However, you said that shared lock is similar to the concept of read lock. Why we can still acquire the shared lock to read the exclusive locked records?"

Well, in fact, our transaction cannot acquire the shared lock on the records that have been locked before by the exclusive lock. What happened is the SELECT statement **does not** apply the shared lock (by default) to the records in the result. Our transaction only acquires the shared lock when our SELECT statement ends with two words: FOR SHARE.

Let's open two transactions on two separate connections to test what I've just said.

```sql {.line-numbers}
:: TERMINAL A
> begin;
Query OK, 0 rows affected (0.00 sec)

mysql> select * from account where owner = 'Tom' for share;
+-------+---------+
| owner | balance |
+-------+---------+
| Tom   |     300 |
+-------+---------+
1 row in set (0.00 sec)

> select * from performance_schema.data_locks\G
*************************** 1. row ***************************
               ...
          OBJECT_NAME: account
               ...
            LOCK_TYPE: TABLE
            LOCK_MODE: IS
          LOCK_STATUS: GRANTED
            LOCK_DATA: NULL
*************************** 2. row ***************************
               ...
          OBJECT_NAME: account
               ...
            LOCK_TYPE: RECORD
            LOCK_MODE: S,REC_NOT_GAP
          LOCK_STATUS: GRANTED
            LOCK_DATA: 'Tom'
2 rows in set (0.01 sec)
```

IS and S stand for intention shared and shared, respectively.

Now, we can try updating Tom's balance in another transaction and see if we can still get the result immediately.

```sql {.line-numbers}
:: TERMINAL B
mysql> begin;
Query OK, 0 rows affected (0.00 sec)

mysql> update account set balance = balance + 50 where owner = 'Tom';
...
```

It's pending. You can rollback (or commit) transaction A and check to see if the update got executed immediately.

There are other modes of lock (say, REC_NOT_GAP). But having a grasp of the X lock and S lock is enough to talk about the last isolation level.

### Serializable

For your convenience, I will repeat the anomaly scenario we encountered in the previous post:

- I want to subtract $50 from Tom's account if he has enough money
- I open a transaction, run a SELECT statement, and realize that he has $100
- At this very moment, someone opens a transaction, check and see that Tom has $100, then he subtracts $60 from Tom's balance and commits immediately
- Since I've checked that Tom got $100, I proceed to subtract $50 from this account
- Now, his on-disk balance value is -$50, which is an inconsistent state

The main cause of this issue is that someone can still update Tom's account after I've read it. Imagine if my SELECT statement is replaced by the SELECT FOR SHARE statement, what would happen?

After step 2, Tom's row got locked (by a shared lock hold by my transaction). Then, as long as my transaction is still in progress, I can be sure that no one can update Tom's row anymore. And we can get rid of the write interferences.

That's exactly what the SERIALIZABLE isolation level does. It implicitly replaces all SELECT statements by SELECT FOR SHARE, and we are free from serialization anomalies.

Once again, we can try to see if the transaction is SERIALIZABLE level actually acquires shared lock on normal SELECT statements (remember to rollback or commit all previous transactions to make sure that Tom's row got free).

```sql {.line-numbers}
> set session transaction isolation level serializable;
Query OK, 0 rows affected (0.01 sec)

> select @@transaction_isolation;
+-------------------------+
| @@transaction_isolation |
+-------------------------+
| SERIALIZABLE            |
+-------------------------+
1 row in set (0.00 sec)

> begin;
Query OK, 0 rows affected (0.00 sec)

> select * from account where owner = 'Tom';
+-------+---------+
| owner | balance |
+-------+---------+
| Tom   |     150 |
+-------+---------+
1 row in set (0.00 sec)

> select * from performance_schema.data_locks\G
*************************** 1. row ***************************
               ...
          OBJECT_NAME: account
               ...
            LOCK_TYPE: TABLE
            LOCK_MODE: IS
          LOCK_STATUS: GRANTED
            LOCK_DATA: NULL
*************************** 2. row ***************************
               ...
          OBJECT_NAME: account
               ...
            LOCK_TYPE: RECORD
            LOCK_MODE: S,REC_NOT_GAP
          LOCK_STATUS: GRANTED
            LOCK_DATA: 'Tom'
2 rows in set (0.00 sec)
```

As we can see, our transaction did acquire the shared lock on the SELECT statement. We now get rid of dirty read, non-repeatable read, phantom read, and even serialization anomaly. However, it doesn't mean that SERIALIZABLE is the best choice for all situations.

### Deadlock

If you have some experience with locking before in the OS courses, or when trying to make a multithread application, you probably have heard of this issue. Whenever there is a lock, there is a chance that we might encounter deadlocks.

Imagine this scenario:

Transaction A reads Tom's account (acquire the shared lock on Tom's row)
Transaction B reads Tom's account (acquire the shared lock on Tom's row, remember shared lock is shareable)
Transaction A updated Tom's account and got pending, waiting for transaction B (since it has been locked by the shared lock of transaction B)
Transaction B updated Tom's account and got pending, waiting for transaction A (for the same reason)
Two transactions wait for each other. Neither transaction can commit or rollback, we are in a deadlock situation. Luckily, our DBMS is smart enough to detect it in advance and resolve the deadlock. Typically, some transaction needs to roll back to get rid of the locks.

You might ask: "If the SERIALIZABLE transaction is free from dirty read, non-repeatable read, phantom read, and serialization anomaly, then why it's not the default isolation level? Why do people still even use other isolation levels?"

One of the reasons I can think of is the deadlock. Once our transaction got rollback due to deadlock, it should be executed again. Having to re-execute transactions decreases our application performance significantly. Therefore, for some scenarios, where read phenomena are not likely to happen or not cause some serious issues, people can tolerate it and choose a lower isolation level to increase application performance.

It's also the end of the isolation levels series. We went through the basics of the ACID properties, four isolation levels, and how they resolve the read phenomena. I also include some examples in MySQL.

Hope you guys find this helpful and continue to explore other interesting topics of DBMS. You can also lookup the documentation of other DB systems to see how they implement the isolation levels (like [PostgreSQL](https://www.postgresql.org/docs/9.5/transaction-iso.html) and [Oracle](https://docs.oracle.com/cd/B13789_01/server.101/b10743/consist.htm)). There is a slight variation but the fundamental ideas are the same.