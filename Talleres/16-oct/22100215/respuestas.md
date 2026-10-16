# Taller 3 · La mutación escondida

Nombre: Carlos Andres Osorio Gonzalez
Número de control: 22100215
Equipo: E02

## 1 · Antes y después de ejecutar

Llena "Predigo" **antes** de correr `npx tsx escondida.ts`. No borres las predicciones que fallaron.

| Línea | Predigo | Salió |
|---|---|---|
| 1 · | A, B false | B, A true |
| 2 · | 2 · 5 false | 2 · 10  true |
| 3 · | 3 · 2 true | 3 · 2 true |
| 4 · | 4 · null false | 4 · SCT-77 false |
| 5 · | 5 · 12 15 | 5 · 15 15 |

## 2 · Qué se muta y quién se entera

| # | Función | ¿Qué línea muta, y qué cambia? | ¿Quién más se entera del cambio? |
|---|---|---|---|
| 1 | ordenarPorPeso | Muta el orden del arreglo original | Cualquier otra parte del código que estuviera usando esa lista |
| 2 | conDescuento | "conDescuento", sobrescribe el valor dentro del objeto | Todos los que usen esas mismas reglas |
| 3 | registrar | "registrar" inyecta elementos a una lista global compartida | Cualquier llamada futura a la función |
| 4 | conPermiso | "conPermiso" altera el nivel interno | El objeto original porque comparten esa estructura interna |
| 5 | fechaDeEntrega | "fechaDeEntrega" modifica el valor del objeto de fecha | La variable donde se guarda la fecha originalmente |


## 3 · Tres preguntas cortas

**a)** En la línea 4 salió `false` en `original === conP`, y aun así el original cambió. ¿Cómo es
posible? (dos líneas)
Porque la copia y el original son diferentes cajas en su primer nivel; pero al no ser una copia profunda, el mapa interno documentos sigue siendo la misma caja compartida en memoria para ambos.

**b)** ¿Por qué `registrar` no es una función pura? (una línea)
Porque devuelve resultados distintos con el mismo argumento dependiendo de cuántas veces se haya llamado antes, alterando un estado externo.

**c)** En tus pruebas de Elixir, la última aserción de cada una revisa que el original sigue igual.
¿Por qué en Elixir esa aserción no puede fallar? (dos líneas)
En Elixir los datos son inmutables por diseño, cualquier modificación estructural en realidad crea y devuelve una estructura de datos completamente nueva, dejando la original intacta.

