
module Model where

import Data.Aeson
import Data.Text
import GHC.Generics

data Rider = Rider
  { _name :: Text
  , _images :: [Text]
  } deriving(Generic, Show)

instance ToJSON Rider where
    toEncoding = genericToEncoding defaultOptions



