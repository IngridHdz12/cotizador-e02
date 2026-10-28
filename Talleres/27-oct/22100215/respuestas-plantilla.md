# Taller 5 · Composición o herencia

Nombre: Carlos Andres Osorio Gonzalez
Número de control: 22100215
Equipo: E02

Copia este archivo a `talleres/27-oct/<tu número de control>/respuestas.md` en el repositorio de tu
equipo, junto con tu `composicion.ts`. Entrega: martes 27 de octubre, 23:59.

## Paso 1 · La herencia

**a)** ¿En qué dos clases está escrito el cálculo del seguro? ¿Por qué no se pudo escribir una sola
vez?
En las clases `ConSeguro` y `RefrigeradaConSeguro`, no se pudo escribir una sola vez porque TypeScript no soporta herencia múltiple. RefrigeradaConSeguro hereda el frío de Refrigerada, y el seguro se reescribe.

**b)** Con un tercer extra (express), ¿cuántas clases hacen falta para todas las combinaciones?
¿Cuántas son nuevas? Muestra la cuenta.
Harían falta 8 clases en total. Habría 4 nuevas clases: `Express`, `ExpressRefrigerada`, `ExpressConSeguro` y `ExpressRefrigeradaConSeguro`.


## Paso 2 · La composición

**c)** Para agregar express a `composicion.ts`, ¿qué agregaste? ¿Cambió `cotizar`?
Solo agregue la función express con su cálculo de +$500.00 fijos. La función cotizar no cambia por que la combinación es simplemente la lista que se le pasa.

## Paso 3 · El orden

| Llamada | Predigo | Salió |
|---|---|---|
| `cotizar(100, 1000, [express, seguro])` | 153000 | 153000 |
| `cotizar(100, 1000, [seguro, express])` | 152000 | 152000 |

**d)** ¿Por qué salen distintos? (dos líneas)
Por el orden en que se ej
Por que con `express` primero, el seguro cobra su 2 % también sobre los $500; y con el `seguro` primero no, ya que los $500 se suman despues.


## Paso 4 · Sostén la decisión

**e)** En su modelo del proyecto, ¿cómo están escritos los pasos del cálculo: con herencia o con composición? Cita el archivo y la función.
Los pasos del cálculo están escritos con composición. Se pueden ver encadenados mediante funciones en el archivo src/modelo.ts (dentro de la función cotizar)


**f)** Da **un** caso, en su proyecto o fuera de él, donde sí usarías herencia, y di por qué ahí no hay explosión de combinaciones. (tres líneas)
Usaría herencia para extender la clase Error , ya que hay una sola dimensión de variación y el comportamiento del error siempre es útil y nunca se combina de formas explosivas. Nunca se mezclan y se muestran errores como `ErrorDeRedYValidacion`.