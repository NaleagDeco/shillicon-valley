module PetalBoard where

marginPercentage : Int
marginPercentage = 10

boardMargin : (Int, Int) -> (Int, Int)
boardMargin (w,h) = (w `div` marginPercentage, h `div` marginPercentage)

boardBottomLeft : (Int, Int) -> (Float, Float)
boardBottomLeft d = let margin = boardMargin d
                        left = fst(margin) + (fst d) `div` -2
                        bottom = snd(margin) + (snd d) `div` -2
                    in (toFloat left, toFloat bottom)
