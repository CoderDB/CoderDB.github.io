a = 5
-- a = 8
-- doubleMe x = x + x
-- doubleUs x y = (x + y) * 2

removeUppercase s = [x | x <- s, x `elem` ['a'..'z']]

-- Type
circumference :: Float -> Float
circumference r = 2 * pi * r

circumference' :: Double -> Double
circumference' r = 2 * pi * r

circleArea :: Double -> Double
circleArea r = pi * r * r
-- circumference' r ^ 2 / (4 * pi)

-- Pattern matching
notAtWork :: String -> String
notAtWork "Monday" = "Today is Monday, you ji ge mao a."
notAtWork "Wednesday" = "You don't have to go to work after three days."
notAtWork "Friday" = "You don't need to work tomorrow."
notAtWork x = "You do have to work everyday, you konw, shabi!"

--
first :: (a, b, c) -> a
first (x, _, _) = x

second :: (a, b, c) -> b
second (_, y, _) = y

third :: (a, b, c) -> c
third (_, _, z) = z

-- head'
head' :: [a] -> a
head' [] = error "Can't call head' on empty list."
head' (x:_) = x

-- length'
length' :: (Integral b) => [a] -> b
length' [] = 0
length' (_:t) = 1 + length' t

-- sum'
sum' :: (Num a) => [a] -> a
sum' [] = 0
sum' (h:t) = h + sum' t

-- product'
product' :: (Num a) => [a] -> a
product' [] = error "Can't call product' on empty list."
product' (h:t) = h * product' t

-- guard
watchMovie :: (Integral a) => a -> String
watchMovie age
    | age <= 10 = "You should play niba with your friends."
    | age <= 18 = "You should try to date girls."
    | age <= 22 = "Watch Movie! Watch Movie! Watch Movie!"
    | age <= 25 = "See Feng Insert Zhen."
    | age <= 30 = "You should try to be a gay."
    | otherwise = "You should try to be gandie."


-- max'
max' :: (Ord a) => a -> a -> a
max' x y
    | x > y = x
    | otherwise = y


-- compare'
compare' :: (Ord a) => a -> a -> Ordering
compare' x y
    | x > y     = GT
    | x == y    = EQ
    | otherwise = LT

-- where

--bmi
bmi :: (RealFloat a) => a -> a -> String
bmi weight height
    | weight / height ^ 2 <= 18.4 = "偏瘦"
    | weight / height ^ 2 <= 23.9 = "正常"
    | weight / height ^ 2 <= 27.9 = "过重"
    | otherwise = "肥胖"

-- bmi'
bmi' :: (RealFloat a) => a -> a -> String
bmi' weight height
    | bmi <= 18.4 = "偏瘦"
    | bmi <= 23.9 = "正常"
    | bmi <= 27.9 = "过重"
    | otherwise = "肥胖"
    where bmi = weight / height ^ 2

-- bmis
bmis :: (RealFloat a) => [(a, a)] -> [a]
bmis s = [bmi | (w, h) <- s, let bmi = w / h ^ 2]

-- case

-- head''
head'' :: [a] -> a
head'' xs = case xs of
                [] -> error "Can't call head' on empty list."
                (x:_) -> x

-- listDescription
listDescription :: [a] -> String
listDescription xs = case xs of
                        [] -> "empty list"
                        [x] -> "singleton list"
                        xs -> "longer list"
