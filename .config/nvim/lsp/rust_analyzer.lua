return {
    cmd = { 'rust-analyzer' },
    filetypes = { 'rust' },
    root_markers = { 'Cargo.toml', 'Cargo.lock', '.git' },
    settings = {
        ['rust-analyzer'] = {
            cargo = {
                features = 'all',
            },
            procMacro = {
                enable = true,
            },
            check = {
                command = 'clippy',
                features = 'all',
            },
            diagnostics = {
                styleLints = { enable = true },
                experimental = { enable = true },
            },
        },
    },
}
