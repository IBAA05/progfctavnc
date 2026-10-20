{-# LANGUAGE OverloadedStrings #-}

import Control.Monad
import Data.Aeson
import Data.Maybe
import Data.Text qualified as T
import Data.Text.Lazy
import GHC.Generics
import Lucid
import Network.Wai.Middleware.RequestLogger 
import Network.Wai.Middleware.Static 
import Web.Scotty
import System.Environment (lookupEnv)


data Person = Person
    { _name :: Text
    , _year :: Int
    } deriving (Generic, Show)

instance ToJSON Person

add2 :: Integer -> Integer -> Integer
add2 = (+)

-- TODO
urls :: [T.Text]
urls = ["/route1","/route1/route2","/html1", "/json1", "/json2", "/add1/20/22", "/add2?x=20&y=22","/add2?x=20", "/add2", "/index" ]

-- TODO
indexPage :: Html ()
indexPage =
   doctypehtml_ $ do
        head_ $ do
            meta_ [charset_ "utf-8"]
            style_ "body { background-color: pink; }"
        body_ $ do
            h1_ "hello-scotty"
            hr_[]
            ul_ $ forM_ urls $ \url -> do 
                li_ $ a_ [href_ url] $ toHtml url
            img_ [src_ "bob.png"]
         

-- main
main :: IO ()
main = scotty 3000 $ do
  middleware logStdoutDev
  middleware $ staticPolicy $ addBase "static"
  get "/route1" $ text "this is /route1"
  get "/route1/route2" $ text "this is /route1/route2"
  get "/html1" $ html "<h1>this is html1</h1>"
  get "/json1" $ json (42 :: Int) 
  get "/json2" $ json (Person "John Doe" 42)
  get "/add1/:x/:y" $ do
    x <- captureParam "x"
    y <- captureParam "y" 
    json $ add2 x y 

  get "/add2" $ do
    x <- fromMaybe 0 <$> queryParamMaybe "x"
    y <- fromMaybe 0 <$> queryParamMaybe "y"
    json $ add2 x y

  get "/index" $ redirect "/"

  get "/" $ html $ renderText indexPage
  

  