{-# LANGUAGE OverloadedStrings #-}
module Handler.ChangeStatusKitteh where

import           Types.ModelTypes
-- import           Data.Text (pack)

import           Import

getChangeStatusKittehR :: KittehDataId -> Handler (Value)
getChangeStatusKittehR = returnJson <=< changeStatusKitteh

changeStatusKitteh :: KittehDataId -> Handler (Text)
changeStatusKitteh kid = 
  runDB $ do
           (Entity mid (KittehMeta _ status _)) <- getMetaKitty
           let newStatus = case status of
                             OFFLINE -> ONLINE
                             ONLINE  -> OFFLINE
           update mid [ KittehMetaKitteh_status =. newStatus ]
           return $ resMsg status newStatus
           where
             resMsg :: KittehStatus -> KittehStatus -> Text
             resMsg status newStatus = 
               "Status changed from " <> 
               (pack $ show status)   <> 
               " to " <> (pack $ show newStatus)  
             getMetaKitty = getBy404 $ UniqueKittehDataId kid



