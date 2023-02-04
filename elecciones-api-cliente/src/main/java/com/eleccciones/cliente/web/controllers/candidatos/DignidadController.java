package com.eleccciones.cliente.web.controllers.candidatos;

import com.eleccciones.cliente.bussiness.services.candidatos.DignidadServicio;
import com.eleccciones.cliente.data.repositories.candidatos.dto.DignidadDTO;
import com.eleccciones.cliente.web.util.RestPreconditions;
import io.swagger.v3.oas.annotations.Operation;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Positive;
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

    @GetMapping("/contrato/{idContrato}")
    @Operation(summary = "Obtiene el listado de todas las dignidades configuradas por contrato")
    public ResponseEntity<List<DignidadDTO>> obtenerPorContrato(@Valid @NotNull @Positive @PathVariable("idContrato") Integer idContrato) {
        RestPreconditions.checkNull(idContrato);
        List<DignidadDTO> dignidades = dignidadServicio.obtenerPorContrato(idContrato);
        return new ResponseEntity<>(dignidades, HttpStatus.OK);
    }
}


