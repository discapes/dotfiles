return {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    servers = {
      pyright = {
        settings = {
          python = {
            pythonPath = vim.fn.exepath("python3"),
            venvPath = vim.env.VIRTUAL_ENV and vim.env.VIRTUAL_ENV or vim.env.PYENV_ROOT,
          },
        },
      },
      cssls = {},
      -- we don't want to spellcheck comments
      harper_ls = {
        settings = {
          ["harper-ls"] = {
            linters = {
              ToDoHyphen = false,
            },
          },
        },
        filetypes = {
          "text",
          "plaintex",
          "typst",
          "gitcommit",
          "markdown",
        },
      },
    },
  },
}

-- TODO configure nixd for autocompletion on nix-darwin and home-manager
-- nixd = {
--   settings = {
--     nixd = {
--       nixpkgs = {
--         expr = "import <nixpkgs> { }",
--       },
--       formatting = {
--         command = { "nixfmt" },
--       },
--       options = {
--         nixos = {
--           expr = '(builtins.getFlake ("git+file://" + toString ./.)).nixosConfigurations.k-on.options',
--         },
--         home_manager = {
--           expr = '(builtins.getFlake ("git+file://" + toString ./.)).homeConfigurations."ruixi@k-on".options',
--         },
--       },
--     },
--   },
-- }
