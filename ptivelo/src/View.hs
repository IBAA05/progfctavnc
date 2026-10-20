
{-# LANGUAGE OverloadedStrings #-}

module View where

import Control.Monad
import Data.Text (Text)
import Lucid
import Model


indexPage :: [Rider] -> Html ()
indexPage riders =
   doctypehtml_ $ do
        head_ $ do
            meta_ [charset_ "utf-8"]
            link_ [rel_ "stylesheet", href_ "style.css"]
        body_ $ do
            h1_ "ptivelo"
            hr_[]
            forM_ riders $ \(Rider name images) -> do
                 h2_ $ toHtml $ name
                 forM_ images $ \image -> do
                    div_ $ a_ [href_ image] $ do
                        img_ [src_ image, height_ "100px"]
                    br_ []
