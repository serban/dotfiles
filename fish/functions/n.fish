function n
  if type --quiet nautilus
    nautilus --no-desktop . > /dev/null 2>&1 &
  end

  open .
end
