require("lspconfig").tsserver.setup({
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
        languages = { "javascript", "typescript", "vue" },
      },
    },
  },
  filetypes = {
    "javascript",
    "typescript",
    "vue",
  },
})
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        volar = {
          filetypes = {
            "typescript",
            "vue",
          },
          root_dir = require("lspconfig.util").root_pattern("src/App.vue"),
        },
      },
    },
  },
}
