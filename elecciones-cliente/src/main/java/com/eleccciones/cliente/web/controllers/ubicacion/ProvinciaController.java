package com.eleccciones.cliente.web.controllers.ubicacion;

import com.eleccciones.cliente.bussiness.services.ubicacion.ProvinciaService;
import com.eleccciones.cliente.data.entities.ubicacion.Provincia;
import com.eleccciones.cliente.web.util.RestPreconditions;
import io.swagger.v3.oas.annotations.Operation;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/provincia")
public class ProvinciaController {
    private final ProvinciaService provinciaService;

    public ProvinciaController(ProvinciaService provinciaService) {
        this.provinciaService = provinciaService;
    }

    @GetMapping("/{idProvincia}")
    @Operation(summary = "Permite obtener una provincia dado su id.")
    public ResponseEntity<Provincia> getById(@PathVariable("idProvincia") Integer idProvincia) {
        RestPreconditions.checkNull(idProvincia);
        Provincia provincia = provinciaService.findById(idProvincia);
        return new ResponseEntity<>(provincia, HttpStatus.OK);
    }

    @GetMapping("/pais/{idPais}/all")
    @Operation(summary = "Permite obtener el listado de provincias, dada el id del pais")
    public ResponseEntity<List<Provincia>> getAllByIdPais(@PathVariable("idPais") Integer idPais) {
        RestPreconditions.checkNull(idPais);
        List<Provincia> provincias = provinciaService.findByPaisAndEstado(idPais);
        return new ResponseEntity<>(provincias, HttpStatus.OK);
    }

    @GetMapping("/pais/{idPais}")
    @Operation(summary = "Permite obtener el listado de provincias, dado el id del pais con paginacion.")
    public ResponseEntity<Page<Provincia>> getAllByIdPaisWithPagination(
            @PathVariable("idPais") Integer idPais,
            @RequestParam(value = "page", required = false, defaultValue = "0") int page,
            @RequestParam(value = "size", required = false, defaultValue = "500") int size) {
        RestPreconditions.checkNull(idPais);
        Page<Provincia> provincias = provinciaService.findAllByPaisAndEstado(idPais, page, size);
        return new ResponseEntity<>(provincias, HttpStatus.OK);
    }
}
