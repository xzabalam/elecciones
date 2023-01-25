import { TipoIdentificacion } from './tipo_identificacion_dto';
import { Sexo } from './sexo_dto';

export interface Entidad {
  id: number;
  nombre: string;
  identificacion: string;
  fechaNacimiento: Date;
  mail: string;
  etnia: string;
  tipoIdentificacion: TipoIdentificacion;
  sexo: Sexo;
}
