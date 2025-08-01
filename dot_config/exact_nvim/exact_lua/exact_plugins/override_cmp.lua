-- so autocomplete is triggered by pressing tab instead of enter
return {
  "saghen/blink.cmp",
  -- we set the version because https://cmp.saghen.dev/configuration/fuzzy
  version = "1.*",
  opts = {
    keymap = {
      preset = "super-tab",
      -- https://github.com/LazyVim/LazyVim/issues/6185
      ["<Tab>"] = {
        require("blink.cmp.keymap.presets").get("super-tab")["<Tab>"][1],
        require("lazyvim.util.cmp").map({ "snippet_forward", "ai_accept" }),
        "fallback",
      },
    },
  },
}
