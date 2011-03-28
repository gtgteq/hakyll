{-# LANGUAGE OverloadedStrings #-}
module Hakyll.Core.Identifier.Tests
    ( tests
    ) where

import Test.Framework
import Test.HUnit hiding (Test)

import Hakyll.Core.Identifier.Pattern
import TestSuite.Util

tests :: [Test]
tests = fromAssertions "match"
    [ Just ["bar"]              @=? match "foo/**" "foo/bar"
    , Just ["foo/bar"]          @=? match "**" "foo/bar"
    , Nothing                   @=? match "*" "foo/bar"
    , Just []                   @=? match "foo" "foo"
    , Just ["foo"]              @=? match "*/bar" "foo/bar"
    , Just ["foo/bar"]          @=? match "**/qux" "foo/bar/qux"
    , Just ["foo/bar", "qux"]   @=? match "**/*" "foo/bar/qux"
    , Just ["foo", "bar/qux"]   @=? match "*/**" "foo/bar/qux"
    , Just ["foo"]              @=? match "*.html" "foo.html"
    , Nothing                   @=? match "*.html" "foo/bar.html"
    , Just ["foo/bar"]          @=? match "**.html" "foo/bar.html"
    , Just ["foo/bar", "wut"]   @=? match "**/qux/*" "foo/bar/qux/wut"
    , Just ["lol", "fun/large"] @=? match "*cat/**.jpg" "lolcat/fun/large.jpg"
    ]