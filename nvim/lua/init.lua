require'nvim-tree'.setup {
    update_cwd = true,
    diagnostics = {
        enable = true,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        }
    },
    view = {
		width = function()
            return math.floor(vim.o.columns * 0.2)
        end,
        side = 'left'
    },
    renderer = {
        icons = {
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true
            },
            glyphs = {
                default = '',
                symlink = '',
                folder = {
                    arrow_closed = "",
                    arrow_open = "",
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                    symlink_open = "",
                },
                git = {
                    unstaged = "✗",
                    staged = "✓",
                    unmerged = "",
                    renamed = "➜",
                    untracked = "★",
                    deleted = "",
                    ignored = "◌"
                }
            }
        }
    }
}
