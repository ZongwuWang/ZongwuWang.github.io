---
title: ARM汇编伪指令
abstract: 'Welcome to my blog, enter password to read.'
message: 'Welcome to my blog, enter password to read.'
date: 2022-07-05 15:49:19
tags:
- ISA
- 伪指令
- 汇编
- ARM
- Pseudocode
categories: 计算机体系架构
---

<div id="article_content" class="article_content clearfix">
        <link rel="stylesheet" href="https://csdnimg.cn/release/blogv2/dist/mdeditor/css/editerView/ck_htmledit_views-bbac9290cd.css">
                <div id="content_views" class="markdown_views prism-atom-one-light" style="user-select: auto;">
                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <p>在<a href="https://so.csdn.net/so/search?q=ARM&amp;spm=1001.2101.3001.7020" target="_blank" class="hl hl-1" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.7020&quot;,&quot;dest&quot;:&quot;https://so.csdn.net/so/search?q=ARM&amp;spm=1001.2101.3001.7020&quot;}" data-tit="ARM" data-pretit="arm">ARM</a>汇编语言程序里，有一些特殊指令助记符，这些助记符与指令系统的助记符不同，没有相对应的操作码，通常称这些特殊指令助记符为伪指令，他们所完成 的操作称为伪操作。伪指令在源程序中的作用是为完成汇编程序作各种准备工作的，这些伪指令仅在汇编过程中起作用，一旦汇编结束，伪指令的使命就完成。</p> 
