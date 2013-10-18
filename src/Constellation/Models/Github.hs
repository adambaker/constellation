module Constellation.Models.Github (
  Repository(Repository),
  RepoOwner,
  User(User),
  Organization(Organization),
  name,
  repos,
  stars,
  repoName,
  users,
) where

import Prelude

data Repository = Repository
  { repoName  :: String
  , stars     :: Int
  } deriving(Eq, Show)

class RepoOwner a where
  repos :: a -> [Repository]
  name  :: a -> String

data User = User
  { userName  :: String
  , userRepos :: [Repository]
  }
instance Eq User where
  a == b = (userName a) == (userName b)
instance Show User where
  show = ("User: " ++) . userName
instance RepoOwner User where
  repos = userRepos
  name  = userName

data Organization = Organization
  { orgName  :: String
  , users    :: [User]
  , orgRepos :: [Repository]
  }
instance RepoOwner Organization where
  repos = orgRepos
  name  = orgName
