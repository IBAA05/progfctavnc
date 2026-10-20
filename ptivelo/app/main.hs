
{-# LANGUAGE OverloadedStrings #-}

import Model
import View
import Network.Wai.Middleware.RequestLogger 
import Network.Wai.Middleware.Static 
import Web.Scotty
import Lucid (renderText)

riders :: [Rider]
riders =
    [ Rider "Andy Buckworth" ["andy-buckworth.jpg"]
    , Rider "Brandon Loupos" ["brandon-loupos-1.jpg", "brandon-loupos-2.jpg"]
    , Rider "Dave Mirra" ["dave-mirra.jpg"]
    , Rider "Harry Main" ["harry-main.jpg"]
    , Rider "Logan Martin" ["logan-martin-1.jpg", "logan-martin-2.png", "logan-martin-3.jpg"]
    , Rider "Mark Webb" ["mark-webb-1.jpg", "mark-webb-2.jpg"]
    , Rider "Matt Hoffman" ["matt-hoffman.jpg"]
    , Rider "Pat Casey" ["pat-casey-1.jpg", "pat-casey-2.jpg"]
    ]


main :: IO ()
main = scotty 3000 $ do 
    middleware logStdoutDev
    middleware $ staticPolicy (addBase "static")
    get "/riders" $ json riders 
    get "/" $ html $ renderText $ indexPage riders 
