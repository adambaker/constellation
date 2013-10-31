{-# LANGUAGE OverloadedStrings #-}
module Constellation.Github(
  getUserRepo,
  starsFrom,
  getToday,
) where

import Control.Monad.IO.Class (MonadIO)
import qualified Data.ByteString.Lazy as BSL
import Network.HTTP.Conduit
{-import Constellation.Models.Github-}
import Data.Aeson(decode, (.:))
import Data.Aeson.Types (parseMaybe)
import Data.Time.Clock(getCurrentTime, utctDay)
import Data.Time.Calendar(Day)

type UserName = String
type RepoName = String
type JSON = BSL.ByteString

getUserRepo :: MonadIO m => UserName -> RepoName -> m JSON
getUserRepo uname rname = simpleHttp url
  where url = "https://api.github.com/repos/"++uname++"/"++rname

getToday :: IO Day
getToday = return . utctDay =<< getCurrentTime

starsFrom :: JSON -> Maybe Int
starsFrom repo = flip parseMaybe obj $ (.: "watchers")
  where Just obj = decode repo
