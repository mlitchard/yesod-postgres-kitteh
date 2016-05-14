module Types.ModelTypes
  ( KittehStatus (..)
  , Color        (..)
  , KittehSize   (..)
  , KittehDesc   (..)
  , KittehPic    (..)
  ) where


import ClassyPrelude

import           Data.Aeson
import           Data.Aeson.Types
import qualified Data.ByteString        as B
import qualified Data.ByteString.Base64 as B64
import           Database.Persist.TH (derivePersistField)
import           GHC.Generics

data KittehStatus = ONLINE | OFFLINE deriving (Read, Show,Generic)

derivePersistField "KittehStatus"
instance ToJSON KittehStatus
instance FromJSON KittehStatus

data Color = Black
           | Orange
           | Grey
           | Pink
           | White
           | Brown
              deriving (Read,Show,Generic)

derivePersistField "Color"
instance FromJSON Color
instance ToJSON Color

data KittehSize =
    FluffBall
  | LapKitteh
  | BigAssCat
  | AnywhereTheyWant
      deriving (Read,Show,Generic)

derivePersistField "KittehSize"

instance ToJSON KittehSize
instance FromJSON KittehSize

data KittehDesc = KittehDesc
  { description :: Text
  , color       :: Color
  , size        :: KittehSize
  } deriving (Generic,Read,Show)

derivePersistField "KittehDesc"

instance ToJSON KittehDesc
instance FromJSON KittehDesc

newtype Base64 = Base64 { toByteString :: B.ByteString }
                   deriving ( Eq, Ord, Show,Read)

instance ToJSON Base64 where
    toJSON = toJSON . B.unpack . B64.decodeLenient . toByteString
instance FromJSON Base64 where
    parseJSON = fmap (Base64 . B64.encode . B.pack) . parseJSON

type KittehPic = Base64
derivePersistField "Base64"

