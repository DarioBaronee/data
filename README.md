# Kata funcional

## Integrante

- integrante1 (usuario github)

## Objetivos

En esta kata los objetivos son

- Verificar que tenés correctamente instalado el entorno
- Familiarizarte con el uso del lenguaje Haskell y de la herramienta Visual Studio Code
- Que entiendas el circuito básico de toda kata, bajando el enunciado desde un repositorio, completando el ejercicio y subiendo tu solución
- Utilizar pruebas automatizadas para facilitar la validación del código que escribís

## Enunciado

Desarrollar la función **nivelDeAlegria** en Haskell que determine el nivel de alegría de una persona en base a su energía que tiene una escala del 1 al 10 y la cantidad de horas de sueño que ha tenido. Los criterios son los siguientes

- Si durmió 8 horas o más entonces es la energía * 2
- Si no llega a esas horas pero tiene energía mayor a 8 es la suma de la energía más las horas de sueño
- Si tampoco llega a 8 puntos de energía es el promedio de la energía y las horas de sueño
