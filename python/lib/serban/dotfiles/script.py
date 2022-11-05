def header(s):
  width = 80
  pad = max(width - 4, len(s))

  horizontal_line = '─'
  vertical_line   = '│'
  upper_left      = '╭'
  upper_right     = '╮'
  lower_left      = '╰'
  lower_right     = '╯'

  print('{}{}{}'.format(upper_left, horizontal_line*(pad+2), upper_right))
  print('{} {:{pad}} {}'.format(vertical_line, s, vertical_line, pad=pad))
  print('{}{}{}'.format(lower_left, horizontal_line*(pad+2), lower_right))

def separator():
  print(f'  {"─"*76}  ')
