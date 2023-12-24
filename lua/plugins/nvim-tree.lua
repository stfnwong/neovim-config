-- Settings for nvim-tree

local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
  return
end

-- recommended settings from docs 
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1


-- Can add a table here with more options
nvimtree.setup({
    renderer = {
      icons = {
        glyphs = {
          folder = {
            arrow_closed = "*",   -- glyph when folder is closed
            arrow_open = "#",     -- glyph when folder is open
          },
        },
      },
    },
  })
