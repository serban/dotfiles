function pj
  plutil -convert json -o - $argv | jq . | bat --plain --language json
end
