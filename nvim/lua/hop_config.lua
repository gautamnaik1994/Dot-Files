local hop = require('hop')

vim.keymap.set('n', 's', function()
  hop.hint_char2()
end, {remap=true})
