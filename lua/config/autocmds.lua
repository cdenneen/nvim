-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local autocmd = vim.api.nvim_create_autocmd

-- Turn off paste mode when leaving insert
autocmd("InsertLeave", {
  pattern = "*",
  command = "set nopaste",
})

-- Disable the concealing in some file formats
-- The default conceallevel is 3 in LazyVim
autocmd("FileType", {
  pattern = { "json", "jsonc", "markdown" },
  callback = function()
    vim.opt.conceallevel = 0
  end,
})

autocmd("FileType", {
  pattern = { "yaml", "yml" },
  callback = function()
    vim.bo.commentstring = "# %s"
    vim.lsp.start({
      name = "YAML Language Server",
      cmd = { "yaml-language-server", "--stdio" },
      root_dir = vim.fs.dirname(vim.fs.find(".git", { upward = true })[1]),
      settings = {
        redhat = { telemetry = { enabled = false } },
        yaml = {
          keyOrdering = false,
          schemaStore = { enable = true },
        },
      },
    })
  end,
})
