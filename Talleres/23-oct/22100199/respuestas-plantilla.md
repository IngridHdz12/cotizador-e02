# Taller 4 · De condicionales a despacho

Nombre: Ingrid Annete Hernández Montoya
Número de control: 22100199
Equipo: E02

Copia este archivo a `talleres/23-oct/<tu número de control>/respuestas.md` en el repositorio de tu
equipo, junto con tu `despacho.ts`. Entrega: viernes 23 de octubre, 23:59.


## Paso 1 · La versión con switch

**a)** Antes de tocar nada: ¿cuántos lugares de `condicionales.ts` hay que cambiar para agregar
`perecedera`? 
- Se requieren 4 cambios en total: la unión de tipos en `Tipo` y los bloques `switch` dentro de las funciones `recargo`, `documentoRequerido` y `etiqueta`.

**b)** Después de agregar `'perecedera'` solo al tipo: ¿qué dijo `tsc`, y qué imprimió la
demostración para perecedera?
- `tsc` compilo sin reportar ningún error. La ejecución de la demostración imprimió: `perecedera 0 null General`.

**c)** ¿Por qué el compilador no te avisó? (una línea)
- Porque las tres funciones incluyen un caso `default` que absorbe el nuevo tipo sin activar la validación de exhaustividad.


## Paso 3 · La versión con tabla

**d)** Después de agregar `'perecedera'` al tipo: ¿qué dijo `tsc`? Copia el mensaje.
- `Property 'perecedera' is missing in type '{ general: Politica; refrigerada: Politica; peligrosa: Politica; sobredimensionada: Politica; }' but required in type 'Record<Tipo, Politica>'.`

**e)** ¿Cuántos lugares cambiaste en `despacho.ts` para agregar perecedera?
- Solamente 1 sitio: `POLITICAS`.

## Los dos lenguajes

**f)** En su motor de Elixir, ¿qué pasa si llega un tipo de carga para el que no hay cláusula? ¿Y en
`despacho.ts`, si a la tabla le falta un tipo? ¿Cuál de los dos te avisa antes, y cuándo? (dos líneas)
- Elixir genera una excepción `FunctionClauseError` en tiempo de ejecución. TypeScript lanza un error de tipos durante la fase de compilación.
- TypeScript detecta la falla primero (en tiempo de compilación previa a la ejecución), mientras que Elixir no lo nota sino hasta ejecutar el código.
