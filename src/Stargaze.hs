module Main where

import Prelude hiding (putStr)
import Constellation.Github(getUserRepo)
import Data.ByteString.Lazy(putStr)

main = getUserRepo "adambaker" "weekend-general" >>= putStr
