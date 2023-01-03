package com.eleccciones.cliente.web.controllers.ubicacion;

import com.eleccciones.cliente.bussiness.services.ubicacion.PaisService;
import com.eleccciones.cliente.data.entities.ubicacion.Pais;
import com.eleccciones.cliente.web.util.RestPreconditions;
import io.swagger.v3.oas.annotations.Operation;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/pais")
public class PaisController {
    private final PaisService paisService;

    public PaisController(PaisService paisService) {
        this.paisService = paisService;
    }

    @GetMapping()
    @Operation(summary = "Permite obtener todos los paises con paginacion.")
    public ResponseEntity<Page<Pais>> getAllWithPagination(
            @RequestParam(required = false, value = "page", defaultValue = "0") int page,
            @RequestParam(required = false, value = "size", defaultValue = "500") int size
    ) {
        Page<Pais> paises = paisService.getAll(page, size);
        return new ResponseEntity<>(paises, HttpStatus.OK);
    }

    @GetMapping("/all")
    @Operation(summary = "Permite obtener todos los paises.")
    public ResponseEntity<List<Pais>> getAll() {
        List<Pais> paises = paisService.getAll();
        return new ResponseEntity<>(paises, HttpStatus.OK);
    }

    @GetMapping("/{idPais}")
    @Operation(summary = "Permite obtener un pais por su id")
    public ResponseEntity<Pais> getById(@PathVariable("idPais") Integer idPais) {
        RestPreconditions.checkNull(idPais);
        Pais pais = paisService.findById(idPais);
        return new ResponseEntity<>(pais, HttpStatus.OK);
    }
}
