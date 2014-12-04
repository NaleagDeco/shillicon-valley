import Keyboard
import Window

-- Model
type Coords = { x:Int, y:Int }
type Dims = (Int, Int)

type Object a = { x:Float, y:Float }
type Petal = Object { radius:Float }
type Player = Object {}

data State = Running | Paused
-- Input
type Input = { space:Bool,
               playerDir:Coords,
               dimensions:Dims,
               delta:Time }

delta : Signal Time
delta = inSeconds <~ fps 35

input : Signal Input
input = sampleOn delta <| Input <~ Keyboard.space ~ Keyboard.arrows
        ~ Window.dimensions ~ delta

-- Update

-- View
