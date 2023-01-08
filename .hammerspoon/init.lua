function launch_terminal()
  if hs.appfinder.appFromName('Alacritty') then
    hs.execute('/usr/local/bin/alacritty msg create-window')
  else
    hs.application.launchOrFocus('Alacritty')
  end
end

hs.hotkey.bind({'ctrl'}, 'return', launch_terminal)

hs.loadSpoon("Emojis")
spoon.Emojis:bindHotkeys({toggle = {{'ctrl'}, 'e'}})

-- hs.window.highlight.ui.overlay = true
-- hs.window.highlight.ui.overlayColor = {0,0,0,0.0001}
-- hs.window.highlight.ui.frameWidth = 4
-- hs.window.highlight.ui.frameColor = {0.5,0,1,1}
-- hs.window.highlight.start()
-- hs.window.highlight.toggleIsolate(false)
