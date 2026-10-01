# Taller · quitar la mutación

Nombre: Ingrid Annete Hernández Montoya
Número de control:22100199
Equipo: 02

Copia este archivo a `talleres/01-oct/<tu número de control>/respuestas.md` en el repositorio de tu equipo,
junto con tu `sin_mutacion.ex`, y llena la tabla. Entrega: hoy antes de las 23:59.

| # | Función | ¿Qué muta la versión de TypeScript? | ¿Quién más se entera del cambio? |
|---|---|---|---|
| 1 | total_pesos | acumulador | Local |
| 2 | marcar_urgentes | objetos | quien los tenga |
| 3 | aplicar_descuento | arreglo | quien lo mando |
| 4 | contar_por_tipo | contador | nadie |
| 5 | sin_duplicados | vistos y resultado | nadie |

¿Cuál de las cinco era la más peligrosa en TypeScript, y por qué? (dos líneas)
La más peligrosa es marcarUrgentes porque realiza mutación por referencia en los objetos o arreglos recibidos como parámetros de entrada en lugar de generar copias.