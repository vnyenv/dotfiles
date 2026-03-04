return {
    "seblyng/roslyn.nvim",
    ft = { "cs", "csproj", "sln", "cshtml", "razor" },
    dependencies = { "nvim-lspconfig" },

    opts = {
        filewatching = "auto",
        choose_target = nil,
        ignore_target = nil,
        broad_search = false,
        lock_target = false,
        silent = false,
    },

    vim.lsp.config("roslyn", {
        settings = {
            ["csharp|background_analysis"] = {
                dotnet_analyzer_diagnostics_scope = "fullSolution",
                dotnet_compiler_diagnostics_scope = "fullSolution",
            },
            ["csharp|code_lens"] = {
                dotnet_enable_references_code_lens = true,
                dotnet_enable_tests_code_lens = true,
            },
            ["csharp|completion"] = {
                dotnet_provide_regex_completions = false,
                dotnet_show_completion_items_from_unimported_namespaces = true,
                dotnet_show_name_completion_suggestions = true,
            },
            ["csharp|inlay_hints"] = {
                csharp_enable_inlay_hints_for_implicit_object_creation = true,
                csharp_enable_inlay_hints_for_implicit_variable_types = true,
                csharp_enable_inlay_hints_for_lambda_parameter_types = true,
                csharp_enable_inlay_hints_for_types = true,
                dotnet_enable_inlay_hints_for_indexer_parameters = true,
                dotnet_enable_inlay_hints_for_literal_parameters = true,
                dotnet_enable_inlay_hints_for_object_creation_parameters = true,
                dotnet_enable_inlay_hints_for_other_parameters = true,
                dotnet_enable_inlay_hints_for_parameters = true,
                dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
                dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
                dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
            },
            ["csharp|symbol_search"] = {
                dotnet_search_reference_assemblies = true,
            },
            ["csharp|formatting"] = {
                dotnet_organize_imports_on_format = true,
            },
        },

        on_attach = function(bufnr)
            --vim.lsp.inlay_hint.enable(true, bufnr)
            vim.lsp.codelens.refresh()
        end,

        vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "BufWritePost" }, {
            pattern = { "*.cs", "*.cshtml", "*.razor" },
            callback = function(args)
                local clients = vim.lsp.get_clients({ bufnr = args.buf })
                for _, client in ipairs(clients) do
                    if client.name == "roslyn" then
                        vim.lsp.codelens.refresh()
                        break
                    end
                end
            end,
        }),
    })
}
