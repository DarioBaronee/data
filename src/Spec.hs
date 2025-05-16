module Spec where
import PdePreludat
import Library
import Test.Hspec

correrTests :: IO ()
correrTests = hspec $ do
  describe "Test de ejemplo" $ do
    it "Funcion esPrimo esta correcto" $ do
      esPrimo 29 `shouldBe` True
      


