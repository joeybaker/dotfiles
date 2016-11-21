-- hattip https://github.com/lodestone/hyper-hacks
-- hattip https://gist.github.com/ttscoff/cce98a711b5476166792d5e6f1ac5907

-- A global variable for the sub-key Hyper Mode
hyper = hs.hotkey.modal.new({}, 'F20')

-- Hyper+key for all the below are setup somewhere
-- The handler already exists, usually in Keyboard Maestro
-- we just have to get the right keystroke sent
hyperBindings = {'a', 's', 'd', 'f', 'g', 'h', 'j', 'o', 'p', 'e', 'r', 't', 'y', '/', '\\', 'UP', 'DOWN', 'LEFT', 'RIGHT', 'm', ';', '\'', 'c', 'v'}

for i,key in ipairs(hyperBindings) do
  hyper:bind({}, key, nil, function()
    hs.eventtap.keyStroke({'cmd','alt','ctrl'}, key)
    hyper.triggered = true
  end)
end

-- Enter Hyper Mode when F19 (left control) is pressed
pressedF19 = function()
  hyper.triggered = false
  hyper:enter()
end

-- Leave Hyper Mode when F19 (left control) is pressed,
--   send ESCAPE if no other keys are pressed.
releasedF19 = function()
  hyper:exit()
  if not hyper.triggered then
    hs.eventtap.keyStroke({}, 'ESCAPE')
  end
  hyper.triggered = false
end

-- Bind the Hyper key
f19 = hs.hotkey.bind({}, 'F19', pressedF19, releasedF19)


--
-- A global variable for the sub-key left shift
-- leftShift = hs.hotkey.modal.new({}, 'F13')
-- rightShift = hs.hotkey.modal.new({}, 'F15')
--
-- -- all keys that shift matters for
-- allKeys = {'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', '[', ']', '\\', 'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', ';', '\'', 'z', 'x', 'c', 'v', 'b', 'n', 'm', ',', '.', '/', '`', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '-', '='}
-- leftShiftKeys = {'y', 'u', 'i', 'o', 'p', '[', ']', '\\', 'h', 'j', 'k', 'l', ';', '\'', 'b', 'n', 'm', ',', '.', '/', '6', '7', '8', '9', '0', '-', '='}
-- rightShiftKeys = {'q', 'w', 'e', 'r', 't', 'a', 's', 'd', 'f', 'g', 'z', 'x', 'c', 'v', '`', '1', '2', '3', '4', '5'}
--
-- for i,key in ipairs(leftShiftKeys) do
--   leftShift:bind({}, key, nil, function() hs.eventtap.keyStroke({'shift'}, key)
--     leftShift.triggered = true
--   end)
-- end
--
-- for i,key in ipairs(rightShiftKeys) do
--   rightShift:bind({}, key, nil, function() hs.eventtap.keyStroke({'shift'}, key)
--     rightShift.triggered = true
--   end)
-- end
--
-- -- Enter shift modifier when F14 (left shift) is pressed
-- pressedF14 = function()
--   leftShift.triggered = false
--   leftShift:enter()
-- end
-- -- Enter shift modifier when F16 (right shift) is pressed
-- pressedF16 = function()
--   rightShift.triggered = false
--   rightShift:enter()
-- end
--
-- -- Leave Shift modifier when F14 (left shift) is pressed,
-- -- send ( if no other keys are pressed.
-- releasedF14 = function()
--   leftShift:exit()
--   if not leftShift.triggered then
--     hs.eventtap.keyStroke({'shift'}, '9')
--   end
--   leftShift.triggered = false
-- end
-- -- Leave Shift modifier when F16 (right shift) is pressed,
-- -- send ) if no other keys are pressed.
-- releasedF16 = function()
--   rigthShift:exit()
--   if not rightShift.triggered then
--     hs.eventtap.keyStroke({'shift'}, '0')
--   end
--   rightShift.triggered = false
-- end
--
-- -- Bind the Left Shift key
-- f14 = hs.hotkey.bind({}, 'F14', 'f14', pressedF14, releasedF14)
-- f16 = hs.hotkey.bind({}, 'F16', 'f16', pressedF16, releasedF16)
--
--
-- -- vi cursor movement commands, hold `option` to activate
-- -- TODO: get back the old `f`, `d` functionality
-- movements = {
--  { 'h', {}, 'LEFT'},
--  { 'j', {}, 'DOWN'},
--  { 'k', {}, 'UP'},
--  { 'l', {}, 'RIGHT'},
--  { '0', {'cmd'}, 'LEFT'},  -- beginning of line
--  { '4', {'cmd'}, 'RIGHT'}, -- end of line
--  { 'b', {'alt'}, 'LEFT'},  -- back word
--  { 'w', {'alt'}, 'RIGHT'}, -- forward word
-- }
-- for i,bnd in ipairs(movements) do
--   hs.hotkey.bind({'alt'}, bnd[1], function()
--     hs.eventtap.keyStroke(bnd[2],bnd[3])
--   end)
-- end

-- Reload config when any lua file in config directory changes
function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == '.lua' then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
local myWatcher = hs.pathwatcher.new(os.getenv('HOME') .. '/.hammerspoon/', reloadConfig):start()
hs.alert.show('Config loaded')
