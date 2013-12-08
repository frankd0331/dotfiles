import XMonad
import XMonad.Actions.Volume
import Data.Map    (fromList)
import Data.Monoid (mappend)
import XMonad.Layout.ThreeColumns

--this creates a three column tile
myLayout = ThreeColMid 1 (1/100) (2/5) ||| ThreeCol 1 (3/100) (1/2) 

main = do
--  layoutHook = myLayout
  xmonad defaultConfig { keys =
       keys defaultConfig `mappend`
       \c -> fromList [
       ((0, xK_F6), lowerVolume 4 >> return ()),
       ((0, xK_F7), raiseVolume 4 >> return ())
       ],
                         layoutHook = myLayout
  }

-- guess I need to learn more about using main before trying this             
--       layoutHook = myLayout
