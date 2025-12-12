function clip
  perl -gpe 's/\n\z//' | fish_clipboard_copy
end
