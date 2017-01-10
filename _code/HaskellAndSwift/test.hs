a = 5
-- a = 8
-- doubleMe x = x + x
-- doubleUs x y = (x + y) * 2

removeUppercase s = [x | x <- s, x `elem` ['a'..'z']]
