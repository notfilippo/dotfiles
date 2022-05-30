call plug#begin()
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'mfussenegger/nvim-dap'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'

Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'

Plug 'tomasiser/vim-code-dark'
Plug 'vim-airline/vim-airline'

Plug 'goolord/alpha-nvim'
Plug 'tpope/vim-vinegar'

Plug 'folke/which-key.nvim'
Plug 'romgrk/barbar.nvim'

" Golang
Plug 'ray-x/go.nvim'
Plug 'ray-x/guihua.lua'

" Rust
Plug 'simrat39/rust-tools.nvim'
call plug#end()

" theme
colorscheme codedark
let g:airline_theme = 'codedark'

set completeopt=menu,menuone,noselect
set nosplitright

set tabstop=4 		" number of visual spaces per TAB
set softtabstop=4 	" number of spaces in TAB
set shiftwidth=4 	" number of spaces for autoindent
set expandtab 		" tabs are spaces
set autoindent		
set copyindent		" copy intent from the previous line

set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching brackets.
set ignorecase              " case insensitive matching
set mouse=a                 " all mouse interactions
set hlsearch                " highlight search results
filetype plugin indent on   " allows auto-indenting depending on file type

" hybrid line numbers
set number relativenumber
set nu rnu

let mapleader = " "

" window navigation
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-l> <C-w>l

" telescope
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

" hide hightlights
nnoremap <Leader><space> :noh<cr>

" nvim-tree
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>

" barbar
nnoremap <silent>    <A-,> :BufferPrevious<CR>
nnoremap <silent>    <A-.> :BufferNext<CR>
nnoremap <silent>    <A-<> :BufferMovePrevious<CR>
nnoremap <silent>    <A->> :BufferMoveNext<CR>
nnoremap <silent>    <A-1> :BufferGoto 1<CR>
nnoremap <silent>    <A-2> :BufferGoto 2<CR>
nnoremap <silent>    <A-3> :BufferGoto 3<CR>
nnoremap <silent>    <A-4> :BufferGoto 4<CR>
nnoremap <silent>    <A-5> :BufferGoto 5<CR>
nnoremap <silent>    <A-6> :BufferGoto 6<CR>
nnoremap <silent>    <A-7> :BufferGoto 7<CR>
nnoremap <silent>    <A-8> :BufferGoto 8<CR>
nnoremap <silent>    <A-9> :BufferLast<CR>
nnoremap <silent>    <A-p> :BufferPin<CR>
nnoremap <silent>    <A-c> :BufferClose<CR>
nnoremap <silent> <C-s>    :BufferPick<CR>
nnoremap <silent> <Space>bb :BufferOrderByBufferNumber<CR>
nnoremap <silent> <Space>bd :BufferOrderByDirectory<CR>
nnoremap <silent> <Space>bl :BufferOrderByLanguage<CR>

" telescope
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

" hide hightlights
nnoremap <Leader><space> :noh<cr>

" nvim-tree
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>

set termguicolors " this variable must be enabled for colors to be applied properly
highlight NvimTreeFolderIcon guibg=blue

lua <<EOF
local cmp = require('cmp')
cmp.setup({
    snippet = {
        expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
                return
            end
            fallback()
        end, { 'i', 'c' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
                return
            end
            fallback()
        end, { 'i', 'c' }),
    }),
    sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'vsnip' },
        }, {
            { name = 'buffer' },
        })
})

cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' },
    }, {
        { name = 'buffer' },
    })
})

cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

require'lspconfig'.pyright.setup { capabilities = capabilities }

require'lspconfig'.tsserver.setup { capabilities = capabilities }

require'lspconfig'.gopls.setup { capabilities = capabilities }

-- nvim-treesitter
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "lua", "rust", "go", "javascript", "typescript" },
    highlight = {
        enable = true,
    },
}

-- nvim-tree
require'nvim-tree'.setup {
    disable_netrw = true,
    hijack_netrw = true,
    view = {
      number = true,
      relativenumber = true,
    },
    filters = {
      custom = { ".git" },
    },
    renderer = {
        highlight_opened_files = "icon"
    }
}

local nvim_tree_events = require('nvim-tree.events')
local bufferline_state = require('bufferline.state')

nvim_tree_events.on_tree_open(function ()
  bufferline_state.set_offset(31, "File Tree")
end)

nvim_tree_events.on_tree_close(function ()
  bufferline_state.set_offset(0)
end)

-- which key
require("which-key").setup {} 

-- rust-tools
require'rust-tools'.setup {}
EOF
