import { Contrato } from './contrato_dto';
import { Entidad } from './entidad_dto';

export interface UsuarioDto {
  id: number;
  username: string;
  entidad: Entidad;
  contrato: Contrato;
  activo: string;
  habilitadoMovil: string;
  sessionMovil: number;
  macMovil: string;
  habilitadoWeb: string;
  sessionWeb: number;
  roles: string[];
}
