function px
  plutil -convert xml1 -o - $argv | bat --plain --language xml
end
