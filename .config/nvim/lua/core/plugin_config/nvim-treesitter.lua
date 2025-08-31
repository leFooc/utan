require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "c",
    "cpp",
    "lua",
    "java",
    "javascript",
    "html",
    "css",
    "bash",
    "sql"
  },
  sync_install = false,
  auto_install = true
  hightlight = {
    enable = true,
    additional_vim_regex_highlighting = false
  }
}
