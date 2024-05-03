serban = {}

hs.logger.setGlobalLogLevel('warning') -- error, warning, info, debug, verbose
serban.logger = hs.logger.new('serban', 'info') -- Quiet all loggers but mine

serban.grid     = require('serban.grid')

serban.actions  = require('serban.actions')
serban.apps     = require('serban.apps')
serban.ax       = require('serban.ax')
serban.max      = require('serban.max')
serban.place    = require('serban.place')
serban.screen   = require('serban.screen')
serban.windows  = require('serban.windows')

serban.finder   = require('serban.finder')

serban.keys     = require('serban.keys')

hs.window.animationDuration = 0

function b(v)
  if     v == nil then return '∅' -- utf8.len('∅') → 1, string.len('∅') → 3
  elseif v == true then return '✓' -- utf8.len('✓') → 1, string.len('✓') → 3
  elseif v == false then return '✗' -- utf8.len('✗') → 1, string.len('✗') → 3
  else return '?'
  end
end
