module Handler.ListKittehs where

import Import
import Types.ModelTypes

getListKittehsR :: Handler (Value)
getListKittehsR = 
  returnJson <=< 
  runDB $ do selectList [KittehMetaKitteh_status ==. ONLINE] [Desc KittehMetaId]
