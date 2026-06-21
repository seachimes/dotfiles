return {
  "monaqa/dial.nvim",
  keys = {
    { "<C-a>",  "<Plug>(dial-increment)",            desc = "Increment",            mode = { "n", "v" } },
    { "<C-x>",  "<Plug>(dial-decrement)",            desc = "Decrement",            mode = { "n", "v" } },
    { "g<C-a>", "<Plug>(dial-increment-additional)", desc = "Increment Additional", mode = { "n", "v" } },
    { "g<C-x>", "<Plug>(dial-decrement-additional)", desc = "Decrement Additional", mode = { "n", "v" } },
  },
  config = function()
    local augend = require("dial.augend")
    require("dial.config").augends:register_group {
      default = {
        augend.integer.alias.decimal,
        augend.integer.alias.decimal_int,
        augend.integer.alias.hex,
        augend.date.alias["%Y/%m/%d"],
        augend.constant.new({ elements = { "first", "second", "third", "fourth", "fifth", "sixth", "seventh", "eighth", "ninth", "tenth" }, cyclic = true }),
        augend.constant.new({ elements = { "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday" }, word = true, cyclic = true }),
        augend.constant.new({ elements = { "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" }, word = true, cyclic = true }),
        augend.constant.new({ elements = { "True", "False" }, word = true, cyclic = true }),
        augend.constant.alias.bool,
        augend.constant.new({ elements = { "&&", "||" }, cyclic = true }),
      },
      typescript = {
        augend.constant.new({ elements = { "let", "const" } }),
      },
      css = {
        augend.hexcolor.new({ case = "lower" }),
        augend.hexcolor.new({ case = "upper" }),
      },
      markdown = {
        augend.constant.new({ elements = { "[ ]", "[x]" }, cyclic = true }),
        augend.misc.alias.markdown_header,
      },
      json = {
        augend.semver.alias.semver,
      },
      lua = {
        augend.constant.new({ elements = { "and", "or" }, word = true, cyclic = true }),
      },
      python = {
        augend.constant.new({ elements = { "and", "or" }, cyclic = true }),
      },
    }
  end,
}
