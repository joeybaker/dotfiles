-- hattip https://github.com/lodestone/hyper-hacks
-- hattip https://gist.github.com/ttscoff/cce98a711b5476166792d5e6f1ac5907

-- A global variable for the sub-key Hyper Mode
k = hs.hotkey.modal.new({}, 'F18')

-- Hyper+key for all the below are setup somewhere
-- The handler already exists, usually in Keyboard Maestro
-- we just have to get the right keystroke sent
hyperBindings = {'a', 's', 'd', 'f', 'g', 'h', 'j', 'p', 'e', 'r', 't', 'y', '/', '\\', 'UP', 'DOWN', 'LEFT', 'RIGHT', 'm', ';', '\''}

for i,key in ipairs(hyperBindings) do
  k:bind({}, key, nil, function() hs.eventtap.keyStroke({'cmd','alt','ctrl'}, key)
    k.triggered = true
  end)
end

-- Enter Hyper Mode when F19 (left control) is pressed
pressedF19 = function()
  k.triggered = false
  k:enter()
end

-- Leave Hyper Mode when F19 (left control) is pressed,
--   send ESCAPE if no other keys are pressed.
releasedF19 = function()
  k:exit()
  if not k.triggered then
    hs.eventtap.keyStroke({}, 'ESCAPE')
  end
end

-- Bind the Hyper key
f19 = hs.hotkey.bind({}, 'F19', pressedF19, releasedF19)

-- vi cursor movement commands
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
--   hs.hotkey.bind({'ctrl'}, bnd[1], function()
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
