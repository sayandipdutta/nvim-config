local map = vim.keymap.set

vim.pack.add({
    { src = "https://github.com/tpope/vim-repeat" },
    { src = "https://codeberg.org/andyg/leap.nvim" },
}, { confirm = false, load = true })

require('leap').opts.preview = function(ch0, ch1, ch2)
  return not (
    ch1:match('%s')
    or (ch0:match('%a') and ch1:match('%a') and ch2:match('%a'))
  )
end

map({ 'n', 'x', 'o' }, 's', '<Plug>(leap)')
map('n',               'S', '<Plug>(leap-from-window)')

map({ 'x', 'o' }, 'an', function()
  require('leap.treesitter').select {
    opts = require('leap.user').with_traversal_keys('n', 'N')
  }
end)

-- Enable the traversal keys to repeat the previous search without
-- explicitly invoking Leap (`<cr><cr>...` instead of `s<cr><cr>...`):
do
  local clever = require('leap.user').with_traversal_keys
  -- For relative directions, set the `backward` flags according to:
  -- local prev_backward = require('leap').state['repeat'].backward
  map({ 'n', 'x', 'o' }, '<cr>', function()
    require('leap').leap {
      ['repeat'] = true, opts = clever('<cr>', '<bs>'),
    }
  end)
  map({ 'n', 'x', 'o' }, '<bs>', function()
    require('leap').leap {
      ['repeat'] = true, opts = clever('<bs>', '<cr>'), backward = true,
    }
  end)
end

require('leap').opts.preview = function(ch0, ch1, ch2)
  return not (
    ch1:match('%s')
    or (ch0:match('%a') and ch1:match('%a') and ch2:match('%a'))
  )
end
