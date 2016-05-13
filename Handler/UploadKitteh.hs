module Handler.UploadKitteh where

import           Types.ModelTypes
import           Types.Sundry

import           Import

postUploadKittehR :: Handler (Value)
postUploadKittehR = do
  toJSON <$> (addKitteh =<< (requireJsonBody :: Handler Kitteh))

addKitteh :: Kitteh -> Handler (Key KittehMeta)
addKitteh (Kitteh kitteh_desc photo) = runDB $ do
  data_key <- insert $ KittehData photo
  meta_key <- insert $ KittehMeta data_key ONLINE kitteh_desc
  return meta_key

