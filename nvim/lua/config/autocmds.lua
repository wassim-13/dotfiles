-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd("FileType", {
    pattern = "rust",
    callback = function()
        vim.keymap.set("i", "'", function()
            local col = vim.fn.col(".")
            local line = vim.fn.getline(".")
            local text_before = line:sub(1, col - 1)
            local char_before = line:sub(col - 1, col - 1)

            -- 1. Lifetime triggers directly after & or < (e.g., &'a, <'a>)
            if char_before:match("[&<]") then
                return "'"
            end

            -- 2. Lifetimes after commas, colons, or pluses (e.g., <'a, 'b>, 'a: 'b, dyn Trait + 'a)
            if text_before:match("[,:+]%s*$") then
                return "'"
            end

            -- 3. Lifetimes after keywords (e.g., where 'a, for<'a>)
            if text_before:match("%f[%w]where%s+$") or text_before:match("%f[%w]for%s+$") then
                return "'"
            end

            -- 4. Normal char literals (e.g., let c = 'x';) -> auto-pair ''
            return "''<Left>"
        end, { expr = true, buffer = 0, desc = "Smart single quote for Rust lifetimes" })
    end,
})
