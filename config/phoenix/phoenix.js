// via https://github.com/azamuddin/phoenix/
// Preferences
Phoenix.set({
  daemon: true,
  openAtLogin: true,
});

Event.on('willTerminate', () => {
  Storage.remove('lastPositions');
  Storage.remove('maxHeight');
})

function frameRatio(a, b){
  const widthRatio = b.width / a.width;
  const heightRatio = b.height / a.height;

  return ({width, height, x, y}) => {
    width = Math.round(width * widthRatio);
    height = Math.round(height * heightRatio);
    x = Math.round(b.x + (x - a.x) * widthRatio);
    y = Math.round(b.y + (y - a.y) * heightRatio);

    return {width, height, x, y};
  };
}

// Globals
const HIDDEN_DOCK_MARGIN = 3;
const INCREMENT_PERCENT = 0.05;
const SUPER = ['ctrl', 'cmd', 'alt'];
const SHIFT_SUPER = ['ctrl', 'cmd', 'alt', 'shift'];

// Relative Directions
const LEFT = 'left';
const RIGHT = 'right';
const CENTRE = 'centre';

// Cardinal Directions
const NW = 'nw';
const NE = 'ne';
const SE = 'se';
const SW = 'sw';
const EAST = 'east';
const WEST = 'west';
const NORTH = 'north';
const SOUTH = 'south';

class ChainWindow {
  constructor(window, margin = 10) {
    this.window = window;
    this.margin = margin;
    this.frame = window.frame();
    this.parent = window.screen().flippedVisibleFrame();
  }

  // Difference frame
  difference() {
    const { parent, frame } = this;
    return {
      x: parent.x - frame.x,
      y: parent.y - frame.y,
      width: parent.width - frame.width,
      height: parent.height - frame.height,
    };
  }

  // Set frame
  set() {
    const { window, frame } = this;
    window.setFrame(frame);
    this.frame = window.frame();
    return this;
  }

  // Move to screen
  screen(screen) {
    this.parent = screen.flippedVisibleFrame();
    return this;
  }

  // Move to cardinal directions NW, NE, SE, SW or relative direction CENTRE
  to(direction) {
    const { parent, margin } = this;
    const difference = this.difference();

    // X-coordinate
    switch (direction) {
      case NW:
      case SW:
        this.frame.x = parent.x + margin;
        break;
      case NE:
      case SE:
        this.frame.x = parent.x + difference.width - margin ;
        break;
      case CENTRE:
      case NORTH:
      case SOUTH:
        this.frame.x = parent.x + (difference.width / 2);
        break;
      default:
    }

    // Y-coordinate
    switch (direction) {
      case NW:
      case NE:
        this.frame.y = parent.y + margin;
        break;
      case SE:
      case SW:
        this.frame.y = parent.y + difference.height - margin;
        break;
      case CENTRE:
        this.frame.y = parent.y + (difference.height / 2);
        break;
      case NORTH:
        this.frame.y = 0;
        break;
      case SOUTH:
        this.frame.y = difference.height;
        break;
      default:
    }

    return this;
  }

  // Resize SE-corner by factor
  resize(factor) {
    const { parent, margin, frame } = this;
    const difference = this.difference();
    let delta;
    if (factor.width) {
      delta = Math.min(parent.width * factor.width, difference.x + difference.width - margin);
      this.frame.width += delta;
    } else if (factor.height) {
      delta = Math.min(
        parent.height * factor.height,
        difference.height - frame.y + margin + HIDDEN_DOCK_MARGIN,
      );
      this.frame.height += delta;
    }
    return this;
  }

  // Maximise to fill whole screen
  maximise() {
    const { parent, margin } = this;

    this.frame.width = parent.width - (2 * margin);
    this.frame.height = parent.height - (2 * margin);
    return this;
  }

  // Halve width
  halve() {
    this.frame.width /= 2;
    return this;
  }

