function serban_header
  set --local pad 76
  set --local len (string length "$argv")

  if test $len -gt $pad
    set pad $len
  end

  python3 -c "print('+-{}-+'.format('-'*$pad));     \
              print('| {:$pad} |'.format('$argv')); \
              print('+-{}-+'.format('-'*$pad));     "
end
