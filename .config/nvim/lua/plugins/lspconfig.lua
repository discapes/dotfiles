return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    -- dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      local lspconfig = require "lspconfig"
      local servers = { "lua_ls", "html", "cssls", "tailwindcss", "eslint", "jsonls", "pyright", "svelte", "bashls" }
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
          -- on_attach = on_attach,
          -- on_init = on_init,
          -- capabilities = capabilities,
        }
      end
      lspconfig.lua_ls.setup {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      }

      lspconfig.bashls.setup {
        filetypes = { "sh", "zsh" },
      }

      local function organize_imports()
        local params = {
          command = "_typescript.organizeImports",
          arguments = { vim.api.nvim_buf_get_name(0) },
          title = "",
        }
        vim.lsp.buf.execute_command(params)
      end

      local function autoimport()
        local params = {
          command = "_typescript.addMissingImports",
          arguments = { vim.api.nvim_buf_get_name(0) },
          title = "",
        }
        vim.lsp.buf.execute_command(params)
      end

      lspconfig.ts_ls.setup {
        commands = {
          OrganizeImports = {
            organize_imports,
            description = "Organize Imports",
          },
          AutoImport = {
            autoimport,
            description = "Add missing imports",
          },
        },
      }
    end,
  },
}
