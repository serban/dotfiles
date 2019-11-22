function perms --argument-names dir_mode file_mode dir
  find "$dir" -type d -exec chmod -v "$dir_mode" '{}' \; | grep -v retained
  find "$dir" -type f -exec chmod -v "$file_mode" '{}' \; | grep -v retained
end
