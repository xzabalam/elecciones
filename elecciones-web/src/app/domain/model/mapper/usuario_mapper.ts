import { UsuarioDto } from './../dto/usuario/usuario_dto';

export class UsuarioMapper {
  public static toUsuarioDto(json: string): UsuarioDto {
    return cast(JSON.parse(json), r('UsuarioDto'));
  }

  public static usuarioDtoToJson(value: UsuarioDto): string {
    return JSON.stringify(uncast(value, r('UsuarioDto')), null, 2);
  }
}

function invalidValue(typ: any, val: any, key: any, parent: any = ''): never {
  const prettyTyp = prettyTypeName(typ);
  const parentText = parent ? ` on ${parent}` : '';
  const keyText = key ? ` for key "${key}"` : '';
  throw Error(
    `Invalid value${keyText}${parentText}. Expected ${prettyTyp} but got ${JSON.stringify(
      val
    )}`
  );
}

function prettyTypeName(typ: any): string {
  if (Array.isArray(typ)) {
    if (typ.length === 2 && typ[0] === undefined) {
      return `an optional ${prettyTypeName(typ[1])}`;
    } else {
      return `one of [${typ
        .map((a) => {
          return prettyTypeName(a);
        })
        .join(', ')}]`;
    }
  } else if (typeof typ === 'object' && typ.literal !== undefined) {
    return typ.literal;
  } else {
    return typeof typ;
  }
}

function jsonToJSProps(typ: any): any {
  if (typ.jsonToJS === undefined) {
    const map: any = {};
    typ.props.forEach((p: any) => (map[p.json] = { key: p.js, typ: p.typ }));
    typ.jsonToJS = map;
  }
  return typ.jsonToJS;
}

function jsToJSONProps(typ: any): any {
  if (typ.jsToJSON === undefined) {
    const map: any = {};
    typ.props.forEach((p: any) => (map[p.js] = { key: p.json, typ: p.typ }));
    typ.jsToJSON = map;
  }
  return typ.jsToJSON;
}

function transform(
  val: any,
  typ: any,
  getProps: any,
  key: any = '',
  parent: any = ''
): any {
  function transformPrimitive(typ: string, val: any): any {
    if (typeof typ === typeof val) return val;
    return invalidValue(typ, val, key, parent);
  }

  function transformUnion(typs: any[], val: any): any {
    // val must validate against one typ in typs
    const l = typs.length;
    for (let i = 0; i < l; i++) {
      const typ = typs[i];
      try {
        return transform(val, typ, getProps);
      } catch (_) {}
    }
    return invalidValue(typs, val, key, parent);
  }

  function transformEnum(cases: string[], val: any): any {
    if (cases.indexOf(val) !== -1) return val;
    return invalidValue(
      cases.map((a) => {
        return l(a);
      }),
      val,
      key,
      parent
    );
  }

  function transformArray(typ: any, val: any): any {
    // val must be an array with no invalid elements
    if (!Array.isArray(val)) return invalidValue(l('array'), val, key, parent);
    return val.map((el) => transform(el, typ, getProps));
  }

  function transformDate(val: any): any {
    if (val === null) {
      return null;
    }
    const d = new Date(val);
    if (isNaN(d.valueOf())) {
      return invalidValue(l('Date'), val, key, parent);
    }
    return d;
  }

  function transformObject(
    props: { [k: string]: any },
    additional: any,
    val: any
  ): any {
    if (val === null || typeof val !== 'object' || Array.isArray(val)) {
      return invalidValue(l(ref || 'object'), val, key, parent);
    }
    const result: any = {};
    Object.getOwnPropertyNames(props).forEach((key) => {
      const prop = props[key];
      const v = Object.prototype.hasOwnProperty.call(val, key)
        ? val[key]
        : undefined;
      result[prop.key] = transform(v, prop.typ, getProps, key, ref);
    });
    Object.getOwnPropertyNames(val).forEach((key) => {
      if (!Object.prototype.hasOwnProperty.call(props, key)) {
        result[key] = transform(val[key], additional, getProps, key, ref);
      }
    });
    return result;
  }

  if (typ === 'any') return val;
  if (typ === null) {
    if (val === null) return val;
    return invalidValue(typ, val, key, parent);
  }
  if (typ === false) return invalidValue(typ, val, key, parent);
  let ref: any = undefined;
  while (typeof typ === 'object' && typ.ref !== undefined) {
    ref = typ.ref;
    typ = typeMap[typ.ref];
  }
  if (Array.isArray(typ)) return transformEnum(typ, val);
  if (typeof typ === 'object') {
    return typ.hasOwnProperty('unionMembers')
      ? transformUnion(typ.unionMembers, val)
      : typ.hasOwnProperty('arrayItems')
      ? transformArray(typ.arrayItems, val)
      : typ.hasOwnProperty('props')
      ? transformObject(getProps(typ), typ.additional, val)
      : invalidValue(typ, val, key, parent);
  }
  // Numbers can be parsed by Date but shouldn't be.
  if (typ === Date && typeof val !== 'number') return transformDate(val);
  return transformPrimitive(typ, val);
}

