#!/usr/bin/env py

#  → https://www.youtube.com/feed/channels
#
#  1. Go to https://takeout.google.com/takeout/custom/youtube.
#  2. Click 'All YouTube data included'.
#  3. Click 'Deselect all'.
#  4. Check 'subscriptions'.
#  5. Click 'OK'.
#  6. Click 'Next step'.
#  7. Under 'File type & size' select '.tgz'.
#  8. Click 'Create export'.
#  9. Click 'Download'.
# 10. Extract `Takeout/YouTube and YouTube Music/subscriptions/subscriptions.csv` from the archive.
# 11. Run `yt2nb subscriptions.csv`.

import csv
import sys

with open(sys.argv[1]) as csv_file:
  csv_reader = csv.DictReader(csv_file, fieldnames=('id', 'url', 'title'))
  next(csv_reader)  # Skip the header row

  for row in csv_reader:
    url = f'https://www.youtube.com/feeds/videos.xml?channel_id={row["id"]}'
    name = f'"~{row["title"]}"'
    tag = 'YouTube'
    print(f'  {url:76}  {name:50}  {tag}')
