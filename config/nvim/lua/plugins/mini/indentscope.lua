-- Indent line scope highlight
return {
  "echasnovski/mini.indentscope",
  optional = true,
  opts = function(_, opts)
    opts.draw = opts.draw or {}
    opts.draw.animation = require("mini.indentscope").gen_animation.none()
  end,
}
