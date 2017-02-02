-- import Data.List

-- import qualified Data.Map as M

-- Data.Char

import Data.Char

-- encode

encode :: Int -> String -> String
encode shift msg =
    let ords = map ord msg
        shifted = map (+shift) ords
    in map chr shifted

-- encode shift msg = map (chr . (+shift) . ord) msg


-- decode

decode :: Int -> String -> String
decode shift msg = encode (negate shift) msg
