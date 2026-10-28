// Etapa 1
export type Puente = 'comercio_mundial' | 'colombia';

export type Carga =
  | { tipo: 'general' }
  | { tipo: 'refrigerada' }
  | { tipo: 'peligrosa'; numeroUn: string }
  | { tipo: 'sobredimensionada'; permiso: string };

export type DatosComunes = {
  id: string;
  pesoKg: number;
  distanciaKm: number;
  puente: Puente;
};
export type Embarque = DatosComunes & Carga;

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

export type Motivo = 'peso_invalido' | 'distancia_invalida' | 'excede_peso_maximo';

export type Borrador = { estado: 'borrador'; embarque: Embarque };
export type Cotizado = { estado: 'cotizado'; embarque: Embarque; cotizacion: Cotizacion };
export type Rechazado = { estado: 'rechazado'; embarque: Embarque; motivo: Motivo };
export type Despachado = { estado: 'despachado'; embarque: Embarque; cotizacion: Cotizacion; folio: string };

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

export type Resultado<T, E> = 
  | { ok: true; valor: T } 
  | { ok: false; error: E };

// Etapa 2 
const pct = (monto: number, p: number): number => Math.floor((monto * p + 50) / 100);

const POLITICAS_CARGA: Record<Carga['tipo'], { revisaPeso: boolean }> = {
  general: { revisaPeso: true },
  refrigerada: { revisaPeso: true },
  peligrosa: { revisaPeso: true },
  sobredimensionada: { revisaPeso: false }
};

function validar(e: Embarque, r: Reglas): Resultado<Embarque, Motivo> {
  if (e.pesoKg <= 0) return { ok: false, error: 'peso_invalido' };
  if (e.distanciaKm <= 0) return { ok: false, error: 'distancia_invalida' };
  
  if (POLITICAS_CARGA[e.tipo].revisaPeso && e.pesoKg > r.pesoMaximoKg) {
    return { ok: false, error: 'excede_peso_maximo' };
  }
  
  return { ok: true, valor: e };
}

export function cotizar(b: Borrador, r: Reglas): Cotizado | Rechazado {
  const validacion = validar(b.embarque, r);
  if (!validacion.ok) {
    return { estado: 'rechazado', embarque: b.embarque, motivo: validacion.error };
  }

  const e = validacion.valor;
  
  const fleteBruto = e.distanciaKm * r.tarifaKm;
  
  const aplicaDescuento = r.descuento.criterio === 'a_partir_de' 
    ? e.pesoKg >= r.descuento.umbralKg 
    : e.pesoKg > r.descuento.umbralKg;
    
  const descuento = aplicaDescuento ? pct(fleteBruto, r.descuento.pct) : 0;
  const flete = fleteBruto - descuento;
  const cuotaPuente = r.cuotaPuente[e.puente];
  
  const baseRecargo = r.baseRecargo === 'flete' ? flete : (flete + cuotaPuente);
  const politicaRecargo = r.recargo[e.tipo];
  const recargo = pct(baseRecargo, politicaRecargo.pct) + politicaRecargo.fija;
  
  const totalParcial = flete + cuotaPuente + recargo;
  const ajusteMinimo = totalParcial < r.minimo ? (r.minimo - totalParcial) : 0;
  const total = totalParcial + ajusteMinimo;

  const cotizacion: Cotizacion = {
    id: e.id,
    fleteBruto,
    descuento,
    flete,
    cuotaPuente,
    recargo,
    ajusteMinimo,
    total
  };

  return { estado: 'cotizado', embarque: e, cotizacion };
}

// Etapa 3
export function despachar(c: Cotizado, folio: string): Despachado {
  return {
    estado: 'despachado',
    embarque: c.embarque,
    cotizacion: c.cotizacion,
    folio: folio
  };
}