{-# LANGUAGE OverloadedStrings #-}
module Handler.RetrieveKitteh where

import Import
import Types.Sundry
import Types.ModelTypes

getRetrieveKittehR :: KittehDataId -> Handler (Value)
getRetrieveKittehR kit_id =   
  returnJson <=< 
  runDB $ do
           (Entity _ (KittehMeta kid status desc)) <- getMetaKitty
           case status of 
             OFFLINE -> noKitty 
             ONLINE  -> yesKitty kid desc
           where
             getMetaKitty = getBy404 $ UniqueKittehDataId kit_id
             noKitty = return $ Left ("Kitteh is Unavailable" :: Text)
             yesKitty kid desc = do
                                  (KittehData pic) <- get404 kid
                                  return $ Right $ Kitteh desc pic
