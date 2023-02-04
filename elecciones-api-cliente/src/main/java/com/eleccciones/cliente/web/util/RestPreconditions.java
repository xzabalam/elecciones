package com.eleccciones.cliente.web.util;

import com.eleccciones.cliente.web.exceptions.MyResourceNotFoundException;

public final class RestPreconditions {
    private RestPreconditions() {
        throw new AssertionError();
    }

    /**
     * Check if some value exist, otherwise throw exception.
     *
     * @param resource has value not null to be returned, otherwise throw exception
     * @throws MyResourceNotFoundException if resource is null, means value not found.
     */
    public static <T> T checkNull(final T resource) {
        if (resource == null) {
            throw new MyResourceNotFoundException("El parámetro de entrada no puede ser nulo.");
        }

        return resource;
    }

    public static <T> T checkEmptyString(final T resource) {
        checkNull(resource);

        if (resource instanceof String) {
            if (((String) resource).trim().isEmpty()) {
                throw new MyResourceNotFoundException("Se esperaba un valor.");
            }
        }

        return resource;
    }
}
