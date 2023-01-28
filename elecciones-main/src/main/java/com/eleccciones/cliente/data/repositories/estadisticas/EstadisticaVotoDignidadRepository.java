package com.eleccciones.cliente.data.repositories.estadisticas;

import com.eleccciones.cliente.data.entities.estadisticas.EstadisticaVotoDignidad;
import com.eleccciones.cliente.data.entities.estadisticas.dto.EstadisticaDTO;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EstadisticaVotoDignidadRepository extends JpaRepository<EstadisticaVotoDignidad, Integer> {

    // Consulta de prefectos pro provincia
    @Query("select" +
            "   new  com.eleccciones.cliente.data.entities.estadisticas.dto.EstadisticaDTO(" +
            "       e.idMovimiento, e.movimiento, e.numeroMovimiento, e.colorMovimiento, e.nombreCandidato, sum(e" +
            ".cantidadVoto)" +
            "   ) " +
            "from EstadisticaVotoDignidad e " +
            "where e.idProvincia = :idProvincia and e.idDignidad = 2  and e.estado != 'D' " +
            "group by e.idMovimiento, e.movimiento, e.colorMovimiento, e.nombreCandidato, e.numeroMovimiento")
    List<EstadisticaDTO> getPrefectosPorProvincia(@Param("idProvincia") Integer idProvincia);

    // Consulta de ALCALDE y filtrado por provincia
    @Query("select" +
            "   new  com.eleccciones.cliente.data.entities.estadisticas.dto.EstadisticaDTO(" +
            "       e.idMovimiento, e.movimiento, e.numeroMovimiento, e.colorMovimiento, e.nombreCandidato, sum(e" +
            ".cantidadVoto)" +
            "   ) " +
            "from EstadisticaVotoDignidad e " +
            "where e.idProvincia = :idProvincia and e.idDignidad = 3  and e.estado != 'D' " +
            "group by e.idMovimiento, e.movimiento, e.colorMovimiento, e.nombreCandidato, e.numeroMovimiento")
    List<EstadisticaDTO> getAlcaldesPorProvincia(@Param("idProvincia") Integer idProvincia);

    // Consulta de ALCALDE y filtrado por provincia y por canton
    @Query("select" +
            "   new  com.eleccciones.cliente.data.entities.estadisticas.dto.EstadisticaDTO(" +
            "       e.idMovimiento, e.movimiento, e.numeroMovimiento, e.colorMovimiento, e.nombreCandidato, sum(e" +
            ".cantidadVoto)" +
            "   ) " +
            "from EstadisticaVotoDignidad e " +
            "where e.idProvincia = :idProvincia and e.idCanton = :idCanton and e.idDignidad = 3  and e.estado != 'D' " +
            "group by e.idMovimiento, e.movimiento, e.colorMovimiento, e.nombreCandidato, e.numeroMovimiento")
    List<EstadisticaDTO> getAlcaldesPorProvinciaYCanton(@Param("idProvincia") Integer idProvincia,
                                                        @Param("idCanton") Integer idCanton);

    // Consulta de CONCEJALES URBANOS y filtrado por provincia
    @Query("select" +
            "   new  com.eleccciones.cliente.data.entities.estadisticas.dto.EstadisticaDTO(" +
            "       e.idMovimiento, e.movimiento, e.numeroMovimiento, e.colorMovimiento, e.nombreCandidato, sum(e" +
            ".cantidadVoto)" +
            "   ) " +
            "from EstadisticaVotoDignidad e " +
            "where e.idProvincia = :idProvincia and e.idDignidad = 4 and e.estado != 'D' " +
            "group by e.idMovimiento, e.movimiento, e.colorMovimiento, e.nombreCandidato, e.numeroMovimiento")
    List<EstadisticaDTO> getConcejalesUrbanosPorProvincia(@Param("idProvincia") Integer idProvincia);

    // Consulta de CONCEJALES URBANOS y filtrado por provincia y canton
    @Query("select" +
            "   new  com.eleccciones.cliente.data.entities.estadisticas.dto.EstadisticaDTO(" +
            "       e.idMovimiento, e.movimiento, e.numeroMovimiento, e.colorMovimiento, e.nombreCandidato, sum(e" +
            ".cantidadVoto)" +
            "   ) " +
            "from EstadisticaVotoDignidad e " +
            "where e.idProvincia = :idProvincia and e.idCanton = :idCanton and e.idDignidad = 4  and e.estado != 'D' " +
            "group by e.idMovimiento, e.movimiento, e.colorMovimiento, e.nombreCandidato, e.numeroMovimiento")
    List<EstadisticaDTO> getConcejalesUrbanosPorProvinciaYCanton(@Param("idProvincia") Integer idProvincia,
                                                                 @Param("idCanton") Integer idCanton);

    // Consulta de CONCEJALES RURALES y filtrado por provincia
    @Query("select" +
            "   new  com.eleccciones.cliente.data.entities.estadisticas.dto.EstadisticaDTO(" +
            "       e.idMovimiento, e.movimiento, e.numeroMovimiento, e.colorMovimiento, e.nombreCandidato, sum(e" +
            ".cantidadVoto)" +
            "   ) " +
            "from EstadisticaVotoDignidad e " +
            "where e.idProvincia = :idProvincia and e.idDignidad = 5 and e.estado != 'D' " +
            "group by e.idMovimiento, e.movimiento, e.colorMovimiento, e.nombreCandidato, e.numeroMovimiento")
    List<EstadisticaDTO> getConcejalesRuralesPorProvincia(@Param("idProvincia") Integer idProvincia);

    // Consulta de CONCEJALES RURALES y filtrado por provincia y canton
    @Query("select" +
            "   new  com.eleccciones.cliente.data.entities.estadisticas.dto.EstadisticaDTO(" +
            "       e.idMovimiento, e.movimiento, e.numeroMovimiento, e.colorMovimiento, e.nombreCandidato, sum(e" +
            ".cantidadVoto)" +
            "   ) " +
            "from EstadisticaVotoDignidad e " +
            "where e.idProvincia = :idProvincia and e.idCanton = :idCanton and e.idDignidad = 5  and e.estado != 'D' " +
            "group by e.idMovimiento, e.movimiento, e.colorMovimiento, e.nombreCandidato, e.numeroMovimiento")
    List<EstadisticaDTO> getConcejalesRuralesPorProvinciaYCanton(@Param("idProvincia") Integer idProvincia,
                                                                 @Param("idCanton") Integer idCanton);

    // Consulta de VOCALES DE JUNTAS PARROQUIALES y filtrado por provincia
    @Query("select" +
            "   new  com.eleccciones.cliente.data.entities.estadisticas.dto.EstadisticaDTO(" +
            "       e.idMovimiento, e.movimiento, e.numeroMovimiento, e.colorMovimiento, e.nombreCandidato, sum(e" +
            ".cantidadVoto)" +
            "   ) " +
            "from EstadisticaVotoDignidad e " +
            "where e.idProvincia = :idProvincia and e.idDignidad = 6  and e.estado != 'D' " +
            "group by e.idMovimiento, e.movimiento, e.colorMovimiento, e.nombreCandidato, e.numeroMovimiento")
    List<EstadisticaDTO> getVocalesJuntasParroquialesPorProvincia(@Param("idProvincia") Integer idProvincia);

    // Consulta de VOCALES DE JUNTAS PARROQUIALES y filtrado por provincia y canton
    @Query("select" +
            "   new  com.eleccciones.cliente.data.entities.estadisticas.dto.EstadisticaDTO(" +
            "       e.idMovimiento, e.movimiento, e.numeroMovimiento, e.colorMovimiento, e.nombreCandidato, sum(e" +
            ".cantidadVoto)" +
            "   ) " +
            "from EstadisticaVotoDignidad e " +
            "where e.idProvincia = :idProvincia and e.idCanton = :idCanton and e.idDignidad = 6  and e.estado != 'D' " +
            "group by e.idMovimiento, e.movimiento, e.colorMovimiento, e.nombreCandidato, e.numeroMovimiento")
    List<EstadisticaDTO> getVocalesJuntasParroquialesPorProvinciaYCanton(@Param("idProvincia") Integer idProvincia,
                                                                         @Param("idCanton") Integer idCanton);

    // Consulta de VOCALES DE JUNTAS PARROQUIALES y filtrado por provincia, canton y parroquia
    @Query("select" +
            "   new  com.eleccciones.cliente.data.entities.estadisticas.dto.EstadisticaDTO(" +
            "       e.idMovimiento, e.movimiento, e.numeroMovimiento, e.colorMovimiento, e.nombreCandidato, sum(e" +
            ".cantidadVoto)" +
            "   ) " +
            "from EstadisticaVotoDignidad e " +
            "where " +
            "       e.idProvincia = :idProvincia " +
            "   and e.idCanton = :idCanton " +
            "   and e.idParroquia = :idParroquia " +
            "   and e.idDignidad = 6" +
            "   and e.estado != 'D' " +
            "group by e.idMovimiento, e.movimiento, e.colorMovimiento, e.nombreCandidato, e.numeroMovimiento")
    List<EstadisticaDTO> getVocalesJuntasParroquialesPorProvinciaYCantonYParroquia(@Param("idProvincia") Integer idProvincia,
                                                                                   @Param("idCanton") Integer idCanton,
                                                                                   @Param("idParroquia") Integer idParroquia);
}
