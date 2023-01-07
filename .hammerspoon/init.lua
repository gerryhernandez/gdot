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

