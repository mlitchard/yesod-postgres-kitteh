{-# LANGUAGE OverloadedStrings #-}
module Handler.UpdateKitteh where

import           Types.ModelTypes
import           Import

postUpdateKittehR :: KittehDataId -> Handler (Value)
postUpdateKittehR kid = do
  toJSON <$> ((updateKitteh kid) =<< (requireJsonBody :: Handler KittehDesc))

updateKitteh :: KittehDataId -> KittehDesc -> Handler (Text)
updateKitteh kid desc = 
  runDB $ do
           (Entity mid _) <- getMetaKitty
           update mid [KittehMetaKitteh_desc =. desc]
           return ("Kitteh Description Updated" :: Text)
           where
             getMetaKitty = getBy404 $ UniqueKittehDataId kid
