import XMonad
import XMonad.Config.Desktop

import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog

import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing

import XMonad.Util.EZConfig
import XMonad.Util.Run
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.SpawnOnce

colorNormalbg = "#1c1c1c"
colorfg       = "#9fa8b1"

main = do
  wsbar <- spawnPipe myWsBar
  xmonad $ ewmh desktopConfig
    { borderWidth        = 0
    , normalBorderColor  = colorNormalbg
    , focusedBorderColor = colorfg
    , terminal           = "sakura"
    , startupHook        = myStartupHook
    , handleEventHook    = fullscreenEventHook
    , layoutHook         = spacing 2 $ avoidStruts $ layoutHook desktopConfig
    , logHook            = myLogHook wsbar
    }

    `removeKeysP`
    [ "M-p" ]

    `additionalKeysP`
    [ ("M-d", spawn "dmenu_run -fn 'Source Han Sans JP Normal:size=11'")
    , ("M-p", spawn "systemctl poweroff")
    ]

myStartupHook = do
  spawnOnce "fcitx"
  spawnOnce "xcompmgr"
  spawnOnce "feh --bg-scale /usr/share/archlinux/wallpaper/archlinux-poolclouds.jpg"
  spawnOnce "numlockx on"

myLogHook h = dynamicLogWithPP $ wsPP { ppOutput = hPutStrLn h }

myWsBar = "xmobar $HOME/.xmonad/xmobarrc"

wsPP = xmobarPP
  { ppCurrent         = xmobarColor "#3399ff" "" . wrap " " " "
  , ppHidden          = xmobarColor "#dddddd" "" . wrap " " " " 
  , ppHiddenNoWindows = xmobarColor "#777777" "" . wrap " " " " 
  , ppUrgent          = xmobarColor "#ff0000" "" . wrap " " " " 
  , ppSep             = "     "
  --, ppLayout          = xmobarColor "#aaaaaa" "" . wrap " " " " 
  , ppTitle           = xmobarColor "#ffffff" "" . wrap " " " " 
  }
