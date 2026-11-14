package org.springframework.foodwastemanagement.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.foodwastemanagement.entity.Inventory;

import java.util.Optional;
import java.util.UUID;

public interface InventoryRepository extends JpaRepository<Inventory, UUID> {
    void deleteByIdAndUserId(UUID id, UUID id1);

    Optional<Inventory> findByIdAndUserId(UUID id, UUID id1);

    Optional<Inventory> findByBarcode(String barcode);
}
