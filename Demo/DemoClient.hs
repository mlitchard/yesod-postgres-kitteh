module Demo.DemoClient 
  (demo) 
  where

import           Types.Composite
import           Types.Atomic
import           Import
import qualified Data.ByteString        as B
import qualified Data.ByteString.Base64 as B64
import qualified Data.Text              as T
import qualified Data.ByteString.Char8  as C
import           Data.Aeson
import           Data.Conduit              (($$+-))
import           Data.Conduit.Attoparsec   (sinkParser)
import           Network.HTTP.Conduit      (Request,
                                            RequestBody (RequestBodyLBS),
                                            Response (..),
                                            http,
                                            method,
                                            parseUrl,
                                            requestBody,
                                            tlsManagerSettings,
                                            requestHeaders)
import           Control.Applicative
import Import
import Types.Composite
demo :: IO ()
demo = do
    (pic1:kitteh_pics_B64) <- map (Base64 . B64.encode) <$>
                              mapM B.readFile kitteh_files
    req'            <- parseUrl "http://localhost:3000/UploadKitteh"
    manager         <- newManager
--    let kitteh_pics_B64 = map (Base64 . B64.encode) kitteh_pics 
    runResourceT $ do
        let req = makeRequest req' $ encode $ toJSON $ Kitteh meta1 pic1
        result <- http req manager
        printResult result 
        return ()
    where
      kitteh_files   = map (demo_directory ++) ["1.jpg","2.jpg","3.jpg"]
      (meta1:kitteh_meta) = [KittehDesc
                             {kittehDescBlurb = "cute kitteh"
                             ,kittehDescColor = Black
                             ,kittehDescSize  = LapKitteh
                             }
                            ]
--                       ,KittehMeta
--                         {description = "moar cute kitteh"
--                         ,color       = Black
--                         ,size        = FluffBall
--                         }
--                       ,KittehMeta
--                         {description = "too cute"
--                         ,color       = Black
 --                        ,size        = BigAssCat
  --                       }
 --                     ]
      demo_directory = "Demo/"

makeRequest req' valueBS =
   req' { method = "POST"
        , requestBody = RequestBodyLBS valueBS
        , requestHeaders = jsonHeaders }
   where
      jsonHeaders = [(hContentType, C.pack "application/json")]

printResult result = do
   resValue <- responseBody result $$+- sinkParser json
   let test = fromJSON resValue :: Result Int
   liftIO $ print test
   return ()



                
