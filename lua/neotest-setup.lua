require('neotest').setup {
  adapters = {
    require 'neotest-java' {
      ignore_wrapper = false,       -- whether to ignore maven/gradle wrapper
    },
  },
  summary = {
    open = 'vsplit | vertical resize 100',
  },
}
