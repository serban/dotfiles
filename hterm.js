// vim:set ts=8 sw=2 sts=2 et:

var solarized = {
  // Common
  S_yellow:  '#b58900',
  S_orange:  '#cb4b16',
  S_red:     '#dc322f',
  S_magenta: '#d33682',
  S_violet:  '#6c71c4',
  S_blue:    '#268bd2',
  S_cyan:    '#2aa198',
  S_green:   '#859900',

/*
  // Dark
  S_base03:  '#002b36',
  S_base02:  '#073642',
  S_base01:  '#586e75',
  S_base00:  '#657b83',
  S_base0:   '#839496',
  S_base1:   '#93a1a1',
  S_base2:   '#eee8d5',
  S_base3:   '#fdf6e3',
*/

  // Light
  S_base03:  '#fdf6e3',
  S_base02:  '#eee8d5',
  S_base01:  '#93a1a1',
  S_base00:  '#839496',
  S_base0:   '#657b83',
  S_base1:   '#586e75',
  S_base2:   '#073642',
  S_base3:   '#002b36'
};

function setPreferences() {
  term_.prefs_.resetAll();

  term_.prefs_.set('alt-is-meta', true);
  term_.prefs_.set('environment', {TERM: 'xterm'});

  term_.prefs_.set('scroll-on-keystroke', true);
  term_.prefs_.set('scroll-on-output', false);

  term_.prefs_.set('font-family', 'Monaco');
  term_.prefs_.set('font-size', 14);
  term_.prefs_.set('font-smoothing', 'subpixel-antialiased');

  term_.prefs_.set('enable-bold', false);

  term_.prefs_.set('background-color', solarized.S_base03);
  term_.prefs_.set('foreground-color', solarized.S_base0);

//term_.prefs_.set('cursor-color', solarized.S_base1);
  term_.prefs_.set('cursor-color', 'rgba(88, 110, 117, 0.7)');

  term_.prefs_.set('color-palette-overrides', {
     0: solarized.S_base02,
     1: solarized.S_red,
     2: solarized.S_green,
     3: solarized.S_yellow,
     4: solarized.S_blue,
     5: solarized.S_magenta,
     6: solarized.S_cyan,
     7: solarized.S_base2,
     8: solarized.S_base03,
     9: solarized.S_orange,
    10: solarized.S_base01,
    11: solarized.S_base00,
    12: solarized.S_base0,
    13: solarized.S_violet,
    14: solarized.S_base1,
    15: solarized.S_base3
  });
}
