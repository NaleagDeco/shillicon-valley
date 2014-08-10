module Main where

import Color
import Graphics.Collage as GC
import Window
import List

import PetalBoard as PB
{-- Part 1: Model the user input

What information do you need to represent all relevant user input?

Task: Redefine `UserInput` to include all of the information you need.
Redefine `userInput` to be a signal that correctly models the user
input as described by `UserInput`.

-}

type UserInput = {}

userInput : Signal UserInput
userInput = constant {}

type Input = { timeDelta:Float, userInput:UserInput }



{-- Part 2: Model the game

What information do you need to represent the entire game?

Tasks: Redefine `GameState` to represent your particular game.
Redefine `defaultGame` to represent your initial game state.

For example, if you want to represent many objects that just have a position,
your GameState might just be a list of coordinates and your default game might
be an empty list (no objects at the start):

type GameState = { objects : [(Float,Float)] }
defaultGame = { objects = [] }

-}

type Dimension = Int
dimensions: (Dimension, Dimension)
dimensions = (,) 8 5

type Radius = Float

petalStart: Radius
petalStart = 10.0

type GameState = { petals: [Radius] }

defaultGame : GameState
defaultGame = { petals = List.repeat
                         (fst(dimensions) * snd(dimensions))
                         petalStart
              }

{-- Part 3: Update the game

How does the game step from one state to another based on user input?

Task: redefine `stepGame` to use the UserInput and GameState
you defined in parts 1 and 2. Maybe use some helper functions
to break up the work, stepping smaller parts of the game.

-}

stepGame : Input -> GameState -> GameState
stepGame {timeDelta,userInput} gameState = gameState



{-- Part 4: Display the game

How should the GameState be displayed to the user?

Task: redefine `display` to use the GameState you defined in part 2.

-}

display : (number, number) -> GameState -> Element
display (w, h) state = let numPetals = List.length state.petals
                        in GC.collage w h
                               <| List.map
                                      (\(n,r) -> GC.move (petalNumToXY (w,h) n) <| petal r)
                                      <| List.zip [0..numPetals-1] state.petals

petal : Float -> GC.Form
petal r = GC.filled Color.green <| GC.circle r

petalNumToXY : (Int, Int) -> Int -> (Float, Float)
petalNumToXY d n = let row = n `div` 8
                       col = n `mod` 8
                       boardOrigin = PB.boardBottomLeft d
                       left = (fst boardOrigin) + (toFloat col) * 25.0
                       bottom = (snd boardOrigin) + (toFloat row) * 25.0
                   in (left, bottom)



{-- That's all folks!

The following code puts it all together and shows it on screen.

-}

delta = fps 30
input = sampleOn delta (lift2 Input delta userInput)

gameState = foldp stepGame defaultGame input

main = lift2 display Window.dimensions gameState
