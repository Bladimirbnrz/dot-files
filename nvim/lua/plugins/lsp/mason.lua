return {
  "mason-org/mason.nvim",
  -- opts = {},
  config = function()
    require("mason").setup()
    local mason_registry = require("mason-registry")

    local tools = {
      "ruff",
      "pyright",
      "lua-language-server"
    }

    mason_registry.refresh(function()
      for _, tool in ipairs(tools) do
        local ok, pkg = pcall(mason_registry.get_package, tool)

        if ok and not pkg:is_installed() then
          pkg:install()
        end
      end
    end)
  end,
}
