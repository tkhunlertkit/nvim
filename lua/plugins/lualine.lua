-- ============================================================================
-- Lualine: Statusline
-- Fast and easy to configure statusline
-- ============================================================================

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  config = function()
    require("lualine").setup({
      options = {
        theme = "nord",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = { "dashboard", "alpha", "starter" },
        },
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {
          {
            "filename",
            path = 3, -- 0: filename, 1: relative, 2: absolute, 3: absolute with tilde
            symbols = {
              modified = " ●",
              readonly = " ",
              unnamed = "[No Name]",
            },
          },
        },
        lualine_x = {
          -- Show macro recording status
          {
            function()
              local reg = vim.fn.reg_recording()
              if reg == "" then return "" end
              return "recording @" .. reg
            end,
            color = { fg = "#ff9e64" },
          },
          {
            "encoding",
            cond = function()
              return vim.bo.fileencoding ~= "utf-8"
            end,
          },
          "fileformat",
          "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      extensions = { "nvim-tree", "toggleterm", "quickfix" },
    })

    -- Refresh lualine on recording events
    vim.api.nvim_create_autocmd("RecordingEnter", {
      callback = function()
        require("lualine").refresh()
      end,
    })

    vim.api.nvim_create_autocmd("RecordingLeave", {
      callback = function()
        local timer = vim.loop.new_timer()
        timer:start(50, 0, vim.schedule_wrap(function()
          require("lualine").refresh()
        end))
      end,
    })
  end,
}
