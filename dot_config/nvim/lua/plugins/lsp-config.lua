-- lua/plugins/lsp.lua
local servers = { "ts_ls", "lua_ls", "eslint", "rust_analyzer", "taplo" }

return {
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUninstall" },
    opts = {},
  },

  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    opts = {
      ensure_installed = servers,
      -- mason-lspconfig will automatically `vim.lsp.enable()` installed servers by default
      -- automatic_enable = true, -- this is already the default
    },
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "prettierd",
        "stylua",
      },
      run_on_start = true,
    },
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "LspInfo" },
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- Default config for *all* servers
      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      -- Per‑server override: rust_analyzer with clippy
      vim.lsp.config("rust_analyzer", {
        settings = {
          ["rust-analyzer"] = {
            check = { command = "clippy" },
          },
        },
      })

      -- You *can* call this, but mason-lspconfig already auto‑enables installed servers.
      -- vim.lsp.enable(servers)

      -- LspAttach keymaps & inlay hints
      local lsp_group = vim.api.nvim_create_augroup("UserLspConfig", {})

      vim.api.nvim_create_autocmd("LspAttach", {
        group = lsp_group,
        callback = function(ev)
          vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          if client and client:supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
          end

          local function getOpts(desc)
            return { desc = desc, buffer = ev.buf }
          end

          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, getOpts("Go to declaration"))
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, getOpts("Go to definition"))
          vim.keymap.set("n", "K", vim.lsp.buf.hover, getOpts("Show hover information"))
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, getOpts("Go to implementation"))
          vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, getOpts("Show signature help"))
          vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, getOpts("Add workspace folder"))
          vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, getOpts("Remove workspace folder"))
          vim.keymap.set("n", "<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, getOpts("List workspace folders"))
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, getOpts("Prev diagnostic"))
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, getOpts("Next diagnostic"))
          vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, getOpts("Go to type definition"))
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, getOpts("Rename symbol"))
          vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, getOpts("Code actions"))
          vim.keymap.set("n", "gr", vim.lsp.buf.references, getOpts("Find references"))
        end,
      })

      -- Single diagnostics float autocmd group
      local diag_group = vim.api.nvim_create_augroup("UserLspDiagFloat", {})

      vim.api.nvim_create_autocmd("CursorHold", {
        group = diag_group,
        callback = function()
          local float_opts = {
            focusable = false,
            close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
            border = "rounded",
            source = "always",
            prefix = " ",
          }

          if not vim.b.diagnostics_pos then
            vim.b.diagnostics_pos = { nil, nil }
          end

          local cursor_pos = vim.api.nvim_win_get_cursor(0)
          if (cursor_pos[1] ~= vim.b.diagnostics_pos[1]
              or cursor_pos[2] ~= vim.b.diagnostics_pos[2])
              and #vim.diagnostic.get() > 0
          then
            vim.diagnostic.open_float(nil, float_opts)
          end

          vim.b.diagnostics_pos = cursor_pos
        end,
      })
    end,
  },
}
