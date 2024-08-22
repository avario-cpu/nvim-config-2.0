return {
  "hrsh7th/cmp-cmdline",
  event = "InsertEnter",
  config = function()
    local cmp = require("cmp")
    local config = cmp.get_config()
    table.insert(config.sources, {
      name = "path",
    })
    table.insert(config.sources, {
      name = "cmdline",
      option = {
        ignore_cmds = { "Man", "!" },
      },
    })
    config.mapping = cmp.mapping.preset.cmdline()
    -- `:` cmdline setup.
    cmp.setup.cmdline(":", config)
    -- `/` cmdline setup.
    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })
    cmp.setup(config)
  end,
}
