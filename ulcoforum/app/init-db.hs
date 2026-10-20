
import Database.Selda.SQLite

import Model

main :: IO ()
main = withSQLite dbFilename dbInit

