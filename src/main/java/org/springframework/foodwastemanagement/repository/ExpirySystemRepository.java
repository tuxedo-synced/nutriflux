package org.springframework.foodwastemanagement.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.foodwastemanagement.entity.present.Inventory;

import java.util.List;
import java.util.UUID;

public interface ExpirySystemRepository extends JpaRepository<Inventory , UUID> {

    @Query(value = """
    SELECT *
    FROM INVENTORY
    ORDER BY DAYS_LEFT ASC
    """, nativeQuery = true)
    List<Inventory> findAllOrderByExpiryDifference();

    @Query(value = """
    SELECT *
    FROM INVENTORY
    WHERE DAYS_LEFT < 3
    ORDER BY DAYS_LEFT ASC 
    """, nativeQuery = true)
    List<Inventory> findExpiredAndCriticalItems();

}
