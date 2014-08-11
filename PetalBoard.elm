module PetalBoard where

import List

type Dimension = Int
dimensions: (Dimension, Dimension)
dimensions = (,) 5 8

marginPercentage : Int
marginPercentage = 10

boardMargin : (Int, Int) -> (Int, Int)
boardMargin (w,h) = (w `div` marginPercentage, h `div` marginPercentage)

boardSize : (Int, Int) -> (Int, Int)
boardSize (w, h) = let (w', h') = boardMargin (w, h)
                   in (w - 2 * w', h - h' * 2)

boardBottomLeft : (Int, Int) -> (Int, Int)
boardBottomLeft (w, h) = let (mx, my) = boardMargin (w, h)
                             left = mx + w `div` -2
                             bottom = my + h `div` -2
                         in (left, bottom)

cellSize : (Int, Int) -> (Dimension, Dimension) -> (Int, Int)
cellSize (w', h') (r, c) = (w' `div` c, h' `div` r)

petalSize : (Int, Int) -> Int -> Float
petalSize (cx, cy) _ = List.minimum [cx, cy] |> toFloat

petalNumToXY : (Int, Int) -> Int -> (Float, Float)
petalNumToXY d n = let row = n `div` (snd dimensions)
                       col = n `mod` (snd dimensions)
                       boardOrigin = boardBottomLeft d
                       brdSize = boardSize d
                       x = (fst boardOrigin) +
                           col * ((fst brdSize) `div` (snd dimensions))
                       y = (snd boardOrigin) +
                           row * ((snd brdSize) `div` (fst dimensions))
                   in (toFloat x, toFloat y)
