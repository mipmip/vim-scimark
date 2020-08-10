# Scimark

Edit embedded markdown tables in [SC-IM] in Vim.

![scimark demo](demo.gif)

![scimark demo](ndemo.gif)

# Prerequisites

First, install the dependencies (`ncurses` or `ncursesw`, for more info see https://github.com/andmarti1424/sc-im/wiki/Building-SC-IM)

Currently, you need a fork of [SC-IM] which has the markdown additions required by the plugin:
```sh
git clone https://github.com/mipmip/sc-im
cd sc-im
git checkout markdown-import
make
sudo make install
```

# Install

Install with a vim-plugin manager e.g. ```Plug 'mipmip/vim-scimark'```

# Usage

See `:help Scimark`

[SC-IM]: https://github.com/andmarti1424/sc-im
