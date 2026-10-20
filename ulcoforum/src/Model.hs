
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE OverloadedLabels #-}
{-# LANGUAGE TypeOperators #-}

module Model where

import Data.Bool
import Database.Selda
import Database.Selda.SQLite

----------------------------------------------------------------------
-- params
----------------------------------------------------------------------

dbFilename :: String
dbFilename = "ulcoforum.db"

----------------------------------------------------------------------
-- Thread
----------------------------------------------------------------------

-- TODO

----------------------------------------------------------------------
-- Message
----------------------------------------------------------------------

-- TODO

----------------------------------------------------------------------
-- queries
----------------------------------------------------------------------

printStatus :: String -> Bool -> IO ()
printStatus status result = putStrLn $ status <> ": " <> bool "KO" "OK" result

dbInit :: SeldaT SQLite IO ()
dbInit = do
  pure ()

-- TODO


