package org.springframework.foodwastemanagement.sevice.implementation;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.foodwastemanagement.entity.Inventory;
import org.springframework.foodwastemanagement.repository.InventoryRepository;
import org.springframework.foodwastemanagement.sevice.blueprint.ApiService;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ApiServiceImple implements ApiService {

    private final InventoryRepository inventoryRepository;

    @Override
    @Transactional
    public Inventory incrementQuantity(String barcode) {

        Inventory inventory = inventoryRepository
                .findByBarcode(barcode)
                .orElseThrow(() ->
                        new RuntimeException("Inventory item not found"));

        inventory.setQuantity(String.valueOf(Integer.parseInt(inventory.getQuantity()) + 1));

        return inventoryRepository.save(inventory);
    }
}
