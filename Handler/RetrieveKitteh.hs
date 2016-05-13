module Handler.RetrieveKitteh where

import Import
import Yesod.Core.Json (returnJson, Value (..))

import Types.Composite

getRetrieveKittehR :: KittehDescId -> Handler (Value)
getRetrieveKittehR kit_id = do
   (Entity _ (KittehData kit_desc_id sfp)) <- runDB $ getBy404 $ UniqueKittehId kit_id
   (KittehDesc blurb' color' size') <- runDB $ get404 kit_desc_id
   let meta   = KittehDesc blurb' color' size'
       kitteh = Kitteh meta sfp
   returnJson $ kitteh
   

