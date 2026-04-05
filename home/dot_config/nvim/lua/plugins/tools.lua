-- treesitter.lua
-- Specify your treesitter plugin here

local mason_tool_packages = {
    "checkmake",
    "eslint_d",
    "gofumpt",
    "goimports",
    "golangci-lint",
    "hadolint",
    "markdownlint-cli2",
    "markuplint",
    "prettier",
    "ruff",
    "rustfmt",
    "selene",
    "shellcheck",
    "shfmt",
    "stylua",
    "yamlfmt",
    "yamllint",
}

local function ensure_mason_packages(packages)
    if vim.g.mason_tools_ensured then
        return
    end
    vim.g.mason_tools_ensured = true

    local registry = require("mason-registry")
    registry.refresh(function(success)
        if not success then
            vim.schedule(function()
                vim.notify("Mason registry の更新に失敗したため、Formatter/Linter の自動導入をスキップしました。", vim.log.levels.WARN)
            end)
            return
        end

        for _, package_name in ipairs(packages) do
            local ok, pkg = pcall(registry.get_package, package_name)
            if ok and not pkg:is_installed() and not pkg:is_installing() then
                pkg:install()
            end
        end
    end)
end

return {
    {
        "https://github.com/stevearc/overseer.nvim",
        cmd = { "OverseerRun", "OverseerToggle" },
        keys = {
            { "<leader>-", "<CMD>OverseerRun<CR>" },
            { "<leader>_", "<CMD>OverseerToggle<CR>" },
        },
        opts = {},
    },
    {
        "https://github.com/stevearc/conform.nvim",
        cmd = { "ConformInfo" },
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "mason-org/mason.nvim", },
        },
        opts = {
            formatters_by_ft = {
                python = { "ruff_organize_imports", "ruff_format" },
                lua = { "stylua" },
                sh = { "shfmt" },
                bash = { "shfmt" },
                zsh = { "shfmt" },
                html = { "prettier" },
                javascript = { "prettier" },
                javascriptreact = { "prettier" },
                typescript = { "prettier" },
                typescriptreact = { "prettier" },
                vue = { "prettier" },
                yaml = { "yamlfmt" },
                ["yaml.docker-compose"] = { "yamlfmt" },
                go = { "goimports", "gofumpt" },
                rust = { "rustfmt" },
                markdown = { "prettier" },
                ["markdown.mdx"] = { "prettier" },
            },
            format_on_save = function(bufnr)
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                    return
                end
                if vim.bo[bufnr].buftype ~= "" then
                    return
                end

                return {
                    timeout_ms = 1500,
                    lsp_format = "fallback",
                    quiet = true,
                }
            end,
        },
        config = function(_, opts)
            ensure_mason_packages(mason_tool_packages)

            require("conform").setup(opts)

            vim.api.nvim_create_user_command("Format", function(args)
                require("conform").format({
                    async = args.bang,
                    lsp_format = "fallback",
                })
            end, {
                bang = true,
                desc = "Format current buffer",
            })
        end,
    },
    {
        "https://github.com/mfussenegger/nvim-lint",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            { "mason-org/mason.nvim", },
        },
        config = function()
            ensure_mason_packages(mason_tool_packages)

            local lint = require("lint")
            lint.linters_by_ft = {
                python = { "ruff" },
                lua = { "selene" },
                sh = { "shellcheck" },
                bash = { "shellcheck" },
                zsh = { "zsh" },
                html = { "markuplint" },
                javascript = { "eslint_d" },
                javascriptreact = { "eslint_d" },
                typescript = { "eslint_d" },
                typescriptreact = { "eslint_d" },
                vue = { "eslint_d" },
                dockerfile = { "hadolint" },
                ["yaml.docker-compose"] = { "yamllint" },
                go = { "golangcilint" },
                markdown = { "markdownlint-cli2" },
                ["markdown.mdx"] = { "markdownlint-cli2" },
                make = { "checkmake" },
            }

            vim.api.nvim_create_autocmd("BufWritePost", {
                group = vim.api.nvim_create_augroup("my.nvim-lint", { clear = true }),
                callback = function()
                    lint.try_lint()
                end,
            })

            vim.api.nvim_create_user_command("Lint", function()
                lint.try_lint()
            end, {
                desc = "Run configured linter for current buffer",
            })
        end,
    },
}
