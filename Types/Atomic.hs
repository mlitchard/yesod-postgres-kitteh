{-# LANGUAGE OverloadedStrings #-}
module Types.Atomic
   (Color (..)
   ,KittehPic 
   ,KittehDescription
   ,KittehSize (..)
   ,Base64 (..)
   ,DBResult (..)) where

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

data Color = Black
           | Orange
           | Grey
           | Pink
           | White
           | Brown
              deriving (Read,Show,Generic)

derivePersistField "Color"

data PostError = PostFailed String deriving (Show,Generic)
-- https://github.com/parsonsmatt/scotty-persistent-example/blob/finished/Main.hs
type KittehDescription = T.Text
data KittehSize = 
    FluffBall
  | LapKitteh
  | BigAssCat
  | AnywhereTheyWant
      deriving (Read,Show,Generic)
derivePersistField "KittehSize"
 
newtype Base64 = Base64 { toByteString :: B.ByteString }
                   deriving ( Eq, Ord, Show,Read)  

instance ToJSON Base64 where
    toJSON = toJSON . B.unpack . B64.decodeLenient . toByteString

instance FromJSON Base64 where
    parseJSON = fmap (Base64 . B64.encode . B.pack) . parseJSON

type KittehPic = Base64
derivePersistField "Base64"
-- data StoreError = CouldNotWriteToDB T.Text
--                | CouldNotDecodeJPG
--                   deriving (Show,Generic)
-- data StoreSuccess = StoreSuccess Integer deriving (Show,Generic)

data DBResult = 
    StoreSuccess Int
  | CouldNotWriteToDB T.Text    
  | CouldNotDecodeJPG
      deriving (Show,Generic)    
       
instance ToJSON KittehSize
instance FromJSON KittehSize

instance FromJSON Color
instance ToJSON Color

instance FromJSON PostError
instance ToJSON PostError

instance FromJSON DBResult
instance ToJSON DBResult