  // Fit to screen
  fit() {
    const difference = this.difference();
    if (difference.width < 0 || difference.height < 0) {
      this.maximise();
    }
    return this;
  }

  // Fill relatively to LEFT or RIGHT-side of screen, or fill whole screen
  fill(direction) {
    this.maximise();
    if (direction === LEFT || direction === RIGHT) {
      this.halve();
    }
    if (direction === CENTRE) {
      this.frame.width /= 3;
    }
    switch (direction) {
      case LEFT:
        this.to(NW);
        break;
      case RIGHT:
        this.to(NE);
        break;
      case CENTRE:
        this.to(CENTRE);
        break;
      default:
        this.to(NW);
    }
    return this;
  }
}

// Chain a Window-object
Window.prototype.chain = function () {
  return new ChainWindow(this);
};

// To direction in screen
Window.prototype.to = function (direction, screen) {
  const window = this.chain();
  if (screen) {
    window.screen(screen).fit();
  }
  window.to(direction).set();
};

// Fill in screen
Window.prototype.fill = function (direction, screen) {
  const window = this.chain();
  if (screen) {
    window.screen(screen);
  }
  window.fill(direction).set();
  // Ensure position for windows larger than expected
  if (direction === RIGHT) {
    window.to(NE).set();
  }
};

// Resize by factor
Window.prototype.resize = function (factor) {
  this.chain().resize(factor).set();
};

/* Position Bindings */

Key.on('y', SUPER, () => {
  const window = Window.focused();
  if (window) {
    window.to(NW);
  }
});

Key.on('u', SUPER, () => {
  const window = Window.focused();
  if (window) {
    window.to(NORTH);
  }
});

Key.on('i', SUPER, () => {
  const window = Window.focused();
  if (window) {
    window.to(NE);
  }
});

Key.on('n', SUPER, () => {
  const window = Window.focused();
  if (window) {
    window.to(SW);
  }
});

Key.on('m', SUPER, () => {
  const window = Window.focused();
  if (window) {
    window.to(SOUTH);
  }
});

Key.on(',', SUPER, () => {
  const window = Window.focused();
  if (window) {
    window.to(SE);
  }
});

Key.on('c', SUPER, () => {
  const window = Window.focused();
  if (window) {
    window.to(CENTRE, window.screen().next());
  }
});

// [> Fill Bindings <]

Key.on('left', SUPER, () => {
  const window = Window.focused();
  if (window) {
    window.fill(LEFT);
  }
});

Key.on('right', SUPER, () => {
  const window = Window.focused();
  if (window) {
    window.fill(RIGHT);
  }
});

Key.on('b', SUPER, () => {
  const window = Window.focused();
  if (window) {
    window.fill(CENTRE);
  }
});

// [> Size Bindings <]

Key.on('h', SUPER, () => {
  const window = Window.focused();
  if (window) {
    window.resize({ width: -INCREMENT_PERCENT });
  }
});

Key.on('j', SUPER, () => {
  const window = Window.focused();
  if (window) {
    window.resize({ height: INCREMENT_PERCENT });
  }
});

Key.on('k', SUPER, () => {
  const window = Window.focused();
  if (window) {
    window.resize({ height: -INCREMENT_PERCENT });
  }
});

Key.on('l', SUPER, () => {
  const window = Window.focused();
  if (window) {
    window.resize({ width: INCREMENT_PERCENT });
  }
});

// [> Focus Bindings <]

Key.on('.', SUPER, () => {
  const last = _.last(Window.recent());
  if (last) {
    last.focus();
  }
});


Key.on('.', SUPER, () => {
  const window = Window.focused();
  if(!window){
    return
  }

  const oldScreen = window.screen();
  const newScreen = oldScreen.next();

  if(oldScreen.isEqual(newScreen)){
     return;
  }

  const ratio = frameRatio(
     oldScreen.flippedVisibleFrame(),
     newScreen.flippedVisibleFrame(),
  )

  window.setFrame(ratio(window.frame()));

})



