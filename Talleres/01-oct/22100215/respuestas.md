# Taller · quitar la mutación

Nombre: Carlos Andres Osorio Gonzalez
Número de control:22100215
Equipo: 02

Copia este archivo a `talleres/01-oct/<tu número de control>/respuestas.md` en el repositorio de tu equipo,
junto con tu `sin_mutacion.ex`, y llena la tabla. Entrega: hoy antes de las 23:59.

| # | Función | ¿Qué muta la versión de TypeScript? | ¿Quién más se entera del cambio? |
|---|---|---|---|
| 1 | total_pesos | El Acumulador | Local |
| 2 | marcar_urgentes | Los Objetos | Quien los tenga |
| 3 | aplicar_descuento | El Arreglo | Quien manda el arreglo |
| 4 | contar_por_tipo | El Contador | Nadie |
| 5 | sin_duplicados | Vistos y Resultado | Nadie |


¿Cuál de las cinco era la más peligrosa en TypeScript, y por qué? (dos líneas)
La más peligrosa es la 3ra, porque realiza mutación directamente en la referencia de los objetos o arreglos recibidos como parámetros de entrada, en lugar de generar copias.