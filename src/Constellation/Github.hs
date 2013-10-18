module Constellation.Github(
  getUserRepo,
  starsFrom,
) where

import Prelude
import Control.Monad.IO.Class (MonadIO)
import qualified Data.ByteString.Lazy as BSL
import Network.HTTP.Conduit
{-import Constellation.Models.Github-}
import Data.Aeson(decode, (.:))
import Data.Aeson.Types (parseMaybe)

type UserName = String
type RepoName = String
type JSON = BSL.ByteString

getUserRepo :: MonadIO m => UserName -> RepoName -> m JSON
getUserRepo uname rname = simpleHttp url
  where url = "https://api.github.com/repos/"++uname++"/"++rname

starsFrom :: JSON -> Maybe Int
starsFrom repo = flip parseMaybe obj $ (.: "watchers")
  where Just obj = decode repo
