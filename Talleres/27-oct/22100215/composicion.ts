// Taller 5 · Composición o herencia
// Lo mismo, sin clases: cada extra es una función que recibe un monto y regresa otro.
// Una cotización es el viaje más la LISTA de extras que lleva.
// Regla: en este archivo no hay `class` ni `extends`.

export type Ajuste = (monto: number) => number;

const pct = (monto: number, p: number): number => Math.floor((monto * p + 50) / 100);

export const frio: Ajuste = (monto) => monto + pct(monto, 18);

export const seguro: Ajuste = (monto) => monto + pct(monto, 2);

export const express: Ajuste = (monto) => monto + 50000;

export function cotizar(km: number, tarifaKm: number, ajustes: readonly Ajuste[]): number {
  return ajustes.reduce((montoAcumulado, ajuste) => ajuste(montoAcumulado), km * tarifaKm);
}