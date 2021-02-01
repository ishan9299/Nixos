import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Layout.BinarySpacePartition
import XMonad.Layout.Spacing
import System.IO
import System.Exit

-- Some defaults

myTerminal = "alacritty"

myLauncher   = "dmenu_run -m 1"

myWorkspaces = map show [1..6]

myLayout = avoidStruts (smartSpacingWithEdge 3 emptyBSP)

myManageHook = composeAll
  [ className =? "MPlayer" --> doFloat
  ]

myAdditionalKeys = 
  [ ((mod4Mask, xK_s), spawn "blurlock")
  , ((mod4Mask, xK_p), spawn myLauncher)
  , ((mod4Mask, xK_n), spawn "networkmanager_dmenu")
  , ((mod4Mask, xK_Return), spawn myTerminal)
  , ((mod4Mask .|. shiftMask , xK_q), kill)
  , ((mod4Mask .|. shiftMask , xK_Escape), io (exitWith ExitSuccess))

  , ((mod4Mask .|. mod1Mask,               xK_l     ), sendMessage $ ExpandTowards R)
  , ((mod4Mask .|. mod1Mask,               xK_h     ), sendMessage $ ExpandTowards L)
  , ((mod4Mask .|. mod1Mask,               xK_j     ), sendMessage $ ExpandTowards D)
  , ((mod4Mask .|. mod1Mask,               xK_k     ), sendMessage $ ExpandTowards U)
  , ((mod4Mask .|. mod1Mask .|. controlMask , xK_l     ), sendMessage $ ShrinkFrom R)
  , ((mod4Mask .|. mod1Mask .|. controlMask , xK_h     ), sendMessage $ ShrinkFrom L)
  , ((mod4Mask .|. mod1Mask .|. controlMask , xK_j     ), sendMessage $ ShrinkFrom D)
  , ((mod4Mask .|. mod1Mask .|. controlMask , xK_k     ), sendMessage $ ShrinkFrom U)
  , ((mod4Mask,                           xK_r     ), sendMessage Rotate)
  , ((mod4Mask,                           xK_s     ), sendMessage Swap)
  ]

defaults = defaultConfig
  { terminal        = myTerminal
  , modMask         = mod4Mask
  , borderWidth     = 1
  , workspaces = myWorkspaces

  -- Hooks
  , manageHook      = manageDocks <+> manageHook defaultConfig
  , layoutHook      = myLayout
  , handleEventHook = handleEventHook defaultConfig <+> docksEventHook
  , logHook         = dynamicLogWithPP xmobarPP
      {  ppTitle = xmobarColor "green" "" . shorten 50
      , ppHiddenNoWindows = xmobarColor "grey" ""
      }
  , startupHook = spawn "bash ~/.xmonad/autostart"
  } `additionalKeys` myAdditionalKeys

main = do
  xmonad defaults
