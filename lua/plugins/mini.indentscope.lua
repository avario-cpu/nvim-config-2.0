return {
  "echasnovski/mini.indentscope",
  enabled = false,
  opts = {
    draw = {
      delay = 1,
      animation = require("mini.indentscope").gen_animation.cubic({
        easing = "in-out",
        duration = 4,
        unit = "step",
      }),
    },
    mappings = {
      object_scope_with_border = "",
    },
  },
}
