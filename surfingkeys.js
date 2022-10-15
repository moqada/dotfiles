const {Hints, map, iunmap} = api;
// scroll page down
map('<Ctrl-d>', 'd');
// scroll page up
map('<Ctrl-u>', 'u');

// history go back
map('h', 'S');
// history go forward
map('l', 'D');

// tab move right
map('J', 'R');
// tab move left
map('K', 'E');

// open link in active new Tab
map('F', 'af');

// hint characters only use right hand
Hints.characters = 'yuiophjklnm';

settings.smoothScroll = false;
settings.blocklistPattern =
  /(mail|docs).google.com|www.google.com\/calendar|trello.com|toggl.com|feedly.com|snack.expo.dev|github.dev|gather.town/;

// disable emoji suggestions at some domains.
iunmap(':', /github\.com/i);
// disable surfingkeys's built-in keymap
iunmap('<Ctrl-e>');

// an example to create a new mapping `ctrl-y`
// mapkey('<Ctrl-y>', 'Show me the money', function() {
//     Front.showPopup('a well-known phrase uttered by characters in the 1996 film Jerry Maguire (Escape to close).');
// });

// an example to replace `T` with `gt`, click `Default mappings` to see how `T` works.
// map('gt', 'T');

// an example to remove mapkey `Ctrl-i`
// unmap('<Ctrl-i>');

// set theme
settings.theme = `
.sk_theme {
    font-family: Input Sans Condensed, Charcoal, sans-serif;
    font-size: 10pt;
    background: #24272e;
    color: #abb2bf;
}
.sk_theme tbody {
    color: #fff;
}
.sk_theme input {
    color: #d0d0d0;
}
.sk_theme .url {
    color: #61afef;
}
.sk_theme .annotation {
    color: #56b6c2;
}
.sk_theme .omnibar_highlight {
    color: #528bff;
}
.sk_theme .omnibar_timestamp {
    color: #e5c07b;
}
.sk_theme .omnibar_visitcount {
    color: #98c379;
}
.sk_theme #sk_omnibarSearchResult ul li:nth-child(odd) {
    background: #303030;
}
.sk_theme #sk_omnibarSearchResult ul li.focused {
    background: #3e4452;
}
#sk_status, #sk_find {
    font-size: 20pt;
}`;
// click `Save` button to make above settings to take effect.
