# Scrub WhatsApp transcripts containing bidirectional text control characters:
#
# • U+202A Left-To-Right Embedding
# • U+202C Pop Directional Formatting
# • U+200E Left-To-Right Mark
#
# Run this on a Vim buffer directly with `:%!fish -c swa`.
#
# In Vim, type `<C-v>u202a` to insert U+202A. ↓
function swa
  perl -pe 's/‪|‬|‎|([\r\t ]+$)//g'
end
