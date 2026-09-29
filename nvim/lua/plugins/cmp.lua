local cmp = require('blink.cmp')
cmp.build():wait(60000)
cmp.setup({
    keymap = { preset = 'super-tab' },
    -- completion.trigger.show_in_snippet = false
    completion = {
        trigger = {
            show_in_snippet = false
        }
    }

})