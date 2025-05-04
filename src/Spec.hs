module Spec where
import PdePreludat
import Library
import Test.Hspec

correrTests :: IO ()
correrTests = hspec $ do
  describe "Test de ejemplo" $ do
    it "El nombre de Guada es correcto" $ do
      nombre guada `shouldBe` "Guada"
    it "La edad de Guada es correcta" $ do
      edad guada `shouldBe` 9
    it "Guada no es mayor de edad" $ do
      personaMayor guada `shouldBe` False
    it "Iara es mayor de edad" $ do
      personaMayor iara `shouldBe` True
      


