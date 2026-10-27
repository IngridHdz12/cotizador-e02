# Taller 5 · Composición o herencia

Nombre: Ingrid Annete Hernández Montoya
Número de control: 22100199
Equipo: E02

Copia este archivo a `talleres/27-oct/<tu número de control>/respuestas.md` en el repositorio de tu
equipo, junto con tu `composicion.ts`. Entrega: martes 27 de octubre, 23:59.

## Paso 1 · La herencia

**a)** ¿En qué dos clases está escrito el cálculo del seguro? ¿Por qué no se pudo escribir una sola
vez?
En ConSeguro y RefrigeradaConSeguro. No fue posible definirlo en una sola clase debido a que TypeScript no cuenta con soporte para herencia múltiple; por ello, como RefrigeradaConSeguro hereda el comportamiento de refrigeración desde Refrigerada, fue necesario volver a implementar la lógica del seguro.

**b)** Con un tercer extra (express), ¿cuántas clases hacen falta para todas las combinaciones?
¿Cuántas son nuevas? Muestra la cuenta.
Se requerirían 8 clases en total. Se añadirían 4 clases nuevas: Express, ExpressRefrigerada, ExpressConSeguro y ExpressRefrigeradaConSeguro.


## Paso 2 · La composición

**c)** Para agregar express a `composicion.ts`, ¿qué agregaste? ¿Cambió `cotizar`?
Únicamente se añadió la función express, la cual aplica el costo fijo adicional de $500.00. La función cotizar no sufrió ningún cambio, ya que recibe las combinaciones directamente a través del arreglo de funciones que se le pasa.

## Paso 3 · El orden

| Llamada | Predigo | Salió |
|---|---|---|
| `cotizar(100, 1000, [express, seguro])` | 153000 | 153000 |
| `cotizar(100, 1000, [seguro, express])` | 152000 | 152000 |

**d)** ¿Por qué salen distintos? (dos líneas)
Al procesar express primero, el 2 % del seguro se aplica también sobre los $500 extras; en cambio, si va el seguro al inicio, los $500 se añaden posteriormente sin afectar la tasa del seguro.


## Paso 4 · Sostén la decisión

**e)** En su modelo del proyecto, ¿cómo están escritos los pasos del cálculo: con herencia o con composición? Cita el archivo y la función. Están implementados mediante composición. Se encuentran estructurados encadenando funciones dentro de src/modelo.ts (específicamente en la función cotizar).


**f)** Da **un** caso, en su proyecto o fuera de él, donde sí usarías herencia, y di por qué ahí no hay explosión de combinaciones. (tres líneas)
Resulta conveniente usar herencia para crear subclases personalizadas a partir de la clase base Error. Esto se debe a que el manejo de errores evoluciona en una única dimensión de variabilidad y no se combina con otros comportamientos. De este modo, se evita la proliferación de combinaciones híbridas como ErrorDeRedYValidacion.