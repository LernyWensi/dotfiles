vim.opt.termguicolors = true
vim.o.winborder = 'single'
vim.cmd.colorscheme('retrobox')
vim.api.nvim_set_hl(0, 'Normal', { bg = "NONE" })
vim.api.nvim_set_hl(0, 'StatusLine', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'StatusLineNC', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'WinSeparator', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'TabLine', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'TabLineFill', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'TabLineSel', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'NONE' })
for _, g in ipairs({'Error', 'Warn', 'Info', 'Hint'}) do
    vim.api.nvim_set_hl(0, 'DiagnosticUnderline' .. g, { undercurl = true })
end

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 0

vim.opt.pumheight = 10
vim.opt.pumwidth = 15
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.autocomplete = true
vim.opt.autocompletedelay = 100

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·' }
vim.opt.showbreak = '… '

vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'number'
vim.opt.sidescrolloff = 10
vim.opt.scrolloff = 10

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.api.nvim_create_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('HighlightOnYank', { clear = true }),
    callback = function()
        vim.highlight.on_yank({ timeout = 200 })
    end,
})

vim.api.nvim_create_autocmd('BufReadPost', {
    group = vim.api.nvim_create_augroup('ResumeCursorPosition', { clear = true }),
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)

        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('LspPopupConceal', { clear = true }),
    pattern = 'markdown',
    callback = function()
        local win_id = vim.api.nvim_get_current_win()
        local win_config = vim.api.nvim_win_get_config(win_id)

        if win_config.relative and win_config.relative ~= "" then
            vim.wo[win_id].conceallevel = 2
            vim.wo[win_id].concealcursor = 'nc'
        end
    end,
})

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('NativeLspCmp', { clear = true }),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if client and client.server_capabilities.completionProvider then
            vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
        end
    end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
    group = vim.api.nvim_create_augroup('LspAutoFormat', { clear = true }),
    callback = function(args)
        vim.lsp.buf.format({
            bufnr = args.buf,
            async = false,
            timeout_ms = 1000,
        })
    end,
})

vim.lsp.enable('rust_analyzer')
