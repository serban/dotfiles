function n
  if type --query nautilus
    nautilus . > /dev/null 2>&1 &
    return
  end

  open .
end
