return {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    servers = {
      clangd = {
        -- https://discourse.nixos.org/t/clang-clang-and-clangd-cant-find-headers-even-with-compile-commands-json/54657
        mason = false,
        -- we make clangd use gcc since clang on macOS (both nix and os) don't use libstdc++
        -- which contains bits/stdc++.h useful for competitive programming
        -- note that we also need to set g++ ~/.clangd. either of these changes alone will do nothing.
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--completion-style=detailed",
          "--function-arg-placeholders",
          "--fallback-style=llvm",
          vim.fn.expand("--query-driver=$HOME/.nix-profile/bin/g++"),
        },
      },
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
