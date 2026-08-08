return {
    {
        "saghen/blink.cmp",
        opts = {
            sources = {
                -- Wrapping this in a function completely replaces the default
                -- sources (buffer, path, snippets) so ONLY 'lsp' remains.
                default = function()
                    return { "lsp" }
                end,
            },
        },
    },
}
