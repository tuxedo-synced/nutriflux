package org.springframework.foodwastemanagement.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.foodwastemanagement.entity.Inventory;

import java.util.List;
import java.util.UUID;

public interface AutoSchedulerRepository
        extends JpaRepository<Inventory, UUID> {

    @Query("SELECT DISTINCT i.user.id FROM Inventory i")
    List<UUID> findAllUserIds();

    @Query("""
    SELECT i FROM Inventory i
    JOIN FETCH i.user
    WHERE i.user.id = :userId
    AND i.daysLeft BETWEEN :min AND :max
    """)
    List<Inventory> findEligibleInventories(
            @Param("userId") UUID userId,
            @Param("min") Long min,
            @Param("max") Long max
    );
}
