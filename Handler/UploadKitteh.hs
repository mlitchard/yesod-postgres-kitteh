module Handler.UploadKitteh where

import           Types.Composite

import           Import
import           Data.Aeson
import qualified Data.ByteString        as B
import qualified Data.ByteString.Base64 as B64
import qualified Data.Text              as T


postUploadKittehR :: Handler (Value)
postUploadKittehR = do
    toJSON <$> (addKitteh =<< (requireJsonBody :: Handler Kitteh))

addKitteh :: Kitteh -> Handler (Key KittehDesc)
addKitteh (Kitteh (KittehDesc desc color size) photo) = runDB $ do
    desc_key <- insert (KittehDesc desc color size)
    _ <- insert $ KittehData desc_key photo
    return desc_key

