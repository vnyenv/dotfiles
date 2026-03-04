--vim.api.nvim_create_autocmd('TermOpen', {
--    group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
--    callback = function ()
--        vim.opt.number = false
--        vim.opt.relativenumber = false
--    end,
--})

--vim.o.shell = "kitty"
--vim.o.shellcmdflag = "--single-instance -d . sh -c"
--
--vim.keymap.set("n", "<leader>t", function()
--  vim.fn.jobstart({ "kitty" }, { detach = true })
--end, { desc = "Open Kitty terminal" })

