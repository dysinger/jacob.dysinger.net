{-# LANGUAGE OverloadedStrings #-}

import Data.Foldable (forM_)
import Hakyll

main :: IO ()
main =
  hakyllWith
    defaultConfiguration
    (do match "css/*"
              (do route idRoute
                  compile compressCssCompiler)
        forM_ ["fonts/*","img/*","js/*"]
              (flip match
                    (do route idRoute
                        compile copyFileCompiler))
        match "templates/*" (compile templateCompiler)
        match "index.md"
              (do route (setExtension "html")
                  compile (pandocCompiler >>=
                           loadAndApplyTemplate "templates/index.html" defaultContext >>=
                           relativizeUrls)))
