module Library where
import PdePreludat

-- creamos un data Persona usando record syntax
data Persona = Persona {
  nombre :: String,
  edad :: Number,
  domicilio :: String,
  telefono :: String,
  fechaNacimiento :: (Number, Number, Number),
  esBuenaPersona :: Bool
  } deriving (Show)

-- creamos una funcion para saber si una edad corresponde a un adulto
edadMayor :: Number -> Bool
edadMayor edad = edad >= 18

-- creamos una funcion para saber si una Persona es mayor de edad
personaMayor :: Persona -> Bool
personaMayor = edadMayor . edad

guada :: Persona
guada = Persona {
  nombre = "Guada",
  edad = 9,
  domicilio = "Caboto 599",
  telefono = "112345678",
  fechaNacimiento = (2015, 11, 27),
  esBuenaPersona = True
}

iara :: Persona
iara = Persona {
  nombre = "Iara",
  edad = 33,
  domicilio = "Inclan 2378",
  telefono = "1123991898",
  fechaNacimiento = (1992, 4, 16),
  esBuenaPersona = True
}

maite :: Persona
maite = Persona {
  nombre = "Maite",
  edad = 9,
  domicilio = "Inclan 2378",
  telefono = "1165951190",
  fechaNacimiento = (2015, 7, 25),
  esBuenaPersona = True
}

cumplirAnios :: Persona -> Persona
cumplirAnios persona = persona { edad = edad persona + 1 }

