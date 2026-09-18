-- 1.5 Datatypes and Patterns

inductive MyBool where
  | false
  | true 

def myTrue := MyBool.true

#eval myTrue
#check myTrue

inductive Shape where
  | circle (radius : Float)
  | rectangle (width : Float) (length : Float)

def circle : Shape := .circle 10.0
def rectangle : Shape := .rectangle 10.0 20.0

def Shape.area (s : Shape) : Float :=
  match s with
  | circle r => 3.14159 * r^2.0
  | rectangle w l => w * l

#eval Shape.area circle
#eval Shape.area rectangle

structure Pair (a : Type) (b : Type) where
  mkPair ::
  first : a
  second : b

def pair1 : Pair Int String := { first := 10, second := "Hello" }

#eval pair1.first
#eval pair1.second

inductive ThisOrThat (a : Type) (b : Type) where
  | this (val : a)
  | that (val : b)

def this1 : ThisOrThat String Int := .this "this"
def that1 : ThisOrThat String Int := .that 42

#eval this1
#eval that1


-- extends example + Pattern Matching

inductive MyNat where
  | zero 
  | succ (n : MyNat)

def myNatToNat (n : MyNat) : Nat :=
  match n with 
    | MyNat.zero => 0
    | MyNat.succ m => 1 + myNatToNat m

#eval myNatToNat (MyNat.succ (MyNat.succ (MyNat.succ MyNat.zero)))

def natToMyNat (n : Nat) : MyNat :=
  match n with
    | 0  => MyNat.zero
    | m + 1 => MyNat.succ (natToMyNat m)

#eval natToMyNat 5

def isZero (n : MyNat) : Bool :=
  match n with
    | MyNat.zero => true
    | _ => false

#eval isZero MyNat.zero
#eval isZero (natToMyNat 10)

def pred (n : MyNat) : MyNat :=
  match n with
    | MyNat.zero => MyNat.zero
    | MyNat.succ m => m

#eval pred MyNat.zero
#eval pred (MyNat.succ MyNat.zero)

structure Point3D where
  mkPoint ::
  x : Float
  y : Float
  z : Float

def depth (p : Point3D) : Float :=
  match p with
    | { x := _, y := _, z := depth } => depth

#eval depth { x := 1.0, y := 2.0, z := 3.0 }

def even (n : MyNat) : Bool :=
  match n with
    | .zero => true
    | .succ m => not (even m)

#eval even (MyNat.succ MyNat.zero)
#eval even (MyNat.succ (MyNat.succ MyNat.zero))

def add (n : MyNat) (m : MyNat) : MyNat :=
  match m with
    | .zero => n
    | .succ k => MyNat.succ (add n k)

#eval myNatToNat (add (natToMyNat 10) (natToMyNat 20))

def mult (n : MyNat) (m : MyNat) : MyNat :=
  match m with
    | .zero => .zero
    | .succ k => add n (mult n k)

#eval myNatToNat (mult (natToMyNat 2) (natToMyNat 3))

def sub (n : MyNat) (m : MyNat) : MyNat :=
  match m with
    | .zero => n
    | .succ k => pred (sub n k)

#eval myNatToNat (sub (natToMyNat 1) (natToMyNat 2))
#eval myNatToNat (sub (natToMyNat 11) (natToMyNat 2))

