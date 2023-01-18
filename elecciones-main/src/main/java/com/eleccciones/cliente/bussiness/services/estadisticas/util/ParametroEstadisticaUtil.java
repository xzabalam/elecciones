package com.eleccciones.cliente.bussiness.services.estadisticas.util;

import com.eleccciones.cliente.common.exception.EstadisticaException;

public final class ParametroEstadisticaUtil {
    private ParametroEstadisticaUtil() {
    }

    public static void validarProvincia(Integer idProvincia) {
        if (idProvincia == null) {
            throw new EstadisticaException("El idProvincia es obligatorio para las estadísticas.");
        }
    }

    public static void validarCanton(Integer idCanton) {
        if (idCanton == null) {
            throw new EstadisticaException("El idCanton es obligatorio para las estadísticas.");
        }
    }

    public static void validarParroquia(Integer idParroquia) {
        if (idParroquia == null) {
            throw new EstadisticaException("El idParroquia es obligatorio para las estadísticas.");
        }
    }
}
