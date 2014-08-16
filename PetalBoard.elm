module PetalBoard where

import List

type Dimension = Int
dimensions: (Dimension, Dimension)
dimensions = (,) 5 8

marginPercentage : Float
marginPercentage = 10.0

boardMargin : (Int, Int) -> (Float, Float)
boardMargin (w,h) = (toFloat w / marginPercentage, toFloat h / marginPercentage)

boardSize : (Int, Int) -> (Float, Float)
boardSize (w, h) = let (w', h') = boardMargin (w, h)
                   in (toFloat w - 2 * w', toFloat h - h' * 2)

boardBottomLeft : (Int, Int) -> (Float, Float)
boardBottomLeft (w, h) = let (mx, my) = boardMargin (w, h)
                             left = mx + (toFloat w) / -2
                             bottom = my + (toFloat h) / -2
                         in (left, bottom)

cellSize : (number, number) -> (Dimension, Dimension) -> (number, number)
cellSize (w', h') (r, c) = (w' /  toFloat c, h' / toFloat r)

petalSize : (number, number) -> Int -> number
petalSize (cx, cy) p = List.minimum [cx, cy] * ((toFloat p) / 200.0)

petalNumToXY : (Float, Float) -> (Float, Float) -> Int -> (Float, Float)
petalNumToXY c bo n = let row = n `div` (snd dimensions)
                          col = n `mod` (snd dimensions)
                          x = (fst bo) + (toFloat col) * (fst c)
                          y = (snd bo) + (toFloat row) * (snd c)
                      in (x, y)
