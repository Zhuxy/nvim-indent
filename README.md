# nvim-indent

## Intro

`nvim-indent` is a plugin to help you select or operate with texts by indent level.

The basic concept is to select neighboring lines of text base on the indent level under the cursor.

When searching the lines, the *(i)side* operation means all the neighboring lines whose indent level is equal or lower than the line under the cursor.

And the *(a)round* operation means all the neighboring lines whose indent level is equal or lower than the line under the cursor, plus a upmost line or a downmost line which has a lower indent level if existed.

Including any empty line when searching.

## Config

The fault keystroke for indent line is `i` and `I`. If you want to use another pair of character, you can set the config object:

```lua
require("nvim-indent").setup({
    text_object_char = 'l', -- now use `il` or `al` to select line
})
```

## Usage

Here is a function:

```lua
🮛local function test()
🮛  print(1)
█  print(2)
🮛  print(3)
🮛end
```

use `vii` to select function body (Thay are have the same indent level):

```lua
🮛local function test()
█  print(1)
█  print(2)
█  print(3)
🮛end
```

use `vai` to select all function definition (exluding the upmost line with a less indent level, but not downmost one):

```lua
█local function test()
█  print(1)
█  print(2)
█  print(3)
🮛end
```
use `vaI` to select all function definition (including the upmost and downmost line with a less indent level):

```lua
█local function test()
█  print(1)
█  print(2)
█  print(3)
█end
```


Here are some markdown texts:

```markdown
🮛# Header 1
🮛- List 1
🮛  - Sub list 1
█  - Sub list 2
🮛  - Sub list 3
🮛
🮛# Header 2
```

use `vii` to select sub lists (without the empty line):

```markdown
🮛# Header 1
🮛- List 1
█  - Sub list 1
█  - Sub list 2
█  - Sub list 3
🮛
🮛# Header 2
```
use `viI` to select sub lists (including the empty line):

```markdown
🮛# Header 1
🮛- List 1
█  - Sub list 1
█  - Sub list 2
█  - Sub list 3
█
🮛# Header 2
```
use `vai` to select List 1 and Sub lists (without the empty line):

```markdown
🮛# Header 1
█- List 1
█  - Sub list 1
█  - Sub list 2
█  - Sub list 3
🮛
🮛# Header 2
```
use `vaI` to select List 1 and Sub lists (including the empty line):

```markdown
🮛# Header 1
█- List 1
█  - Sub list 1
█  - Sub list 2
█  - Sub list 3
█
🮛# Header 2
```