// [>* toggle max screen *<]
Key.on('v', SUPER, () => {

  const window =
    Window.focused();

  if(!window) return;

  const margin =
    window.chain().margin;

  const windowId =
    window.hash();

  const screen =
    window.screen().flippedVisibleFrame()

  let lastPositions =
    Storage.get('lastPositions') || {};

   if(!lastPositions[windowId]){
    lastPositions[windowId] =
       {x: window.topLeft().x, y: window.topLeft().y, width: window.size().width, height: window.size().height}
   }

  const maxHeight =
    Storage.get('maxHeight') || screen.height - (2*margin);

  const maxWidth =
    Storage.get('maxWidth') || screen.width - (margin);

  if(window.size().width !== maxWidth || window.size().height !== maxHeight){

    lastPositions[windowId] =
      {x: window.topLeft().x, y: window.topLeft().y, width: window.size().width, height: window.size().height}

    Storage.set('lastPositions', lastPositions)

    window.setTopLeft({
      x: screen.x + margin,
      y: screen.y + margin,
    })

    window.setSize({
      height: screen.height - (2*margin),
      width: screen.width - (1.6 * margin)
    });

    Storage.set('maxHeight', window.size().height);
    Storage.set('maxWidth', window.size().width);

    return;
  }

  if(window){

    window.setSize({
      width: lastPositions[windowId].width,
      height: lastPositions[windowId].height,
    });

    window.setTopLeft({
      x: lastPositions[windowId].x,
      y: lastPositions[windowId].y
    });
  }

})

// Key.on('h', CONTROL_SHIFT, function(){
//   const window =
//     Window.focused();
//
//   if(window){
//     window.focusClosestNeighbor(WEST);
//   }
// })
//
// Key.on('j', CONTROL_SHIFT, function(){
//   const window =
//     Window.focused();
//
//   if(window){
//      window.focusClosestNeighbor(SOUTH);
//   }
// });
//
// Key.on('k', CONTROL_SHIFT, function(){
//   const window =
//     Window.focused();
//
//   if(window){
//      window.focusClosestNeighbor(NORTH)
//   }
// })
//
// Key.on('l', CONTROL_SHIFT, function(){
//    const window =
//     Window.focused();
//
//    if(window){
//      window.focusClosestNeighbor(EAST)
//    }
// })

Key.on('/', SUPER, function(){

  const window =
    Window.focused();

  window.setSize({
    height: window.size().height / 2,
    width: window.size().width
  })
})


/**
 * Move window to space on the right
 */
// Key.on('right', CONTROL_SHIFT, function(){
//
//   const window =
//     Window.focused();
//
//   const space =
//     Space.active();
//
//   if(!window || !space) return;
//
//   const nextSpace =
//     space.next();
//
//   space.removeWindows([window]);
//   nextSpace.addWindows([window]);
//
//   window.focus();
//
// });
//
//
/**
 * Move window to space on the left
 */
// Key.on('left', CONTROL_SHIFT, function(){
//
//   const window =
//     Window.focused();
//
//   const space =
//     Space.active();
//
//   if(!window || !space) return;
//
//   const previousSpace =
//     space.previous();
//
//   space.removeWindows([window]);
//   previousSpace.addWindows([window]);
//
//   window.focus();
//
// })
//


// Hints
// via https://github.com/purag/.files/blob/master/meat/osx/.phoenix.js
var HINT_APPEARANCE = "dark";
var HINT_BUTTON = "space";
var HINT_CANCEL = "escape";
var HINT_CHARS = "FJDKSLAGHRUEIWOVNCM";
const PADDING = 5;
var hintsActive = false;
var hintkeys = [];
var hints = {};
var escbind = null;
var bsbind = null;

function cancelHints () {
  for (var activator in hints) {
    hints[activator].modal.close();
  };
  Key.off(escbind);
  Key.off(bsbind);
  hintkeys.map(Key.off);
  hints = {};
  hintkeys = [];
  hintsActive = false;
}

