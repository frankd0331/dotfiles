import XMonad
import XMonad.Actions.Volume
import Data.Map.Lazy (fromList)
import Data.Monoid (mappend)
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Spacing
import XMonad.Layout.Gaps
import XMonad.Layout.Fullscreen
--import XMonad.Layout.NoBorders

--this creates a three column tile
myLayout = gaps [(U,18)] $ spacing 5 $ ThreeColMid 1 (3/100) (2/5) ||| ThreeCol 1 (3/100) (-7/24) ||| tiled ||| Mirror tiled
  where tiled = Tall 1 (3/100) (1/2)

main = do
  xmonad defaultConfig { keys =
       keys defaultConfig `mappend`
       \c -> fromList [
       ((0, xK_F6), lowerVolume 4 >> return ()),
       ((0, xK_F7), raiseVolume 4 >> return ())
       ],
                         layoutHook = myLayout
  }
