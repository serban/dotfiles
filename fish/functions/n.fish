function n
  if type --quiet nautilus
    nautilus . > /dev/null 2>&1 &
    return
  end

  open .
end
