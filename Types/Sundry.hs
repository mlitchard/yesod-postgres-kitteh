{-# LANGUAGE OverloadedStrings #-}
module Types.Sundry
   ( Kitteh (..)
   , KittehDescription
   ) where

import           Data.Aeson
import           Data.Aeson.Types
import           Data.String
import qualified Data.Text              as T
import qualified Data.ByteString        as B
import qualified Data.ByteString.Base64 as B64
import qualified Data.Text.Encoding     as TE
import           Data.String
import           Data.Word
import           Database.Persist.TH (derivePersistField)
import           GHC.Generics
import           ClassyPrelude

import Types.ModelTypes
import Model

type KittehDescription = T.Text
 
data Kitteh = Kitteh
  { kitteh_desc :: KittehDesc
  , kitteh_pic  :: KittehPic
  } deriving (Generic,Show)

instance ToJSON Kitteh
instance FromJSON Kitteh