<p>在ARM 的汇编程序中，有如下几种<a href="https://so.csdn.net/so/search?q=%E4%BC%AA%E6%8C%87%E4%BB%A4&amp;spm=1001.2101.3001.7020" target="_blank" class="hl hl-1" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.7020&quot;,&quot;dest&quot;:&quot;https://so.csdn.net/so/search?q=%E4%BC%AA%E6%8C%87%E4%BB%A4&amp;spm=1001.2101.3001.7020&quot;}" data-tit="伪指令" data-pretit="伪指令">伪指令</a>：</p> 
<ul><li>符号定义伪指令</li><li>数据定义伪指令</li><li>汇编控制伪指令</li><li>宏伪指令</li><li>其他伪指令</li></ul> 
<p>ARM汇编指令参看： <a href="https://blog.csdn.net/chengbaojin/article/details/109401708" target="_blank">https://blog.csdn.net/chengbaojin/article/details/109401708</a></p> 
<h1><a name="t0"></a><a id="_Symbol_Definition_11"></a>一 符号定义（<a href="https://so.csdn.net/so/search?q=Symbol&amp;spm=1001.2101.3001.7020" target="_blank" class="hl hl-1" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.7020&quot;,&quot;dest&quot;:&quot;https://so.csdn.net/so/search?q=Symbol&amp;spm=1001.2101.3001.7020&quot;}" data-tit="Symbol" data-pretit="symbol">Symbol</a> Definition）伪指令</h1> 
<p>符号定义伪指令用于定义ARM汇编程序中的变量、对变量赋值以及定义寄存器的别名等操作。</p> 
<p>常见的符号定义伪指令有如下几种：<br> — 用于定义全局变量的GBLA、GBLL和GBLS<br> — 用于定义局部变量的LCLA、LCLL和LCLS<br> — 用于对变量赋值的SETA、SETL和SETS<br> — 为通用寄存器列表定义名称的RLIST</p> 
<h2><a name="t1"></a><a id="1_GBLAGBLL_GBLS_21"></a>1 GBLA、GBLL 和GBLS</h2> 
<p>语法格式：</p> 
<pre data-index="0" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;"><span class="token function">GBLA</span><span class="token punctuation">(</span>GBLL或GBLS<span class="token punctuation">)</span> 全局变量名    
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li></ul></pre> 
<p>GBLA、GBLL和GBLS伪指令用于定义一个ARM程序中的全局变量，并将其初始化。其中：</p> 
<ul><li>GBLA 伪指令用于定义一个全局的数字变量，并初始化为0；</li><li>GBLL 伪指令用于定义一个全局的逻辑变量，并初始化为F（假）；</li><li>GBLS 伪指令用于定义一个全局的字符串变量，并初始化为空；</li></ul> 
<p>由于以上三条伪指令用于定义全局变量，因此在整个程序范围内变量名必须唯一。</p> 
<p><strong>使用示例：</strong></p> 
<pre data-index="1" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">GBLA Test1            	<span class="token punctuation">;</span>定义一个全局的数字变量，变量名为 Test1。    
Test1 SETA <span class="token number">0xaa</span>    		<span class="token punctuation">;</span>将该变量赋值为<span class="token number">0xaa</span>。    
GBLL Test2         		<span class="token punctuation">;</span>定义一个全局的逻辑变量，变量名为 Test2。    
Test2 SETL <span class="token punctuation">{<!-- --></span>TRUE<span class="token punctuation">}</span> 		<span class="token punctuation">;</span>将该变量赋值为真。    
GBLS Test3              <span class="token punctuation">;</span>定义一个全局的字符串变量，变量名为 Test3。    
Test3 SETS <span class="token string">"Testing"</span>	<span class="token punctuation">;</span>将该变量赋值为"Testing”。  
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li><li style="color: rgb(153, 153, 153);">2</li><li style="color: rgb(153, 153, 153);">3</li><li style="color: rgb(153, 153, 153);">4</li><li style="color: rgb(153, 153, 153);">5</li><li style="color: rgb(153, 153, 153);">6</li></ul></pre> 
<h2><a name="t2"></a><a id="2_LCLALCLLLCLS_43"></a>2 LCLA、LCLL和LCLS</h2> 
<p>语法格式：</p> 
<pre data-index="2" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;"><span class="token function">LCLA</span><span class="token punctuation">(</span>LCLL或LCLS<span class="token punctuation">)</span> 局部变量名    
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li></ul></pre> 
<p>LCLA、LCLL和LCLS伪指令用于定义一个ARM程序中的局部变量，并将其初始化。其中：</p> 
<ul><li>LCLA伪指令用于定义一个局部的数字变量，并初始化为0；</li><li>LCLL伪指令用于定义一个局部的逻辑变量，并初始化为F（假）；</li><li>LCLS伪指令用于定义一个局部的字符串变量，并初始化为空；</li></ul> 
<p>以上三条伪指令用于声明局部变量，在其作用范围内变量名必须唯一。</p> 
<p><strong>使用示例：</strong></p> 
<pre data-index="3" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">LCLA Test4             	<span class="token punctuation">;</span>声明一个局部的数字变量，变量名为Test4。  
Test4 SETA <span class="token number">0xaa</span>    		<span class="token punctuation">;</span>将该变量赋值为<span class="token number">0xaa</span>。   
LCLL Test5              <span class="token punctuation">;</span>声明一个局部的逻辑变量，变量名为Test5。    
Test5 SETL <span class="token punctuation">{<!-- --></span>TRUE<span class="token punctuation">}</span> 		<span class="token punctuation">;</span>将该变量赋值为真。    
LCLS Test6              <span class="token punctuation">;</span>定义一个局部的字符串变量，变量名为Test6。    
Test6 SETS <span class="token string">"Testing"</span> 	<span class="token punctuation">;</span>将该变量赋值为 <span class="token string">"Testing"</span>。   
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li><li style="color: rgb(153, 153, 153);">2</li><li style="color: rgb(153, 153, 153);">3</li><li style="color: rgb(153, 153, 153);">4</li><li style="color: rgb(153, 153, 153);">5</li><li style="color: rgb(153, 153, 153);">6</li></ul></pre> 
<h2><a name="t3"></a><a id="3_SETASETL_SETS_67"></a>3 SETA、SETL 和SETS</h2> 
<p>语法格式：</p> 
<pre data-index="4" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">变量名 <span class="token function">SETA</span><span class="token punctuation">(</span>SETL或SETS<span class="token punctuation">)</span> 表达式    
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li></ul></pre> 
<p>伪指令SETA、SETL和SETS用于给一个已经定义的全局变量或局部变量赋值。</p> 
<ul><li>SETA伪指令用于给一个数学变量赋值；</li><li>SETL伪指令用于给一个逻辑变量赋值；</li><li>SETS伪指令用于给一个字符串变量赋值；</li></ul> 
<p>其中，变量名为已经定义过的全局变量或局部变量，表达式为将要赋给变量的值。</p> 
<p><strong>使用示例：</strong></p> 
<pre data-index="5" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">LCLA Test3              <span class="token punctuation">;</span>声明一个局部的数字变量，变量名为 Test3。    
Test3 SETA <span class="token number">0xaa</span>     	<span class="token punctuation">;</span>将该变量赋值为<span class="token number">0xaa</span>。    
LCLL Test4            	<span class="token punctuation">;</span>声明一个局部的逻辑变量，变量名为 Test4。    
Test4 SETL <span class="token punctuation">{<!-- --></span>TRUE<span class="token punctuation">}</span> 		<span class="token punctuation">;</span>将该变量赋值为真。   
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li><li style="color: rgb(153, 153, 153);">2</li><li style="color: rgb(153, 153, 153);">3</li><li style="color: rgb(153, 153, 153);">4</li></ul></pre> 
<h2><a name="t4"></a><a id="4_RLIST_89"></a>4 RLIST</h2> 
<p>语法格式：</p> 
<pre data-index="6" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">名称 RLIST <span class="token punctuation">{<!-- --></span>寄存器列表<span class="token punctuation">}</span>    
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li></ul></pre> 
<p>RLIST伪指令可用于对一个通用寄存器列表定义名称，使用该伪指令定义的名称可在ARM指令LDM/STM中使用。在LDM/STM指令中，列表中的寄存器访问次序为根据寄存器的编号由低到高，而与列表中的寄存器排列次序无关。</p> 
<p><strong>使用示例：</strong></p> 
<pre data-index="7" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">RegList RLIST <span class="token punctuation">{<!-- --></span>R0<span class="token operator">-</span>R5<span class="token punctuation">,</span> R8<span class="token punctuation">,</span> R10<span class="token punctuation">}</span> <span class="token punctuation">;</span>将寄存器列表名称定义为RegList，可在ARM指令LDM<span class="token operator">/</span>STM中通过该名称访问寄存器列表。  
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li></ul></pre> 
<h1><a name="t5"></a><a id="_Data_Definition_102"></a>二 数据定义（Data Definition）伪指令</h1> 
<p>数据定义伪指令一般用于为特定的数据分配存储单元，同时可完成已分配存储单元的初始化。<br> 常见的数据定义伪指令有如下几种：</p> 
<ul><li>DCB 用于分配一片连续的字节存储单元并用指定的数据初始化。</li><li>DCW(DCWU)用于分配一片连续的半字存储单元并用指定的数据初始化。</li><li>DCD(DCDU)用于分配一片连续的字存储单元并用指定的数据初始化。</li><li>DCFD(DCFDU)用于为双精度的浮点数分配一片连续的字存储单元并用指定的数据初始化。</li><li>DCFS(DCFSU)用于为单精度的浮点数分配一片连续的字存储单元并用指定的数据初始化。</li><li>DCQ(DCQU)用于分配一片以8个字节(双字)为单位的连续的存储单元并用指定的数据初始化。</li><li>SPACE 用于分配一片连续的存储单元。</li><li>MAP 用于定义一个结构化的内存表首地址。</li><li>FIELD 用于定义一个结构化的内存表的数据域。</li></ul> 
<h2><a name="t6"></a><a id="1_DCB_116"></a>1 DCB</h2> 
<p>语法格式：</p> 
<pre data-index="8" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">标号 DCB 表达式   
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li></ul></pre> 
<p>DCB伪指令用于分配一片连续的字节存储单元并用伪指令中指定的表达式初始化。其中，表达式可以为0～255的数字或字符串。DCB 也可用"="代替。</p> 
<p><strong>使用示例：</strong></p> 
<pre data-index="9" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">Str DCB <span class="token string">"This is a test"</span>	<span class="token punctuation">;</span>分配一片连续的字节存储单元并初始化。 
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li></ul></pre> 
<h2><a name="t7"></a><a id="2_DCWDCWU_130"></a>2 DCW（或DCWU）</h2> 
<p>语法格式：</p> 
<pre data-index="10" class="prettyprint" style="user-select: auto;"><code class="has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">标号 DCW(或DCWU) 表达式    
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li></ul></pre> 
<p>DCW(或DCWU)伪指令用于分配一片连续的半字存储单元并用伪指令中指定的表达式初始化。其中，表达式可以为程序标号或数字表达式。用DCW分配的字存储单元是半字对齐的，而用DCWU分配的字存储单元并不严格半字对齐。</p> 
<p><strong>使用示例：</strong></p> 
<pre data-index="11" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">DataTest DCW <span class="token number">1</span><span class="token punctuation">,</span> <span class="token number">2</span><span class="token punctuation">,</span> <span class="token number">3</span>	<span class="token punctuation">;</span>分配一片连续的半字存储单元并初始化。    
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li></ul></pre> 
<h2><a name="t8"></a><a id="3_DCDDCDU_142"></a>3 DCD(或DCDU)</h2> 
<p>语法格式：</p> 
<pre data-index="12" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">标号 <span class="token function">DCD</span><span class="token punctuation">(</span>或DCDU<span class="token punctuation">)</span>	表达式    
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li></ul></pre> 
<p>DCD（或DCDU）伪指令用于分配一片连续的字存储单元并用伪指令中指定的表达式初始化。其中，表达式可以为程序标号或数字表达式。DCD也可用"&amp;” 代替。 用DCD分配的字存储单元是字对齐的，而用DCDU分配的字存储单元并不严格字对齐。</p> 
<p><strong>使用示例：</strong></p> 
<pre data-index="13" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">DataTest DCD <span class="token number">4</span><span class="token punctuation">,</span> <span class="token number">5</span><span class="token punctuation">,</span> <span class="token number">6</span>	<span class="token punctuation">;</span>分配一片连续的字存储单元并初始化。 
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li></ul></pre> 
<h2><a name="t9"></a><a id="4_DCFDDCFDU_155"></a>4 DCFD(或DCFDU)</h2> 
<p>语法格式：</p> 
<pre data-index="14" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">标号 <span class="token function">DCFD</span><span class="token punctuation">(</span>或DCFDU<span class="token punctuation">)</span> 表达式   
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li></ul></pre> 
<p>DCFD(或DCFDU)伪指令用于为双精度的浮点数分配一片连续的字存储单元并用伪指令中指定的表达式初始化。每个双精度的浮点数占据两个字单元。用 DCFD分配的字存储单元是字对齐的，而用DCFDU分配的字存储单元并不严格字对齐。</p> 
<p>**使用示例： **</p> 
<pre data-index="15" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">FDataTest DCFD <span class="token number">2E115</span><span class="token punctuation">,</span> <span class="token operator">-</span><span class="token number">5E7</span> <span class="token punctuation">;</span>分配一片连续的字存储单元并初始化 为指定的双精度数。    
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li></ul></pre> 
<h2><a name="t10"></a><a id="5_DCFSDCFSU_167"></a>5 DCFS(或DCFSU)</h2> 
<p>语法格式：</p> 
<pre data-index="16" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">标号 <span class="token function">DCFS</span><span class="token punctuation">(</span>或DCFSU<span class="token punctuation">)</span> 表达式    
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li></ul></pre> 
<p>DCFS(或DCFSU)伪指令用于为单精度的浮点数分配一片连续的字存储单元并用伪指令中指定的表达式初始化。每个单精度的浮点数占据一个字单元。用 DCFS分配的字存储单元是字对齐的，而用DCFSU分配的字存储单元并不严格字对齐。</p> 
<p><strong>使用示例：</strong></p> 
<pre data-index="17" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">FDataTest DCFS <span class="token number">2E5</span><span class="token punctuation">,</span> <span class="token operator">-</span><span class="token number">5E-7</span>	<span class="token punctuation">;</span>分配一片连续的字存储单元并初始化为指定的单精度数。    
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li></ul></pre> 
<h2><a name="t11"></a><a id="6_DCQDCQU_178"></a>6 DCQ(或DCQU）</h2> 
<p>语法格式：</p> 
<pre data-index="18" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">标号 <span class="token function">DCQ</span><span class="token punctuation">(</span>或DCQU<span class="token punctuation">)</span>	表达式   
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li></ul></pre> 
<p>DCQ(或DCQU)伪指令用于分配一片以8个字节(双字)为单位的连续存储区域并用伪指令中指定的表达式 初始化。用DCQ分配的存储单元是字对齐的，而用DCQU 分配的存储单元并不严格字对齐。</p> 
<p><strong>使用示例：</strong></p> 
<pre data-index="19" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">DataTest DCQ <span class="token number">100</span>	<span class="token punctuation">;</span>分配一片连续的存储单元并初始化为指定的值。 
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li></ul></pre> 
<h2><a name="t12"></a><a id="7_SPACE_191"></a>7 SPACE</h2> 
<p>语法格式：</p> 
<pre data-index="20" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">标号 SPACE 表达式    
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li></ul></pre> 
<p>SPACE伪指令用于分配一片连续的存储区域并初始化为0。其中，表达式为要分配的字节数.SPACE也可用"％"代替。</p> 
<p><strong>使用示例：</strong></p> 
<pre data-index="21" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">DataSpace SPACE <span class="token number">100</span>		<span class="token punctuation">;</span>分配连续<span class="token number">100</span>字节的存储单元并初始化为<span class="token number">0</span>
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li></ul></pre> 
<h2><a name="t13"></a><a id="8_MAP_204"></a>8 MAP</h2> 
<p>语法格式：</p> 
<pre data-index="22" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">MAP 表达式 <span class="token punctuation">{<!-- --></span>基址寄存器<span class="token punctuation">}</span>    
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li></ul></pre> 
<p>MAP伪指令用于定义一个结构化的内存表的首地址。MAP也可用"＾"代替。表达式可以为程序中的标号或数学表达式，基址寄存器为可选项，当基址寄存器选项不存在时，表达式的值即为内存表的首地址，当该选项存在时，内存表的首地址为表达式的值与基址寄存器的和。MAP伪指令通常与FIELD伪指令配合使用来定义结构化的内存表。</p> 
<p><strong>使用示例：</strong></p> 
<pre data-index="23" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">MAP <span class="token number">0x100</span><span class="token punctuation">,</span> R0	<span class="token punctuation">;</span>定义结构化内存表首地址的值为<span class="token number">0x100</span>＋R0
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li></ul></pre> 
<h2><a name="t14"></a><a id="9_FILED_216"></a>9 FILED</h2> 
<p>语法格式：</p> 
<pre data-index="24" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">标号 FIELD 表达式  
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li></ul></pre> 
<p>FIELD伪指令用于定义一个结构化内存表中的数据域。FILED 也可用"#"代替。表达式的值为当前数据域在内存表中所占的字节数。FIELD伪指令常与MAP伪指令配合使用来定义结构化的内存表。MAP伪指令定义内存表的首地址，FIELD伪指令定义内存表中的各个数据域，并可以为每个数据域指定一个标号供其他的指令引用。注意MAP和FIELD伪指令仅用于定义数据结构，并不实际分配存储单元。</p> 
<p><strong>使用示例：</strong></p> 
<pre data-index="25" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">MAP <span class="token number">0x100</span>		<span class="token punctuation">;</span>定义结构化内存表首地址的值为<span class="token number">0x100</span>。    
A FIELD <span class="token number">16</span>		<span class="token punctuation">;</span>定义A的长度为<span class="token number">16</span>字节，位置为<span class="token number">0x100</span>。    
B FIELD <span class="token number">32</span>		<span class="token punctuation">;</span>定义B的长度为<span class="token number">32</span>字节，位置为<span class="token number">0x110</span>。    
S FIELD <span class="token number">256</span>		<span class="token punctuation">;</span>定义S的长度为<span class="token number">256</span>字节，位置为<span class="token number">0x130</span>。  
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li><li style="color: rgb(153, 153, 153);">2</li><li style="color: rgb(153, 153, 153);">3</li><li style="color: rgb(153, 153, 153);">4</li></ul></pre> 
<h1><a name="t15"></a><a id="_Assembly_Control_232"></a>三 汇编控制(Assembly Control)伪指令</h1> 
<p>汇编控制伪指令用于控制汇编程序的执行流程，常用的汇编控制伪指令包括以下几条：</p> 
<ul><li>IF、ELSE、ENDIF</li><li>WHILE、WEND</li><li>MACRO、MEND</li><li>MEXIT</li></ul> 
<h2><a name="t16"></a><a id="1_IFELSEENDIF_238"></a>1 IF/ELSE/ENDIF</h2> 
<p>语法格式：</p> 
<pre data-index="26" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">IF 逻辑表达式    
指令序列 <span class="token number">1</span>    
ELSE    
指令序列 <span class="token number">2</span>    
ENDIF    
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li><li style="color: rgb(153, 153, 153);">2</li><li style="color: rgb(153, 153, 153);">3</li><li style="color: rgb(153, 153, 153);">4</li><li style="color: rgb(153, 153, 153);">5</li></ul></pre> 
<p>IF、ELSE、ENDIF伪指令能根据条件的成立与否决定是否执行某个指令序列。当IF后面的逻辑表达式为真，则执行指令序列1，否则执行指令序列2 。其中，ELSE及指令序列2可以没有，此时，当IF后面的逻辑表达式为真，则执行指令序列1 ，否则继续执行后面的指令。IF 、ELSE 、ENDIF伪指令可以嵌套使用。</p> 
<p><strong>使用示例：</strong></p> 
<pre data-index="27" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">GBLL Test 			<span class="token punctuation">;</span>声明一个全局的逻辑变量，变量名为Test   
IF Test <span class="token operator">=</span> TRUE    
指令序列 <span class="token number">1</span>    
ELSE    
指令序列 <span class="token number">2</span>    
ENDIF    
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li><li style="color: rgb(153, 153, 153);">2</li><li style="color: rgb(153, 153, 153);">3</li><li style="color: rgb(153, 153, 153);">4</li><li style="color: rgb(153, 153, 153);">5</li><li style="color: rgb(153, 153, 153);">6</li></ul></pre> 
<h2><a name="t17"></a><a id="2_WHILEWEND_260"></a>2 WHILE/WEND</h2> 
<p>语法格式：</p> 
<pre data-index="28" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">WHILE 逻辑表达式    
指令序列    
WEND 
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li><li style="color: rgb(153, 153, 153);">2</li><li style="color: rgb(153, 153, 153);">3</li></ul></pre> 
<p>WHILE、WEND伪指令能根据条件的成立与否决定是否循环执行某个指令序列。当WHILE后面的逻辑表达式为真，则执行指令序列，该指令序列执行完毕后，再判断 逻辑表达式的值，若为真则继续执行，一直到逻辑表达式的值为假。WHILE、WEND伪指令可以嵌套使用。</p> 
<p><strong>使用示例：</strong></p> 
<pre data-index="29" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">GBLA Counter 		<span class="token punctuation">;</span>声明一个全局的数学变量，变量名为Counter    
Counter SETA <span class="token number">3</span>		<span class="token punctuation">;</span>由变量Counter 控制循环次数    
……    
WHILE Counter <span class="token operator">&lt;</span> <span class="token number">10</span>    
指令序列    
WEND  
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li><li style="color: rgb(153, 153, 153);">2</li><li style="color: rgb(153, 153, 153);">3</li><li style="color: rgb(153, 153, 153);">4</li><li style="color: rgb(153, 153, 153);">5</li><li style="color: rgb(153, 153, 153);">6</li></ul></pre> 
<h2><a name="t18"></a><a id="3_MACROMEND_280"></a>3 MACRO/MEND</h2> 
<p>语法格式：</p> 
<pre data-index="30" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">$ 标号 宏名 $ 参数 <span class="token number">1</span> <span class="token punctuation">,</span> $ 参数 <span class="token number">2</span> <span class="token punctuation">,</span> <span class="token punctuation">.</span><span class="token punctuation">.</span><span class="token punctuation">.</span><span class="token punctuation">.</span><span class="token punctuation">.</span><span class="token punctuation">.</span>  
指令序列    
MEND   
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li><li style="color: rgb(153, 153, 153);">2</li><li style="color: rgb(153, 153, 153);">3</li></ul></pre> 
<p>MACRO 、MEND伪指令可以将一段代码定义为一个整体，称为宏指令，然后就可以在程序中通过宏指令多次调用该段代码。其中，$标号在宏指令被展开时，标号会被替 换为用户定义的符号，宏指令可以使用一个或多个参数，当宏指令被展开时，这些参数被相应的值替换。<br> 宏指令的使用方式和功能与子程序有些相似，子程序可以提供模块化的程序设计、节省存储空间并提高运行速度。但在使用子程序结构时需要保护现场，从而增加了 系统的开销，因此，在代码较短且需要传递的参数较多时，可以使用宏指令代替子程序。<br> 包含在MACRO和MEND之间的指令序列称为宏定义体，在宏定义体的第一行应声明宏的原型（包含宏名、所需的参数），然后就可以在汇编程序中通过宏名来 调用该指令序列。在源程序被编译时，汇编器将宏调用展开，用宏定义中的指令序列代替程序中的宏调用，并将实际参数的值传递给宏定义中的形式参数。<br> MACRO、MEND伪指令可以嵌套使用。</p> 
<h2><a name="t19"></a><a id="4_MEXIT_292"></a>4 MEXIT</h2> 
<p>语法格式：</p> 
<pre data-index="31" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">MEXIT    
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li></ul></pre> 
<p>MEXIT用于从宏定义中跳转出去。</p> 
<h1><a name="t20"></a><a id="__299"></a>四 其他常用的伪指令</h1> 
<p>还有一些其他的伪指令，在汇编程序中经常会被使用，包括以下几条：</p> 
<ul><li>AREA</li><li>ALIGN</li><li>CODE16 、CODE32</li><li>ENTRY</li><li>END</li><li>EQU</li><li>EXPORT（或GLOBAL ）</li><li>IMPORT</li><li>EXTERN</li><li>GET（或INCLUDE ）</li><li>INCBIN</li><li>RN</li><li>ROUT</li></ul> 
<h2><a name="t21"></a><a id="1_AREA_315"></a>1 AREA</h2> 
<p>语法格式：</p> 
<pre data-index="32" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">AREA 段名 属性<span class="token number">1</span><span class="token punctuation">,</span> 属性<span class="token number">2</span><span class="token punctuation">,</span> <span class="token punctuation">.</span><span class="token punctuation">.</span><span class="token punctuation">.</span>    
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li></ul></pre> 
<p>AREA伪指令用于定义一个代码段或数据段。其中，段名若以数字开头，则该段名需用"|"括起来，如：|1_test|<br> 属性字段表示该代码段（或数据段）的相关属性，多个属性用逗号分隔。常用的属性如下：</p> 
<ul><li>CODE属性：用于定义代码段，默认为READONLY 。</li><li>DATA属性：用于定义数据段，默认为READWRITE 。</li><li>READONLY属性：指定本段为只读，代码段默认为READONLY 。</li><li>READWRITE属性：指定本段为可读可写，数据段的默认属性为READWRITE 。</li><li>ALIGN属性：使用方式为ALIGN表达式。在默认时，ELF（可执行连接文件）的代码段和数据段是按字对齐的，表达式的取值范围为0～31，相应的对齐方式为2 表达式次方。</li><li>COMMON属性：该属性定义一个通用的段，不包含任何的用户代码和数据。各源文件中同名的COMMON段共享同一段存储单元。</li></ul> 
<p>一个<a href="https://so.csdn.net/so/search?q=%E6%B1%87%E7%BC%96%E8%AF%AD%E8%A8%80&amp;spm=1001.2101.3001.7020" target="_blank" class="hl hl-1" data-report-view="{&quot;spm&quot;:&quot;1001.2101.3001.7020&quot;,&quot;dest&quot;:&quot;https://so.csdn.net/so/search?q=%E6%B1%87%E7%BC%96%E8%AF%AD%E8%A8%80&amp;spm=1001.2101.3001.7020&quot;}" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.7020&quot;,&quot;dest&quot;:&quot;https://so.csdn.net/so/search?q=%E6%B1%87%E7%BC%96%E8%AF%AD%E8%A8%80&amp;spm=1001.2101.3001.7020&quot;}" data-tit="汇编语言" data-pretit="汇编语言">汇编语言</a>程序至少要包含一个段，当程序太长时，也可以将程序分为多个代码段和数据段。<br> <strong>使用示例：</strong></p> 
<pre data-index="33" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">AREA Init<span class="token punctuation">,</span> CODE<span class="token punctuation">,</span> READONLY	<span class="token punctuation">;</span>该伪指令定义了一个代码段，段名为Init，属性为只读。    
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li></ul></pre> 
<h2><a name="t22"></a><a id="2_ALIGN_337"></a>2 ALIGN</h2> 
<p>语法格式：</p> 
<pre data-index="34" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">ALIGN <span class="token punctuation">{<!-- --></span>表达式 <span class="token punctuation">,</span>偏移量 <span class="token punctuation">}</span>  
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li></ul></pre> 
<p>ALIGN伪指令可通过添加填充字节的方式，使当前位置满足一定的对齐方式。其中，表达式的值用于指定对齐方式，可能的取值为2的幂，如1 、2 、4 、8 、16 等。若未指定表达式，则将当前位置对齐到下一个字的位置。偏移量也为一个数字表达式，若使用该字段，则当前位置的对齐方式为：2的表达式次幂＋偏移 量。</p> 
<p><strong>使用示例：</strong></p> 
<pre data-index="35" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">AREA Init ，CODE ，READONLY ，ALIEN<span class="token operator">=</span><span class="token number">3</span> ；指定后面的指令为<span class="token number">8</span>字节对齐。    
指令序列    
END  
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li><li style="color: rgb(153, 153, 153);">2</li><li style="color: rgb(153, 153, 153);">3</li></ul></pre> 
<h2><a name="t23"></a><a id="3_CODE16CODE32_353"></a>3 CODE16/CODE32</h2> 
<p>语法格式：</p> 
<pre data-index="36" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;"><span class="token function">CODE16</span><span class="token punctuation">(</span>或CODE32<span class="token punctuation">)</span>    
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li></ul></pre> 
<p>CODE16伪指令通知编译器，其后的指令序列为16位的Thumb指令。<br> CODE32伪指令通知编译器，其后的指令序列为32位的ARM指令。<br> 若在汇编源程序中同时包含ARM指令和Thumb指令时，可用CODE16伪指令通知编译器其后的指令序列为16位的Thumb指令，CODE32伪指令 通知编译器其后的指令序列为32位的ARM指令。因此，在使用ARM指令和Thumb指令混合编程的代码里，可用这两条伪指令进行切换，但注意他们只通知 编译器其后指令的类型，并不能对处理器进行状态的切换。</p> 
<p><strong>使用示例：</strong></p> 
<pre data-index="37" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">AREA Init<span class="token punctuation">,</span> CODE<span class="token punctuation">,</span> READONLY  
CODE32                    	<span class="token punctuation">;</span>通知编译器其后的指令为<span class="token number">32</span>位的 ARM指令    
LDR R0<span class="token punctuation">,</span> <span class="token operator">=</span>NEXT＋<span class="token number">1</span> 			<span class="token punctuation">;</span>将跳转地址放入寄存器R0    
BX R0                       <span class="token punctuation">;</span>程序跳转到新的位置执行，并将处理器切换到Thumb工作状态    
……    
CODE16 		                <span class="token punctuation">;</span>通知编译器其后的指令为<span class="token number">16</span>位的 Thumb指令    
NEXT LDR R3<span class="token punctuation">,</span> <span class="token operator">=</span><span class="token number">0x3FF</span>    
……   
END
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li><li style="color: rgb(153, 153, 153);">2</li><li style="color: rgb(153, 153, 153);">3</li><li style="color: rgb(153, 153, 153);">4</li><li style="color: rgb(153, 153, 153);">5</li><li style="color: rgb(153, 153, 153);">6</li><li style="color: rgb(153, 153, 153);">7</li><li style="color: rgb(153, 153, 153);">8</li><li style="color: rgb(153, 153, 153);">9</li></ul></pre> 
<h2><a name="t24"></a><a id="4_ENTRY_376"></a>4 ENTRY</h2> 
<p>语法格式：</p> 
<pre data-index="38" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">ENTRY    
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li></ul></pre> 
<p>ENTRY 伪指令用于指定汇编程序的入口点。在一个完整的汇编程序中至少要有一个ENTRY（也可以有多个，当有多个ENTRY时，程序的真正入口点由链 接器指定），但在一个源文件里最多只能有一个ENTRY（可以没有）。</p> 
<p><strong>使用示例：</strong></p> 
<pre data-index="39" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">AREA Init<span class="token punctuation">,</span> CODE<span class="token punctuation">,</span> READONLY    
ENTRY ； 指定应用程序的入口点    
……
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li><li style="color: rgb(153, 153, 153);">2</li><li style="color: rgb(153, 153, 153);">3</li></ul></pre> 
<h2><a name="t25"></a><a id="5_END_390"></a>5 END</h2> 
<p>语法格式：</p> 
<pre data-index="40" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">END 
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li></ul></pre> 
<p>END 伪指令用于通知编译器已经到了源程序的结尾。<br> <strong>使用示例:</strong></p> 
<pre data-index="41" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">AREA Init<span class="token punctuation">,</span> CODE<span class="token punctuation">,</span> READONLY    
……  
END		<span class="token punctuation">;</span>指定应用程序的结尾   
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li><li style="color: rgb(153, 153, 153);">2</li><li style="color: rgb(153, 153, 153);">3</li></ul></pre> 
<h2><a name="t26"></a><a id="6_EQU_404"></a>6 EQU</h2> 
<p>语法格式：</p> 
<pre data-index="42" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">名称 EQU 表达式 <span class="token punctuation">{<!-- --></span>类型<span class="token punctuation">}</span>    
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li></ul></pre> 
<p>EQU伪指令用于为程序中的常量、标号等定义一个等效的字符名称，类似于C语言中的＃define 。其中EQU可用"*"代替。名称为EQU伪指令定义的字符名称，当表达式为32位的常量时，可以指定表达式的数据类型，可以有以下三种类型: CODE16、CODE32和DATA<br> <strong>使用示例：</strong></p> 
<pre data-index="43" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">Test EQU <span class="token number">50</span>              	<span class="token punctuation">;</span>定义标号Test的值为<span class="token number">50</span>。    
Addr EQU <span class="token number">0x55</span><span class="token punctuation">,</span> CODE32		<span class="token punctuation">;</span>定义Addr的值为<span class="token number">0x55</span>，且该处为<span class="token number">32</span>位的ARM指令。    
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li><li style="color: rgb(153, 153, 153);">2</li></ul></pre> 
<h2><a name="t27"></a><a id="7_EXPORTGLOBAL_416"></a>7 EXPORT(或GLOBAL)</h2> 
<p>语法格式：</p> 
<pre data-index="44" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">EXPORT 标号 <span class="token punctuation">{<!-- --></span><span class="token punctuation">[</span>WEAK<span class="token punctuation">]</span><span class="token punctuation">}</span>    
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li></ul></pre> 
<p>EXPORT伪指令用于在程序中声明一个全局的标号，该标号可在其他的文件中引用。EXPORT可用GLOBAL代替。标号在程序中区分大小写，[WEAK] 选项声明其他的同名标号优先于该标号被引用。<br> <strong>使用示例：</strong></p> 
<pre data-index="45" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">AREA Init<span class="token punctuation">,</span> CODE<span class="token punctuation">,</span> READONLY    
EXPORT Stest				<span class="token punctuation">;</span>声明一个可全局引用的标号Stest   
END    
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li><li style="color: rgb(153, 153, 153);">2</li><li style="color: rgb(153, 153, 153);">3</li></ul></pre> 
<h2><a name="t28"></a><a id="8_IMPORT_428"></a>8 IMPORT</h2> 
<p>语法格式：</p> 
<pre data-index="46" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">IMPORT 标号 <span class="token punctuation">{<!-- --></span><span class="token punctuation">[</span>WEAK<span class="token punctuation">]</span><span class="token punctuation">}</span>    
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li></ul></pre> 
<p>IMPORT伪指令用于通知编译器要使用的标号在其他的源文件中定义，但要在当前源文件中引用，而且无论当前源文件是否引用该标号，该标号均会被加入到当前源文件的符号表中。标 号在程序中区分大小写，[WEAK] 选项表示当所有的源文件都没有定义这样一个标号时，编译器也不给出错误信息，在多数情况下将该标号置为0 ，若该标号为B或BL指令引用，则将B或BL指令置为NOP操作。</p> 
<p><strong>使用示例：</strong></p> 
<pre data-index="47" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">AREA Init<span class="token punctuation">,</span> CODE ，READONLY    
IMPORT Main ；通知编译器当前文件要引用标号Main，但Main在其他源文件中定 义。 
END    
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li><li style="color: rgb(153, 153, 153);">2</li><li style="color: rgb(153, 153, 153);">3</li></ul></pre> 
<h2><a name="t29"></a><a id="9_EXTERN_442"></a>9 EXTERN</h2> 
<p>语法格式：</p> 
<pre data-index="48" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">EXTERN 标号 <span class="token punctuation">{<!-- --></span><span class="token punctuation">[</span>WEAK<span class="token punctuation">]</span><span class="token punctuation">}</span>   
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li></ul></pre> 
<p>EXTERN伪指令用于通知编译器要使用的标号在其他的源文件中定义，但要在当前源文件中引用，如果当前源文件实际并未引用该标号，该 标号就不会被加入到当前源文件的符号表中。标号在程序中区分大小写， [WEAK] 选项表示当所有的源文件都没有定义这样一个标号时，编译器也不给出错误信息，在多数情况下将该标号置为0 ，若该标号为B或BL指令引用，则将B或BL指令置为NOP操作。</p> 
<p><strong>使用示例：</strong></p> 
<pre data-index="49" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">AREA Init<span class="token punctuation">,</span> CODE<span class="token punctuation">,</span> READONLY    
EXTERN Main 				<span class="token punctuation">;</span>通知编译器当前文件要引用标号Main，但Main在其他源文件中定义。   
END    
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li><li style="color: rgb(153, 153, 153);">2</li><li style="color: rgb(153, 153, 153);">3</li></ul></pre> 
<h2><a name="t30"></a><a id="10_GETINCLUDE_457"></a>10 GET(或INCLUDE)</h2> 
<p>语法格式：</p> 
<pre data-index="50" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">GET 文件名    
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li></ul></pre> 
<p>GET伪指令用于将一个源文件包含到当前的源文件中，并将被包含的源文件在当前位置进行汇编处理。可以使用INCLUDE代替GET。<br> 汇编程序中常用的方法是在某源文件中定义一些宏指令，用EQU定义常量的符号名称，用MAP和FIELD定义结构化的数据类型，然后用GET伪指令将这个 源文件包含到其他的源文件中。使用方法与C 语言中的"include" 相似。<br> GET伪指令只能用于包含源文件，包含目标文件需要使用INCBIN伪指令</p> 
<p><strong>使用示例：</strong></p> 
<pre data-index="51" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">AREA Init<span class="token punctuation">,</span> CODE<span class="token punctuation">,</span> READONLY    
GET a1<span class="token punctuation">.</span>s 		    <span class="token punctuation">;</span>通知编译器当前源文件包含源文件a1<span class="token punctuation">.</span>s    
GET C<span class="token punctuation">:</span>\a2<span class="token punctuation">.</span>s 		<span class="token punctuation">;</span>通知编译器当前源文件包含源文件C<span class="token punctuation">:</span>\a2<span class="token punctuation">.</span>s 
END 
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li><li style="color: rgb(153, 153, 153);">2</li><li style="color: rgb(153, 153, 153);">3</li><li style="color: rgb(153, 153, 153);">4</li></ul></pre> 
<h2><a name="t31"></a><a id="11_INCBIN_474"></a>11 INCBIN</h2> 
<p>语法格式：</p> 
<pre data-index="52" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">INCBIN 文件名    
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li></ul></pre> 
<p>INCBIN伪指令用于将一个目标文件或数据文件包含到当前的源文件中，被包含的文件不作任何变动的存放在当前文件中，编译器从其后开始继续处理。<br> <strong>使用示例：</strong></p> 
<pre data-index="53" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">AREA Init<span class="token punctuation">,</span> CODE<span class="token punctuation">,</span> READONLY    
INCBIN a1<span class="token punctuation">.</span>dat     			<span class="token punctuation">;</span>通知编译器当前源文件包含文件a1<span class="token punctuation">.</span>dat    
INCBIN C<span class="token punctuation">:</span>\a2<span class="token punctuation">.</span>txt 			<span class="token punctuation">;</span>通知编译器当前源文件包含文件C<span class="token punctuation">:</span>\a2<span class="token punctuation">.</span>txt  
END    
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li><li style="color: rgb(153, 153, 153);">2</li><li style="color: rgb(153, 153, 153);">3</li><li style="color: rgb(153, 153, 153);">4</li></ul></pre> 
<h2><a name="t32"></a><a id="12_RN_489"></a>12 RN</h2> 
<p>语法格式：</p> 
<pre data-index="54" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">名称 RN 表达式    
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li></ul></pre> 
<p>RN伪指令用于给一个寄存器定义一个别名。采用这种方式可以方便程序员记忆该寄存器的功能。其中，名称为给寄存器定义的别名，表达式为寄存器的编码。</p> 
<p><strong>使用示例：</strong></p> 
<pre data-index="55" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">Temp RN R0 		<span class="token punctuation">;</span>将R0定义一个别名Temp    
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li></ul></pre> 
<h2><a name="t33"></a><a id="13_ROUT_501"></a>13 ROUT</h2> 
<p>语法格式：</p> 
<pre data-index="56" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;"><span class="token punctuation">{<!-- --></span>名称<span class="token punctuation">}</span> ROUT    
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li></ul></pre> 
<p>ROUT伪指令用于给一个局部变量定义作用范围。在程序中未使用该伪指令时，局部变量的作用范围为所在的AREA，而使用ROUT后，局部变量的作为范围为当前ROUT和下一个ROUT之间。</p> 
<h2><a name="t34"></a><a id="13_BNEBEQ_509"></a>13 BNE与BEQ</h2> 
<pre data-index="57" class="prettyprint" style="user-select: auto;"><code class="prism language-c has-numbering" onclick="mdcp.copyCode(event)" style="position: unset; user-select: auto;">TST   R0<span class="token punctuation">,</span> #<span class="token number">0X8</span>
BNE   SuspendUp 		<span class="token punctuation">;</span>BNE指令是"不相等<span class="token punctuation">(</span>或不为<span class="token number">0</span><span class="token punctuation">)</span>跳转指令” 
LDR   R1<span class="token punctuation">,</span> #<span class="token number">0x00000000</span>
<div class="hljs-button {2}" data-title="免登录复制" data-report-click="{&quot;spm&quot;:&quot;1001.2101.3001.4334&quot;}" onclick="hljs.copyCode(event);setTimeout(function(){$('.hljs-button').attr('data-title', '免登录复制');},3500);"></div></code><ul class="pre-numbering" style=""><li style="color: rgb(153, 153, 153);">1</li><li style="color: rgb(153, 153, 153);">2</li><li style="color: rgb(153, 153, 153);">3</li></ul></pre> 
<p>先进行and运算，如果R0的第四位不为1，则结果为零，则设置zero=1（继续下面的LDR指令）；<br> 否则，如果R0的第四位为1，zero=0（跳到SuspendUp处执行）。<br> tst 和bne连用: 先是用tst进行位与运算，然后将位与的结果与0比较，如果不为0，则跳到bne紧跟着的标记（如bne sleep，则跳到sleep处）。<br> tst 和beq连用: 先是用tst进行位与运算，然后将位与的结果与0比较，如果为0，则跳到beq紧跟着的标记（如bne AAAA，则跳到AAAA处）。</p>
                </div><div data-report-view="{&quot;mod&quot;:&quot;1585297308_001&quot;,&quot;spm&quot;:&quot;1001.2101.3001.6548&quot;,&quot;dest&quot;:&quot;https://blog.csdn.net/chengbaojin/article/details/109459693&quot;,&quot;extend1&quot;:&quot;pc&quot;,&quot;ab&quot;:&quot;new&quot;}"><div></div></div>
                <link href="https://csdnimg.cn/release/blogv2/dist/mdeditor/css/editerView/markdown_views-3fd7f7a902.css" rel="stylesheet">
                <link href="https://csdnimg.cn/release/blogv2/dist/mdeditor/css/style-49037e4d27.css" rel="stylesheet">
        </div>

> 文章转载自: [ARM汇编伪指令](https://blog.csdn.net/chengbaojin/article/details/109459693)