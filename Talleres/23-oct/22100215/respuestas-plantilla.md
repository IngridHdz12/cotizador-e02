# Taller 4 · De condicionales a despacho

Nombre: Carlos Andres Osorio Gonzalez
Número de control: 22100215
Equipo: E02

Copia este archivo a `talleres/23-oct/<tu número de control>/respuestas.md` en el repositorio de tu
equipo, junto con tu `despacho.ts`. Entrega: viernes 23 de octubre, 23:59.


## Paso 1 · La versión con switch

**a)** Antes de tocar nada: ¿cuántos lugares de `condicionales.ts` hay que cambiar para agregar
`perecedera`? 
- 4 lugares, la definición del tipo en "Tipo" y los tres switch dentro de cada función.

**b)** Después de agregar `'perecedera'` solo al tipo: ¿qué dijo `tsc`, y qué imprimió la
demostración para perecedera?
- tsc no mostró ningún error, y la demostración imprimió perecedera  0  null  General.

**c)** ¿Por qué el compilador no te avisó? (una línea)
- Porque las tres funciones tienen un caso default, haciendo que el nuevo tipo caiga ahí en silencio sin generar error.


## Paso 3 · La versión con tabla

**d)** Después de agregar `'perecedera'` al tipo: ¿qué dijo `tsc`? Copia el mensaje.
- tsc arrojó un error indicando que falta una propiedad en el objeto: "Property 'perecedera' is missing in type '{ general: ... }' but required in type 'Record<Tipo, Politica>'".

**e)** ¿Cuántos lugares cambiaste en `despacho.ts` para agregar perecedera?
- Solo 1, la tabla POLITICAS.

## Los dos lenguajes

**f)** En su motor de Elixir, ¿qué pasa si llega un tipo de carga para el que no hay cláusula? ¿Y en
`despacho.ts`, si a la tabla le falta un tipo? ¿Cuál de los dos te avisa antes, y cuándo? (dos líneas)
- En Elixir arroja un FunctionClauseError al ejecutar. En TypeScript arroja un error de compilación. 
- TypeScript avisa antes, ya que detiene el código en tiempo de compilación, mientras que Elixir falla hasta el tiempo de ejecución.
