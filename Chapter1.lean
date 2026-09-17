-- 1.1 Getting to know Lean

#eval 1 + 2

#eval 1 + 2 * 5

#eval String.append "Hello, " "Lean4!"

#eval String.append "Hello, " (String.append "world " "again")

#eval String.append "It is " (if 1 > 2 then "good" else "bad")

#eval String.append "It is " (if false then "yes" else "no")

-- exercises

-- 42 + 19 -> 61
#eval 42 + 19

-- String.append "A" (String.append "B" "C") -> "ABC"
#eval String.append "A" (String.append "B" "C")

-- String.append (String.append "A" "B") "C" -> "ABC"
#eval String.append (String.append "A" "B") "C"

-- if 3 == 3 then 5 else 7 -> 5
#eval if 3 == 3 then 5 else 7

-- if 3 == 4 then "equal" else "not equal" -> "not equal"
#eval if 3 == 4 then "equal" else "not equal"


-- 1.2 Types

#eval (1 + 2 : Nat)

-- 0 since the default type for unsigned numbers in Nat (natural numbers)
#eval (1 - 2)

-- same as above
#eval (1 - 2 : Nat)

-- proven by
-- shows `Nat`
#check (1 - 2)

-- -1, as expected
#eval (1 - 2 : Int)

-- shows `Int`
#check (1 - 2 : Int)

-- error (make sure to hover over the underlined part of the code for the actual error message)
-- #check String.append ["Hello,", " "] "world"

-- 1.3 Functions and Definitions

def hello := "Hello, "
def world: String := "World!"

#eval String.append hello world

def add1 (n : Nat) : Nat := n + 1

#eval add1 99

def maximum (n : Nat) (m : Nat) : Nat :=
  if n >= m then n else m

#eval maximum 11 7
#eval maximum 7 11

def spaceBetween (s1 : String) (s2 : String) : String :=
  String.append s1 (String.append " " s2)

#eval spaceBetween hello world

#check add1

#check (add1)

#check (maximum)

-- functions are curried
#check (maximum 3)

#check (spaceBetween "foo")

-- exercises

def joinStringsWith (joiner : String) (before: String) (after : String) : String :=
  String.append (String.append before joiner) after

#eval joinStringsWith ", " "one" "and another"

-- What is the type of `joinStringsWith ": "? It is String -> String -> String
#check joinStringsWith ": "

def volume (length : Nat) (breadth : Nat) (height : Nat) : Nat :=
  length * breadth * height


#eval volume 10 20 30


-- 1.3.2 Defining Types

def Str : Type := String

def bob : Str := "Bob"
def dave : Str := "Dave"

#eval joinStringsWith " and " bob dave

-- this does not work since numbers in Lean are polymorphic,
-- and it needs an instance implementation of `OfNat`
def NaturalNumber : Type := Nat

-- def myNat : NaturalNumber := 42

-- this works though
def myNat : NaturalNumber := (42 : Nat)

-- this also works
abbrev N : Type := Nat

def yourNat : N := 42

#eval yourNat


-- 1.4 Structures

#eval 1.2

#check -2.78128

#check 0 -- Nat

#check (0 : Float) -- Float

structure Point where
  x : Float
  y : Float

def origin : Point := { x :=  0.0, y := 0.0 }

#eval origin
#eval origin.x
#eval origin.y
#check origin

def addPoints (p1 : Point) (p2 : Point) : Point :=
  { x := p1.x + p2.x, y := p1.y + p2.y }

#eval addPoints { x := 1.0, y := 2.0 } { x := -1.0, y := -2.0 }

def distance (p1 : Point) (p2 : Point) : Float :=
  Float.sqrt ((p1.x - p2.x) ^ 2.0 + (p1.y - p2.y) ^ 2.0)

#eval distance { x := 3.0, y := 4.0 } origin

def point1 : Point := { x := 1.0, y := 2.0 }
def point2 : Point := { x := 5.0, y := -1.0 }
#eval distance point1 point2

structure Point3D where
  x : Float
  y : Float
  z : Float

def point3d : Point3D := { x := 0.0, y := 1.0 , z := 2.0 }

#check point3d

def zeroX (p : Point) : Point :=
  { p with x := 0.0 }

#eval zeroX point1
#eval zeroX point2

-- constructors
def point3 := Point.mk 1.0 2.0
#eval point3

def point4 := Point3D.mk 1.0 2.0 3.0
#eval point4

-- custom constructor name
structure Pair where
  -- this is the constructor name
  mkPair ::
  first : Float
  second : Float

def pair1 := Pair.mkPair 1.0 2.0
#eval pair1

#check Pair.first
#check Pair.second

def Point.modifyBoth (f : Float -> Float) (p : Point) : Point :=
  Point.mk (f p.x) (f p.y)

def add1Float (f : Float) : Float :=
  f + 1.0

#eval Point.modifyBoth add1Float origin

-- same as previous
#eval origin.modifyBoth add1Float


-- exercises

structure RectangularPrism where
  height : Float
  breadth : Float
  length : Float

def RectangularPrism.volume (p : RectangularPrism) : Float :=
  p.height * p.breadth * p.length

#eval RectangularPrism.volume (RectangularPrism.mk 10.0 20.0 30.0)

structure Segment where
  startPt : Point
  endPt  : Point

def length (seg : Segment) : Float := 
  distance seg.startPt seg.endPt

#eval length (Segment.mk (Point.mk 1 2) (Point.mk 5 (-1)))


