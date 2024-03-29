#!/usr/bin/env py

# TODO(serban): Is the UTC offset printed by %z correct?

import sys
import time

seconds_since_epoch = int(sys.argv[1])

print('{:6}  {}'.format('Local',
    time.strftime('%Y-%m-%d %H:%M:%S %z', time.localtime(seconds_since_epoch))))
print('{:6}  {}'.format('UTC',
    time.strftime('%Y-%m-%d %H:%M:%S', time.gmtime(seconds_since_epoch))))
