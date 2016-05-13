module Types.Composite
  ( Kitteh     (..)
  , KittehIndex (..)
  , KittehMeta (..)
  ) where 

import ClassyPrelude

import           Data.Aeson
import           Data.Aeson.Types
import           Database.Persist.TH (derivePersistField)
import           GHC.Generics

import Import
import Types.Atomic

data KittehMeta = KittehMeta
  { description :: KittehDescription
  , color       :: Color
  , size        :: KittehSize
  } deriving (Generic,Show)

instance ToJSON KittehMeta
instance FromJSON KittehMeta

data Kitteh = Kitteh
  { kitteh_meta :: KittehDesc
  , kitteh_pic  :: KittehPic
  } deriving (Generic,Show)

instance ToJSON Kitteh
instance FromJSON Kitteh -- for devel only

data KittehIndex = KittehIndex
  { kitteh_id     :: Key KittehData
  , kitteh_meta_i :: KittehDesc
  } deriving (Generic,Show)

instance ToJSON KittehIndex
