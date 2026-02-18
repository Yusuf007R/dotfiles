return {
  {
    "mason-org/mason.nvim",
  },
  {
    "mason-org/mason-lspconfig.nvim",
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "LspInfo", "LspInstall", "LspUninstall" },
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      require("mason").setup({})
      require('mason-lspconfig').setup({
        ensure_installed = { 'ts_ls', 'lua_ls', 'eslint', 'rust_analyzer', 'taplo' },
        automatic_enable = true,
      })

      vim.lsp.config('rust_analyzer', {
        settings = {
          ['rust-analyzer'] = {
            check = {
              command = "clippy",
            },
          },
        },
      })
      require('mason-tool-installer').setup({
        ensure_installed = {
          "prettierd",
          "stylua",
          "isort",
          "black",
        },
      })

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          if client and client:supports_method('textDocument/inlayHint') then
            vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
          end
          local function getOpts(desc)
            return { desc = desc, buffer = ev.buf }
          end
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, getOpts("Go to declaration"))
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, getOpts("Go to definition"))
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, getOpts("Show hover information"))
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, getOpts("Go to implementation"))
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, getOpts("Show signature help"))
          vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, getOpts("Add workspace folder"))
          vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, getOpts("Remove workspace folder"))
          vim.keymap.set('n', '<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, getOpts("List workspace folders"))
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
          vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, getOpts("Go to type definition"))
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, getOpts("Rename symbol"))
          vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, getOpts("Code actions"))
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, getOpts("Find references"))

          vim.api.nvim_create_autocmd("CursorHold", {
            group = vim.api.nvim_create_augroup('UserLspDConfigDiag', {}),
            buffer = ev.buf,
            callback = function()
              local float_opts = {
                focusable = false,
                close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                border = "rounded",
                source = "always", -- show source in diagnostic popup window
                prefix = " ",
              }

              if not vim.b.diagnostics_pos then
                vim.b.diagnostics_pos = { nil, nil }
              end

              local cursor_pos = vim.api.nvim_win_get_cursor(0)
              if (cursor_pos[1] ~= vim.b.diagnostics_pos[1] or cursor_pos[2] ~= vim.b.diagnostics_pos[2])
                  and #vim.diagnostic.get() > 0
              then
                vim.diagnostic.open_float(nil, float_opts)
              end

              vim.b.diagnostics_pos = cursor_pos
            end,
          })
        end,
      })
    end,
  },
}
