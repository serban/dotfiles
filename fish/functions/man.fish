# U+1F4D5  📕  Closed Book
# U+1F4D9  📙  Orange Book
# U+1F4D7  📗  Green Book
# U+1F4D8  📘  Blue Book
# U+1F4D2  📒  Ledger

function man --wraps man
  title 📙 $argv
  command man $argv
end
