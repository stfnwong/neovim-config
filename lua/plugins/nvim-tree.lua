-- Settings for nvim-tree

local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
  return
end

-- recommended settings from docs 
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

-- TODO: I think I want the default to be netrw with nvimtree only working when I 
-- press a specific key sequence. That is, when I do :vs or :e on a directory I want
-- that to open in netrw.


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
