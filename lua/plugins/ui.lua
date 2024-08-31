return {
  -- messages, cmdline and the popupmenu
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    config = function()
      require("noice").setup({
        routes = {
          {
            filter = {
              event = "notify",
              find = "No information available",
            },
            opts = { skip = true },
          },
        },
        lsp = {
          signature = {
            auto_open = false,
          },
          hover = {
            enabled = true,
            silent = true,
            view = nil,
          },
        },
        presets = {
          lsp_doc_border = true,
        },
      })

      local focused = true
      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          focused = true
        end,
      })
      vim.api.nvim_create_autocmd("FocusLost", {
        callback = function()
          focused = false
        end,
      })

      require("noice").setup({
        routes = {
          {
            filter = {
              cond = function()
                return not focused
              end,
            },
            view = "notify_send",
            opts = { stop = false },
          },
        },
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(event)
          vim.schedule(function()
            require("noice.text.markdown").keys(event.buf)
          end)
        end,
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },
  {
    "amrbashir/nvim-docs-view",
    lazy = true,
    cmd = "DocsViewToggle",
    config = function()
      require("docs-view").setup({
        position = "right",
        width = 60,
      })
    end,
  },
  -- Notifications
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        render = "compact",
        background_colour = "#1a1b26",
        timeout = 5000,
      })
      -- Set vim.notify to use nvim-notify
      vim.notify = require("notify")
    end,
  },
  -- filename
  {
    "b0o/incline.nvim",
    event = "BufReadPre",
    priority = 1200,
    config = function()
      require("incline").setup({
        window = { margin = { vertical = 0, horizontal = 1 } },
        hide = {
          cursorline = true,
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if vim.bo[props.buf].modified then
            filename = "[+] " .. filename
          end
          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      })
    end,
  },

  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      require("mini.animate").setup({
        resize = {
          enable = false,
        },
        open = {
          enable = false,
        },
        close = {
          enable = false,
        },
        scroll = {
          enable = true,
          timing = require("mini.animate").gen_timing.linear({ duration = 100, unit = "total" }),
          subscroll = require("mini.animate").gen_subscroll.equal({
            move = true,
          }),
        },
      })
    end,
  },

  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    config = function()
      require("zen-mode").setup({
        plugins = {
          gitsigns = true,
          tmux = true,
          kitty = { enabled = false, font = "+2" },
          twilight = { enabled = true },
        },
      })
    end,
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },

  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    config = function()
      local logo = [[
                    ░░░░░░      ░░░░░░
                  ░░░░░░░░░░  ░░░░░░░░░░
                ░░░░░░░░░░░░░░░░░░░░░░░░░░
              ░░░░░░░░░░▒▒▒▒░░▒▒▒▒░░░░░░░░░░
            ░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░
▒▒        ░░░░░░▒▒▒▒▒▒▒▒▒▒██▒▒██▒▒▒▒▒▒▒▒▒▒░░░░░░        ▒▒
▒░░    ░░░░░░░░▒▒▒▒▒▒▒▒▒▒████▒▒████▒▒▒▒▒▒▒▒▒▒░░░░░░░░    ░░▒
▒▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒██████▒▒██████▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒
█▒▒▒▒▒▒▒▒▒▒▒▒▒▒██▒▒▒▒██████▓▓██▒▒██████▒▒▓▓██▒▒▒▒▒▒▒▒▒▒▒▒▒▒█
████▒▒▒▒▒▒████▒▒▒▒██████████  ██████████▒▒▒▒████▒▒▒▒▒▒▒▒██
  ████████████████████████      ████████████████████████
    ██████████████████              ██████████████████
        ██████████                      ██████████
]]
      logo = string.rep("\n", 8) .. logo .. "\n\n"
      require("dashboard").setup({
        config = {
          header = vim.split(logo, "\n"),
        },
      })
    end,
  },
}
