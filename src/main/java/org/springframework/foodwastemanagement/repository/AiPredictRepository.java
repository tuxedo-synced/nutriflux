package org.springframework.foodwastemanagement.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.foodwastemanagement.entity.present.Inventory;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface AiPredictRepository extends JpaRepository<Inventory , UUID> {
    List<Inventory> findByUser_IdAndProductNameIgnoreCase(
            UUID userId,
            String productName
    );
}
