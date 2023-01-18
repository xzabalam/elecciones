package com.eleccciones.cliente.data.repositories.estadisticas;

import com.eleccciones.cliente.data.entities.estadisticas.dto.NumeroElectoresDTO;
import com.eleccciones.cliente.data.repositories.ubicacion.RecintoRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface NumeroElectoresRepository extends RecintoRepository {

    @Query("select new com.eleccciones.cliente.data.entities.estadisticas.dto.NumeroElectoresDTO(" +
            "   p.id, p.nombre, sum(r.electoresTotal) " +
            ") from Recinto r " +
            "join r.zona z " +
            "join z.parroquia pr " +
            "join pr.canton c " +
            "join c.provincia p " +
            "where p.id = :idProvincia " +
            "   and p.estado != 'D' and c.estado != 'D' and pr.estado != 'D'" +
            "   and z.estado != 'D' and r.estado != 'D' " +
            "group by p.id, p.nombre ")
    NumeroElectoresDTO getByProvincia(@Param("idProvincia") Integer idProvincia);

    @Query("select new com.eleccciones.cliente.data.entities.estadisticas.dto.NumeroElectoresDTO(" +
            "   c.id, c.nombre, sum(r.electoresTotal) " +
            ") from Recinto r " +
            "join r.zona z " +
            "join z.parroquia pr " +
            "join pr.canton c " +
            "join c.provincia p " +
            "where p.id = :idProvincia and c.id = :idCanton " +
            "   and p.estado != 'D' and c.estado != 'D' and pr.estado != 'D'" +
            "   and z.estado != 'D' and r.estado != 'D' " +
            "group by c.id, c.nombre ")
    NumeroElectoresDTO getByProvinciaAndCanton(@Param("idProvincia") Integer idProvincia,
                                               @Param("idCanton") Integer idCanton);

    @Query("select new com.eleccciones.cliente.data.entities.estadisticas.dto.NumeroElectoresDTO(" +
            "   pr.id, pr.nombre, sum(r.electoresTotal) " +
            ") from Recinto r " +
            "join r.zona z " +
            "join z.parroquia pr " +
            "join pr.canton c " +
            "join c.provincia p " +
            "where p.id = :idProvincia and c.id = :idCanton and pr.id = :idParroquia " +
            "   and p.estado != 'D' and c.estado != 'D' and pr.estado != 'D'" +
            "   and z.estado != 'D' and r.estado != 'D' " +
            "group by pr.id, pr.nombre ")
    NumeroElectoresDTO getByProvinciaAndCantonAndParroquia(@Param("idProvincia") Integer idProvincia,
                                                           @Param("idCanton") Integer idCanton,
                                                           @Param("idParroquia") Integer idParroquia);
}
