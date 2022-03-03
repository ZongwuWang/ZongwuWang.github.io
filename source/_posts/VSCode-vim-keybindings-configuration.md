---
title: VSCode vim keybindings configuration
password: www
abstract: 'Welcome to my blog, enter password to read.'
message: 'Welcome to my blog, enter password to read.'
date: 2022-01-19 01:54:33
tags:
categories:
---

# VSCode vim keybindings configuration

在使用VSCode+Vim编写代码，如Verilog时，会出现多个提示，但是有时候这些提示中并没有我们需要的，并且在输入完（例如：wire）由于格式需要我们得输入tab，此时输入tab的效果是选择下一个提示项。修改方式如下：

默认的keybindings.json文件如下所示，我们可以看出在多个选项出现时，tab键被映射为选择下一个提示，我们只要将这个功能映射到其他键，例如“Space”，就可以恢复tab的正常功能。

{% folding green open, default key bindings %}
```json
// 将键绑定放在此文件中以覆盖默认值
[
    { "key": "tab", 
        "command": "-acceptSelectedSuggestion", 
        "when": "suggestWidgetVisible && textInputFocus"
    },
    { "key": "tab", 
        "command": "selectNextSuggestion", 
        "when": "suggestWidgetMultipleSuggestions && suggestWidgetVisible && textInputFocus"
    },
    {
        "key": "ctrl+shift+t",
        "command": "extension.cursorTip",
        "when": "editorTextFocus"
    },
    {
        "key": "ctrl+win+t",
        "command": "-extension.cursorTip",
        "when": "editorTextFocus"
    },
    {
        "key": "ctrl+alt+t",
        "command": "extension.fileheader",
        "when": "editorTextFocus"
    },
    {
        "key": "ctrl+win+i",
        "command": "-extension.fileheader",
        "when": "editorTextFocus"
    }
]
```
{% endfolding %}
