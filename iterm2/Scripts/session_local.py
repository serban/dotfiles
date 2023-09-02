import sys
sys.dont_write_bytecode = True

import platform

import iterm2

import session

async def main(connection):
  hostname = platform.node().split('.')[0]
  await session.launch(connection, hostname)

if __name__ == '__main__':
  iterm2.run_until_complete(main)
