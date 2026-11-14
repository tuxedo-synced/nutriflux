package org.springframework.foodwastemanagement.sevice.blueprint;

import org.springframework.foodwastemanagement.dto.InventoryDto;
import org.springframework.foodwastemanagement.entity.Users;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.UUID;

public interface InventoryService {
    public void addCSV(MultipartFile file, Users currentUser);
    public List<InventoryDto> getAllItems();
    public void addSingleItem(InventoryDto inventoryDto,Users user);
    public void deleteSIngleItem(UUID id, Users user);

    void updateSingleItem(UUID id, InventoryDto inventoryDto , Users user);
}
