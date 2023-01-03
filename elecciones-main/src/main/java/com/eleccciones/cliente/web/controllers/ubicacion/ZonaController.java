package com.eleccciones.cliente.web.controllers.ubicacion;

import com.eleccciones.cliente.bussiness.services.ubicacion.ZonaService;
import com.eleccciones.cliente.data.entities.ubicacion.Zona;
import com.eleccciones.cliente.web.util.RestPreconditions;
import io.swagger.v3.oas.annotations.Operation;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/zona")
public class ZonaController {
    private final ZonaService zonaService;

    public ZonaController(ZonaService zonaService) {
        this.zonaService = zonaService;
    }

    @GetMapping("/{idZona}")
    @Operation(summary = "Permite obtener la zona con base en su id.")
    public ResponseEntity<Zona> getById(@PathVariable("idZona") Integer idZona) {
        RestPreconditions.checkNull(idZona);
        Zona zona = zonaService.findById(idZona);
        return new ResponseEntity<>(zona, HttpStatus.OK);
    }

    @GetMapping("/parroquia/{idParroquia}/all")
    @Operation(summary = "Permite obtener las zonas de una parroquia dada.")
    public ResponseEntity<List<Zona>> getAllByIdParroquia(@PathVariable("idParroquia") Integer idParroquia) {
        RestPreconditions.checkNull(idParroquia);
        List<Zona> parroquias = zonaService.findByParroquiaAndEstado(idParroquia);
        return new ResponseEntity<>(parroquias, HttpStatus.OK);
    }

    @GetMapping("/parroquia/{idParroquia}")
    @Operation(summary = "Permite obtener las zonas de una parroquia dada y utilizando paginacion.")
    public ResponseEntity<Page<Zona>> getAllByIdParroquiaWithPagination(
            @PathVariable("idParroquia") Integer idParroquia,
            @RequestParam(required = false, value = "page", defaultValue = "0") int page,
            @RequestParam(required = false, value = "size", defaultValue = "500") int size) {
        RestPreconditions.checkNull(idParroquia);
        Page<Zona> parroquias = zonaService.findAllByParroquiaAndEstado(idParroquia, page, size);
        return new ResponseEntity<>(parroquias, HttpStatus.OK);
    }
}
