-- lua/core/init.lua
-- Core configuration module loader

require("core.options")
require("core.keymaps")
require("core.autocmds")
require("core.highlights").setup()

