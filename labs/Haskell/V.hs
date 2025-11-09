import Language.Haskell.TH (Dec(NewtypeD), bang)
data Expr = Val Int | Add Expr Expr | Sub Expr Expr deriving (Eq,Show)

type Exprzipp = (Expr,[ExprCtx])
data ExprCtx = AddLC Expr | AddRC Expr | SubLC Expr | SubRC Expr

fold' :: (Int -> b) -> (b -> b -> b) -> (b -> b -> b) -> Expr -> b
fold' fVal _ _ (Val n)     = fVal n
fold' fval fadd fsub (Add a b) = fadd (fold' fval fadd fsub a) (fold' fval fadd fsub b)
fold' fval fadd fsub (Sub a b) = fsub (fold' fval fadd fsub a) (fold' fval fadd fsub b) 

eval :: Expr -> Int
eval = fold' id (+) (-)

size :: Expr -> Int
size = fold' (const 1) (\x y -> x+ y + 1) (\x y -> x+ y + 1)

data Prop = Const Bool | Var Char | Not Prop  | And Prop Prop | Imply Prop Prop deriving (Eq,Show, Read)
data Form = Neg | Pos | Mix | No deriving (Eq,Show)

getForm :: Prop -> Form
getForm (Not a) = reverse' (getForm a)
getForm (And a b) = comp (getForm a) (getForm b)
getForm (Imply a b) = comp (getForm (Not a)) (getForm b)
getForm (Var a) = Pos
getForm (Const a) = No


reverse' :: Form -> Form
reverse' Neg = Pos
reverse' Pos = Neg
reverse' Mix = Mix

comp :: Form -> Form -> Form
comp a b
    | a == No = b
    | b == No = a
    | a == b = a
    | otherwise = Mix

main :: IO ()
main = do
    print (getForm (And (Const False) (Not (Var 'x'))))