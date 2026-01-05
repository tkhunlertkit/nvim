-- ============================================================================
-- Go Language Server Configuration (gopls)
-- ============================================================================

return {
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
      codelenses = {
        generate = true,
        gc_details = true,
        test = true,
        tidy = true,
      },
    },
  },
}
