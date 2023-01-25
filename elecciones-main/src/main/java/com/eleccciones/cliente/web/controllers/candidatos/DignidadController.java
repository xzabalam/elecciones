package com.eleccciones.cliente.web.controllers.candidatos;

import com.eleccciones.cliente.bussiness.services.candidatos.DignidadServicio;
import com.eleccciones.cliente.data.repositories.candidatos.dto.DignidadDTO;
import io.swagger.v3.oas.annotations.Operation;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/dignidad")
public class DignidadController {
    private final DignidadServicio dignidadServicio;

    public DignidadController(DignidadServicio dignidadServicio) {
        this.dignidadServicio = dignidadServicio;
    }


    @GetMapping("/all")
    @Operation(summary = "Obtiene el listado de todas las dignidades configuradas")
    public ResponseEntity<List<DignidadDTO>> getAll() {
        List<DignidadDTO> dignidades = dignidadServicio.getAll();
        return new ResponseEntity<>(dignidades, HttpStatus.OK);
    }
}


