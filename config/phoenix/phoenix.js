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
  // y = distance from the top of the screen
  // height = delta between screen height and max height
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

  /*
   * move the window by a factor
   * unless moving would exceed the window bounds at the bottom
   * -> noop
   * unless moving would exceed the window bounds at the top
   * -> noop
  */

  move({width, height}) {
    const { parent, margin, frame } = this;
    const difference = this.difference();

    if (width != null) {
      const widthFactor = parent.width * width
      const delta = Math.min(widthFactor, difference.x + difference.width - margin);
      frame.x += delta
      if (frame.x < margin) frame.x = margin
      else if (frame.x > parent.width - margin) frame.x = parent.width - margin
    } else if (height != null) {
      const heightFactor = parent.height * height
      const maxHeight = parent.height - (margin * 2)
      const delta = Math.min(
        heightFactor,
        difference.height - frame.y + (margin * 2) + HIDDEN_DOCK_MARGIN,
      );
      if ((frame.y + delta) < 0) {
        frame.y = margin
      }
      else if ((frame.y + delta) < maxHeight) {
        frame.y += delta
      }
      else {
        frame.y = maxHeight
      }
    }
    return this;
  }

  // Resize SE-corner by factor
  resize(factor) {
    const { parent, margin, frame, window } = this;
    const screen = window.screen().frame()

    if (factor.width) {
      const maxWidth = screen.width - (margin * 2)
      const widthFactor = parent.width * factor.width

      // if we're past the left edge
      if (frame.x < parent.x + margin) {
        // if window width is greater than the screen
        if (frame.width > maxWidth) {
          frame.width = maxWidth
        }
        // move the window on to the screen
        frame.x = margin
      }

      const offscreenWidth = frame.width - (screen.width - (frame.x + margin))
      // if we're past the right edge
      if (offscreenWidth > 0) {
        // if the window is larger than the screen
        if (frame.width > maxWidth) {
          frame.width = maxWidth
        }
        // if we can move the window and keep our margin
        else if ((frame.x - offscreenWidth) > margin) {
          frame.x -= offscreenWidth
        }
        // window width would move past our margin
        else {
          frame.x = margin
        }
      }

      const difference = this.difference();
      const delta = Math.min(widthFactor, difference.x + difference.width - margin);

      // if we're at the edge of the screen
      if (delta === 0 && (frame.width + margin * 2) < parent.width) {
        this.move({width: -factor.width})
        frame.width += widthFactor
      }
      // normal case
      else {
        frame.width += delta;
      }
    }

    /*
     * increase the height of the window
     * unless the window is already at maxHeight
     * -> noop
     * unless the increase would cause the window to be greater than max height
     * -> set to maxHeight
     * unless the increase would push the window out of screen bounds
     * -> move the window up by the increase and then increase
    */
    else if (factor.height) {
      const screenHeight = screen.height
      const maxHeight = parent.height - (margin * 2)
      const maxBottomY = screenHeight - margin

      const heightFactor = parent.height * factor.height

      // if we're past the top
      if (frame.y < parent.y + margin) {
        frame.y = parent.y + margin
      }

      // if we're past the bottom
      if ((parent.y + margin + frame.y + frame.height + margin) > screenHeight) {
        const topY = parent.y + margin + frame.y
        const offscreenHeight = frame.height - (screenHeight - (topY + margin))
        // if we can move the window up and keep the height
        if (frame.height >= (screenHeight - parent.y - margin * 2)) {
          frame.y = parent.y + margin
          frame.height = maxHeight
        }
        // if the height will still be less than the screen
        else {
          frame.y -= offscreenHeight
        }
      }

      const bottomY = frame.y + frame.height

      // if growth would extend past the bottom of the screen
      if ((bottomY + heightFactor) > maxBottomY) {
        const growthDelta = maxBottomY - bottomY
        // if we're not at the bottom yet, and can grow
        if (growthDelta > 0) {
          const moveDelta = heightFactor - growthDelta
          // grow
          frame.height += growthDelta
          // move up the rest
          // frame.y -= moveDelta - parent.y
        }
        // if we're at the bottom and can grow
        else if (frame.y > margin){
          const growth = frame.y - heightFactor
          // if growing would go past the top
          if (growth < (margin + parent.y)) {
            frame.y = parent.y + margin
            frame.height = maxHeight
          }
          // normal growth & move
          else {
            frame.y -= heightFactor
            frame.height += heightFactor
          }
        }
      }
      // easy case
      else {
        frame.height += heightFactor
      }
    }
    return this
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

// Move by factor
Window.prototype.move = function (factor) {
  this.chain().move(factor).set();
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

// [> Move Bindings <]

Key.on('h', SHIFT_SUPER, () => {
  const window = Window.focused();
  if (window) {
    window.move({ width: -INCREMENT_PERCENT });
  }
});

Key.on('j', SHIFT_SUPER, () => {
  const window = Window.focused();
  if (window) {
    window.move({ height: INCREMENT_PERCENT });
  }
});

Key.on('k', SHIFT_SUPER, () => {
  const window = Window.focused();
  if (window) {
    window.move({ height: -INCREMENT_PERCENT });
  }
});

Key.on('l', SHIFT_SUPER, () => {
  const window = Window.focused();
  if (window) {
    window.move({ width: INCREMENT_PERCENT });
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

// FIXME: conflicts with clipboard
// Key.on('/', SUPER, function(){
//
//   const window =
//     Window.focused();
//
//   window.setSize({
//     height: window.size().height / 2,
//     width: window.size().width
//   })
// })


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

/**
 * Window functions
 */

function heartbeatWindow(window) {
  activeWindowsTimes[window.app().pid] = new Date().getTime() / 1000
}

function maximizeCurrentWindow() {
  var window = getCurrentWindow()
  if (!window) return

  window.maximize()
  heartbeatWindow(window)
}

function getResizeFrame(frame, ratio) {
  return {
    x: Math.round(frame.x + (frame.width / 2) * (1 - ratio)),
    y: Math.round(frame.y + (frame.height / 2) * (1 - ratio)),
    width: Math.round(frame.width * ratio),
    height: Math.round(frame.height * ratio),
  }
}

function getSmallerFrame(frame) {
  return getResizeFrame(frame, 0.9)
}

function getLargerFrame(frame) {
  return getResizeFrame(frame, 1.1)
}

function adapterScreenFrame(windowFrame, screenFrame) {
  return {
    x: Math.max(screenFrame.x, windowFrame.x),
    y: Math.max(screenFrame.y, windowFrame.y),
    width: Math.min(screenFrame.width, windowFrame.width),
    height: Math.min(screenFrame.height, windowFrame.height),
  }
}

function fitScreenHeight() {
  var window = getCurrentWindow()
  if (!window) return

  window.setFrame({
    x: window.frame().x,
    y: window.screen().flippedVisibleFrame().y,
    width: window.frame().width,
    height: window.screen().flippedVisibleFrame().height,
  })
  heartbeatWindow(window)
}

function fitScreenWidth() {
  var window = getCurrentWindow()
  if (!window) return

  window.setFrame({
    x: window.screen().flippedVisibleFrame().x,
    y: window.frame().y,
    width: window.screen().flippedVisibleFrame().width,
    height: window.frame().height,
  })
  heartbeatWindow(window)
}

function smallerCurrentWindow() {
  var window = getCurrentWindow()
  var screenFrame = window.screen().flippedVisibleFrame()
  if (!window) return

  var originFrame = window.frame()
  var frame = getSmallerFrame(originFrame)
  window.setFrame(adapterScreenFrame(frame, screenFrame))
}

function largerCurrentWindow() {
  var window = getCurrentWindow()
  var screenFrame = window.screen().flippedVisibleFrame()
  if (!window) return

  var originFrame = window.frame()
  var frame = getLargerFrame(originFrame)
  window.setFrame(adapterScreenFrame(frame, screenFrame))
}

function centerCurrentWindow() {
  var window = getCurrentWindow()
  if (!window) return

  setWindowCentral(window)
}

function setWindowCentral(window) {
  window.setTopLeft({
    x:
      (window.screen().flippedVisibleFrame().width - window.size().width) / 2 +
      window.screen().flippedVisibleFrame().x,
    y:
      (window.screen().flippedVisibleFrame().height - window.size().height) /
        2 +
      window.screen().flippedVisibleFrame().y,
  })
  heartbeatWindow(window)
}

function moveCurrentWindow(x, y) {
  var window = getCurrentWindow()
  if (!window) return

  window.setFrame({
    x: window.frame().x + x,
    y: window.frame().y + y,
    width: window.frame().width,
    height: window.frame().height,
  })
  heartbeatWindow(window)
}

function getAnotherWindowOfCurrentScreen(window, offset) {
  var windows = window.others({ visible: true, screen: window.screen() })
  windows.push(window)
  // var screen = window.screen()
  windows = _.chain(windows)
    .sortBy(function (window) {
      return window.app().pid + '-' + window.hash()
    })
    .value()

  var index =
    (_.indexOf(windows, window) + offset + windows.length) % windows.length
  return windows[index]
}

function getPreviousWindowOfCurrentScreen() {
  var window = getCurrentWindow()
  if (!window) {
    if (Window.recent().length === 0) return
    Window.recent()[0].focus()
    return
  }
  saveMousePositionForWindow(window)
  var targetWindow = getAnotherWindowOfCurrentScreen(window, -1)
  if (!targetWindow) {
    return
  }
  targetWindow.focus()
  restoreMousePositionForWindow(targetWindow)
}

function getNextWindowsOfCurrentScreen() {
  var window = getCurrentWindow()
  if (!window) {
    if (Window.recent().length === 0) return
    Window.recent()[0].focus()
    return
  }
  saveMousePositionForWindow(window)
  var targetWindow = getAnotherWindowOfCurrentScreen(window, 1)
  if (!targetWindow) {
    return
  }
  targetWindow.focus()
  restoreMousePositionForWindow(targetWindow)
}

function layoutWindow(xRatio, yRatio, widthRatio, heightRatio) {
  var window = getCurrentWindow()
  if (!window) return

  var screenFrame = window.screen().flippedVisibleFrame()
  var screenWidth = screenFrame.width
  var screenHeight = screenFrame.height

  window.setFrame({
    x: screenFrame.x + screenWidth * xRatio,
    y: screenFrame.y + screenHeight * yRatio,
    width: screenWidth * widthRatio,
    height: screenHeight * heightRatio,
  })
}


/**
 * Screen functions
 */

function moveToScreen(window, screen, vertical = false) {
  if (!window) return
  if (!screen) return

  var frame = window.frame()
  var oldScreenRect = window.screen().flippedVisibleFrame()
  var testNewScreenRect = screen.flippedVisibleFrame()

  const sizes = Screen.all().map(s => s.flippedVisibleFrame())

  const newScreenRect = screen.flippedVisibleFrame()

  var xRatio = newScreenRect.width / oldScreenRect.width
  var yRatio = newScreenRect.height / oldScreenRect.height

  var mid_pos_x = frame.x + Math.floor(0.5 * frame.width)
  var mid_pos_y = frame.y + Math.floor(0.5 * frame.height)

  var xFrame =
    (mid_pos_x - oldScreenRect.x) * xRatio + newScreenRect.x - 0.5 * frame.width
  var yFrame =
    (mid_pos_y - oldScreenRect.y) * yRatio +
    newScreenRect.y -
    0.5 * frame.height

  window.setFrame({
    x: xFrame,
    y: yFrame,
    width: frame.width,
    height: frame.height,
  })

  if (
    oldScreenRect.width === frame.width &&
    oldScreenRect.height === frame.height
  ) {
    maximizeCurrentWindow()
    return
  }

  if (
    oldScreenRect.width > newScreenRect.width &&
    oldScreenRect.width === frame.width
  ) {
    fitScreenWidth()
    return
  }
  if (
    oldScreenRect.height > newScreenRect.height &&
    oldScreenRect.height === frame.height
  ) {
    fitScreenHeight()
    return
  }

  if (
    newScreenRect.width > oldScreenRect.width &&
    oldScreenRect.width === frame.width
  ) {
    fitScreenWidth()
    return
  }
  if (
    newScreenRect.height > oldScreenRect.height &&
    oldScreenRect.height === frame.height
  ) {
    fitScreenHeight()
    return
  }
}

function getCurrentWindow() {
  var window = Window.focused()
  if (!window) {
    window = App.focused().mainWindow()
  }
  if (!window) return
  return window
}

function focusAnotherScreen(window, targetScreen) {
  if (!window) return
  if (window.screen() === targetScreen) return

  saveMousePositionForWindow(window)
  var targetScreenWindows = sortByMostRecent(targetScreen.windows())
  if (targetScreenWindows.length === 0) {
    return
  }
  var targetWindow = targetScreenWindows[0]
  targetWindow.focus() // bug, two window in two space, focus will focus in same space first
  restoreMousePositionForWindow(targetWindow)
}

function focusOnNextScreen() {
  var window = getCurrentWindow()
  if (!window) return

  var currentScreen = window.screen()
  if (!currentScreen) return
  var targetScreen = currentScreen.next()

  focusAnotherScreen(window, targetScreen)
}

function focusOnPreviousScreen() {
  var window = getCurrentWindow()
  if (!window) return

  var currentScreen = window.screen()
  if (!currentScreen) return
  var targetScreen = currentScreen.previous()

  focusAnotherScreen(window, targetScreen)
}

function moveToNextScreen() {
  var window = getCurrentWindow()
  if (!window) return

  if (window.screen() === window.screen().next()) {
    if (Space.active() !== Space.active().next()) {
      moveToSpace(window, Space.active(), Space.active().next())
    }
    return
  }

  moveToScreen(window, window.screen().next(), false)
  restoreMousePositionForWindow(window)
  window.focus()
}

function moveToPreviousScreen() {
  var window = getCurrentWindow()
  if (!window) return

  if (window.screen() === window.screen().previous()) {
    if (Space.active() !== Space.active().previous()) {
      moveToSpace(window, Space.active(), Space.active().previous())
    }
    return
  }

  moveToScreen(window, window.screen().previous(), false)
  restoreMousePositionForWindow(window)
  window.focus()
}

function moveToAllNextScreens() {
  var window = getCurrentWindow()
  if (!window) return

  if (window.screen() === window.screen().next()) return
  moveToScreen(window, window.screen().next(), true)
  restoreMousePositionForWindow(window)
  window.focus()
}

function moveToAllPreviousScreens() {
  var window = getCurrentWindow()
  if (!window) return

  if (window.screen() === window.screen().next()) return
  moveToScreen(window, window.screen().next(), true)
  restoreMousePositionForWindow(window)
  window.focus()
}

// Move current window to next screen
Key.on('[', SUPER, function () {
  moveToNextScreen()
})
// Move current window to previous screen
Key.on(']', SUPER, function () {
  moveToPreviousScreen()
})

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
