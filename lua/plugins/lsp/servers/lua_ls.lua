-- ============================================================================
-- Lua Language Server Configuration
-- ============================================================================

return {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand("/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
      completion = {
        callSnippet = "Replace",
      },
      format = {
        enable = true,
        defaultConfig = {
          indent_style = "space",
          indent_size = "2",
        },
      },
    },
  },
}
