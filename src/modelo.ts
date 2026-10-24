export type Puente = 'comercio_mundial' | 'colombia';

// 2. La carga
export type Carga =
  | { tipo: 'general' }
  | { tipo: 'refrigerada' }
  | { tipo: 'peligrosa'; numeroUn: string }
  | { tipo: 'sobredimensionada'; permiso: string };

// 3. El embarque
export type DatosComunes = {
  id: string;
  pesoKg: number;
  distanciaKm: number;
  puente: Puente;
};
export type Embarque = DatosComunes & Carga;

// 4. Cotizacion
export type Cotizacion = {
  id: string;
  fleteBruto: number;
  descuento: number;
  flete: number;
  cuotaPuente: number;
  recargo: number;
  ajusteMinimo: number;
  total: number;
};

// 5. Motivo
export type Motivo = 'peso_invalido' | 'distancia_invalida' | 'excede_peso_maximo';

// 1. Los cuatro estados
export type Borrador = { estado: 'borrador'; embarque: Embarque };
export type Cotizado = { estado: 'cotizado'; embarque: Embarque; cotizacion: Cotizacion };
export type Rechazado = { estado: 'rechazado'; embarque: Embarque; motivo: Motivo };
export type Despachado = { estado: 'despachado'; embarque: Embarque; cotizacion: Cotizacion; folio: string };

// 6. Reglas
export type Reglas = {
  cuotaPuente: Record<Puente, number>;
  pesoMaximoKg: number;
  tarifaKm: number;
  descuento: {
    pct: number;
    criterio: 'a_partir_de' | 'mas_de';
    umbralKg: number;
  };
  recargo: Record<Carga['tipo'], { pct: number; fija: number }>;
  baseRecargo: 'flete' | 'subtotal';
  minimo: number;
};

// 7. Resultado
export type Resultado<T, E> = 
  | { ok: true; valor: T } 
  | { ok: false; error: E };

  
export function cotizar(_b: Borrador, _r: Reglas): Cotizado | Rechazado {
  throw new Error('por implementar');
}

export function despachar(_c: Cotizado, _folio: string): Despachado {
  throw new Error('por implementar');
}