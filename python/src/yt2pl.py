#!/usr/bin/env py

#  → https://www.youtube.com/playlist?list=WL
#
#  1. Go to https://takeout.google.com/takeout/custom/youtube.
#  2. Click 'All YouTube data included'.
#  3. Click 'Deselect all'.
#  4. Check 'playlists'.
#  5. Click 'OK'.
#  6. Click 'Next step'.
#  7. Under 'File type & size' select '.tgz'.
#  8. Click 'Create export'.
#  9. Click 'Download'.
# 10. Extract `Takeout/YouTube and YouTube Music/playlists/` from the archive.
# 11. Run `yt2pl 'Watch later.csv'`.

import csv
import sys

with open(sys.argv[1]) as csv_file:
  csv_reader = csv.DictReader(csv_file, fieldnames=('id', 'added'))
  next(csv_reader)  # Skip the playlist metadata header row
  next(csv_reader)  # Skip the playlist header row
  next(csv_reader)  # Skip the header row

  for row in csv_reader:
    id = row['id'].strip()  # IDs starting with a - have a leading space
    url = f'https://www.youtube.com/watch?v={id}'
    print(url)
