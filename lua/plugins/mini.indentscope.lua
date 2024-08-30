return {
  "echasnovski/mini.indentscope",
  opts = {
    draw = {
      delay = 1,
      animation = require("mini.indentscope").gen_animation.quadratic({
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