function cast<T>(val: any, typ: any): T {
  return transform(val, typ, jsonToJSProps);
}

function uncast<T>(val: T, typ: any): any {
  return transform(val, typ, jsToJSONProps);
}

function l(typ: any) {
  return { literal: typ };
}

function a(typ: any) {
  return { arrayItems: typ };
}

function u(...typs: any[]) {
  return { unionMembers: typs };
}

function o(props: any[], additional: any) {
  return { props, additional };
}

function m(additional: any) {
  return { props: [], additional };
}

function r(name: string) {
  return { ref: name };
}

const typeMap: any = {
  UsuarioDto: o(
    [
      { json: 'id', js: 'id', typ: 0 },
      { json: 'username', js: 'username', typ: '' },
      { json: 'entidad', js: 'entidad', typ: r('Entidad') },
      { json: 'contrato', js: 'contrato', typ: r('Contrato') },
      { json: 'activo', js: 'activo', typ: '' },
      { json: 'habilitadoMovil', js: 'habilitadoMovil', typ: '' },
      { json: 'sessionMovil', js: 'sessionMovil', typ: 0 },
      { json: 'macMovil', js: 'macMovil', typ: '' },
      { json: 'habilitadoWeb', js: 'habilitadoWeb', typ: '' },
      { json: 'sessionWeb', js: 'sessionWeb', typ: 0 },
      { json: 'roles', js: 'roles', typ: a('') },
    ],
    false
  ),
  Contrato: o(
    [
      { json: 'id', js: 'id', typ: 0 },
      { json: 'nombre', js: 'nombre', typ: '' },
      { json: 'entidad', js: 'entidad', typ: r('Entidad') },
      { json: 'identificacion', js: 'identificacion', typ: '' },
      { json: 'sesiones', js: 'sesiones', typ: 0 },
      { json: 'sesionesActivas', js: 'sesionesActivas', typ: 0 },
      { json: 'suscripcion', js: 'suscripcion', typ: '' },
      { json: 'juntasSuscritas', js: 'juntasSuscritas', typ: 0 },
      { json: 'juntasUsadas', js: 'juntasUsadas', typ: 0 },
      { json: 'activo', js: 'activo', typ: '' },
      { json: 'fechaInicio', js: 'fechaInicio', typ: Date },
      { json: 'fechaFin', js: 'fechaFin', typ: Date },
      { json: 'tiempoRestante', js: 'tiempoRestante', typ: '' },
      { json: 'url', js: 'url', typ: '' },
      { json: 'fotoArchivo', js: 'fotoArchivo', typ: '' },
      { json: 'fotoNombre', js: 'fotoNombre', typ: '' },
      { json: 'fondo', js: 'fondo', typ: '' },
      { json: 'color', js: 'color', typ: '' },
      {
        json: 'hibernateLazyInitializer',
        js: 'hibernateLazyInitializer',
        typ: r('HibernateLazyInitializer'),
      },
    ],
    false
  ),
  Entidad: o(
    [
      { json: 'id', js: 'id', typ: 0 },
      { json: 'nombre', js: 'nombre', typ: '' },
      { json: 'identificacion', js: 'identificacion', typ: '' },
      { json: 'fechaNacimiento', js: 'fechaNacimiento', typ: Date },
      { json: 'mail', js: 'mail', typ: '' },
      { json: 'etnia', js: 'etnia', typ: '' },
      { json: 'tipoIdentificacion', js: 'tipoIdentificacion', typ: r('Sexo') },
      { json: 'sexo', js: 'sexo', typ: r('Sexo') },
      {
        json: 'hibernateLazyInitializer',
        js: 'hibernateLazyInitializer',
        typ: r('HibernateLazyInitializer'),
      },
    ],
    false
  ),
  HibernateLazyInitializer: o([], false),
  Sexo: o(
    [
      { json: 'id', js: 'id', typ: 0 },
      { json: 'nombre', js: 'nombre', typ: '' },
      { json: 'sigla', js: 'sigla', typ: u(undefined, '') },
      {
        json: 'hibernateLazyInitializer',
        js: 'hibernateLazyInitializer',
        typ: r('HibernateLazyInitializer'),
      },
    ],
    false
  ),
};