function showHints (windows, prefix = "") {
  if (windows.length > HINT_CHARS.length) {
    var lists = _.toArray(_.groupBy(windows, function (win, k) {
      return k % HINT_CHARS.length;
    }));
    for (var j = 0; j < HINT_CHARS.length; j++) {
      showHints(lists[j], prefix + HINT_CHARS[j]);
    }
    return;
  }

  windows.forEach(function (win, i) {
    var helper = "";
    if (win.app().windows().length > 1) {
      helper += "  |  " + win.title().substr(0, 15) + (win.title().length > 15 ? "…" : "");
    }
    var hint = buildhint(prefix + HINT_CHARS[i] + helper, win);

    var activators = Object.keys(hints);
    for (var l = 0; l < activators.length; l++) {
      var hint2 = hints[activators[l]].modal;
      if (
        hint.origin.x < hint2.origin.x + hint2.frame().width + PADDING
        && hint.origin.x + hint.frame().width > hint2.origin.x - PADDING
        && hint.origin.y < hint2.origin.y + hint2.frame().height + PADDING
        && hint.origin.y + hint.frame().width > hint2.origin.y - PADDING
      ) {
        hint.origin = {
          x: hint.origin.x,
          y: hint2.origin.y + hint2.frame().height + PADDING
        };
        l = -1;
      }
    }

    hints[prefix + HINT_CHARS[i]] = {
      win,
      modal: hint,
      position: 0,
      active: true
    };
  });
  escbind = Key.on(HINT_CANCEL, [], cancelHints);
  hintsActive = true;
}

Key.on(HINT_BUTTON, SUPER, function () {
  if (hintsActive) {
    cancelHints();
    return
  }

  showHints(Window.all({
    visible: true
  }));

  var sequence = "";
  HINT_CHARS.split("").forEach(function (hintchar) {
    hintkeys.push(Key.on(hintchar, [], function () {
      sequence += hintchar;
      for (var activator in hints) {
        var hint = hints[activator];
        if (!hint.active) continue;
        if (activator[hint.position] === hintchar) {
          hint.position++;
          if (hint.position === activator.length) {
            hint.win.focus();
            Mouse.move({
              x: hint.modal.origin.x + hint.modal.frame().width / 2,
              y: Screen.all()[0].frame().height - hint.modal.origin.y - hint.modal.frame().height / 2
            });
            return cancelHints();
          }
          hint.modal.text = hint.modal.text.substr(1);
        } else {
          hint.modal.close();
          hint.active = false;
        }
      }
    }));
  });
  bsbind = Key.on("delete", [], function () {
    if (!sequence.length) cancelHints();
    var letter = sequence[sequence.length - 1];
    sequence = sequence.substr(0, sequence.length - 1);
    for (var activator in hints) {
      var hint = hints[activator];
      if (hint.active) {
        hint.position--;
        hint.modal.text = letter + hint.modal.text;
      } else if (activator.substr(0, sequence.length) === sequence) {
        hint.modal.show();
        hint.active = true;
      }
    }
  });
});

Event.on("mouseDidLeftClick", cancelHints);

function buildhint (msg, win) {
  var wf = win.frame();
  var wsf = win.screen().frame();
  var modal = Modal.build({
    text: msg,
    appearance: HINT_APPEARANCE,
    icon: win.app().icon(),
    weight: 16
  });
  var mf = modal.frame();
  modal.origin = {
    x: Math.min(
      Math.max(wf.x + wf.width / 2 - mf.width / 2, wsf.x),
      wsf.x + wsf.width - mf.width
    ),
    y: Math.min(
      Math.max(Screen.all()[0].frame().height - (wf.y + wf.height / 2 + mf.height / 2), wsf.y),
      wsf.y + wsf.height - mf.height
    )
  };
  modal.show();
  return modal;
}
