# fluid.yazi

This is a modified version of the original [plugin](https://github.com/josephschmitt/auto-layout.yazi). All credit goes to [josephschmitt](https://github.com/josephschmitt).

# Installation

```sh
ya pack -a lernywensi/fluid
```

# Usage

```lua
-- You can skip passing the object to use the default settings
require("fluid").setup({
    breakpoint = {
        large = 110, -- Defaults to 100
        medium = 60, -- Defaults to 50
    }
 })
```
