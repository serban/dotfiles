import sys
sys.dont_write_bytecode = True

import iterm2

import session

async def main(connection):
  await session.launch(connection, 'minimal')

if __name__ == '__main__':
  iterm2.run_until_complete(main)
