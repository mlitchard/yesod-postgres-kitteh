module Handler.ListKittehs where

import Import

import Types.Composite

getListKittehsR :: Handler (Value)
getListKittehsR = do
  returnJsonIndexes <=< runDB $ selectKittehKeys
  where
    returnJsonIndexes = returnJson <=< mapM makeIndex
    selectKittehKeys  = selectKeysList [] [Desc KittehDataId]

makeIndex :: Key KittehData -> Handler KittehIndex
makeIndex kitteh_key = do 
  kitteh_desc <- runDB $ do
                   (KittehData desc_key _) <- get404 kitteh_key 
                   get404 desc_key
  return $ KittehIndex kitteh_key kitteh_desc
