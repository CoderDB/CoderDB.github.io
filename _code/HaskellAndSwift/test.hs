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
