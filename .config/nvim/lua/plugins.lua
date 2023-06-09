local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    -- General Plugins
    use 'wbthomason/packer.nvim'
    use 'vim-airline/vim-airline'
    use 'vim-airline/vim-airline-themes'
    use 'tpope/vim-fugitive'
    use 'airblade/vim-gitgutter'
    use 'Yggdroot/indentLine'
    use 'tpope/vim-rhubarb'
    use { "ellisonleao/gruvbox.nvim" }
    use 'tpope/vim-sensible'

    -- Discord
    use 'andweeb/presence.nvim'

    -- Nvim-Tree
    use 'nvim-tree/nvim-web-devicons'
    use 'nvim-tree/nvim-tree.lua'

    -- Telescope
    use 'junegunn/fzf'
    use 'nvim-lua/plenary.nvim'
    use { 'nvim-telescope/telescope.nvim', tag = '0.1.1' }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

    -- Treesitter
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use { 'nvim-treesitter/nvim-treesitter-context', run = ':TSContextEnable' }

    --nvim-lspconfig
    use 'neovim/nvim-lspconfig'

    -- Nvim-Cmp
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'

    -- LuaSnip
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'

    -- Go
    use { 'fatih/vim-go', run = ':GoInstallBinaries' }

    -- Rust
    use 'simrat39/rust-tools.nvim'
    use 'mfussenegger/nvim-dap'

    -- Zig
    use 'ziglang/zig.vim'

    -- LaTeX
    use 'LaTex-Box-Team/LaTeX-Box'

    -- JavaScript
    use 'jelera/vim-javascript-syntax'

    -- Copilot
    use 'github/copilot.vim'

    if packer_bootstrap then
        require('packer').sync()
    end
end)
