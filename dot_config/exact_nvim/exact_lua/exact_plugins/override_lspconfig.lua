return {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    servers = {
      cssls = {},
      -- we don't want to spellcheck comments
      harper_ls = {
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
