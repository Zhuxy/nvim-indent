# nvim-indent

## Intro

`nvim-indent` is a plugin to help you select or operate with texts by indent level.

## Install

### Packer.vim

### Lazy.vim

## Usage

Here is a function:

```lua
🮛local function test()
🮛  print(1)
█  print(2)
🮛  print(3)
🮛end
```

use `vii` to select function body:

```lua
🮛local function test()
█  print(1)
█  print(2)
█  print(3)
🮛end
```

use `vai` to select all function definition:

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

use `vaI` to select List 1 and Sub lists (including the empty line):

```markdown
█# Header 1
█- List 1
█  - Sub list 1
█  - Sub list 2
█  - Sub list 3
█
█# Header 2
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
