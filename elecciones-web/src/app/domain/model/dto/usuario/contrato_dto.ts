import { Entidad } from './entidad_dto';

export interface Contrato {
  id: number;
  nombre: string;
  entidad: Entidad;
  identificacion: string;
  sesiones: number;
  sesionesActivas: number;
  suscripcion: string;
  juntasSuscritas: number;
  juntasUsadas: number;
  activo: string;
  fechaInicio: Date;
  fechaFin: Date;
  tiempoRestante: string;
  url: string;
  fotoArchivo: string;
  fotoNombre: string;
  fondo: string;
  color: string;
}
