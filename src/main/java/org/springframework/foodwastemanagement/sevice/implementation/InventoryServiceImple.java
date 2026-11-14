package org.springframework.foodwastemanagement.sevice.implementation;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVParser;
import org.apache.commons.csv.CSVRecord;
import org.modelmapper.ModelMapper;
import org.springframework.foodwastemanagement.dto.InventoryDto;
import org.springframework.foodwastemanagement.entity.Inventory;
import org.springframework.foodwastemanagement.entity.Users;
import org.springframework.foodwastemanagement.exception.ImportCSVError;
import org.springframework.foodwastemanagement.helper.InventoryCategory;
import org.springframework.foodwastemanagement.repository.InventoryRepository;
import org.springframework.foodwastemanagement.sevice.blueprint.InventoryService;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStreamReader;
import java.io.Reader;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class InventoryServiceImple implements InventoryService {

    private final InventoryRepository inventoryRepository;
    private final ModelMapper modelMapper ;

    @Transactional
    public void addCSV(MultipartFile file, Users currentUser) {
        try (
                Reader reader = new InputStreamReader(
                        file.getInputStream(), StandardCharsets.UTF_8
                );
                CSVParser parser = CSVFormat.DEFAULT.builder()
                        .setHeader()
                        .setSkipHeaderRecord(true)
                        .setTrim(true)
                        .get()
                        .parse(reader)
        ) {
            List<Inventory> inventories = new ArrayList<>();
            for (CSVRecord record : parser) {
                Inventory inventory = new Inventory();
                inventory.setUser(currentUser);
                inventory.setProductName(
                        record.get("productName")
                );
                inventory.setCategory(
                        InventoryCategory.valueOf(
                                record.get("category").toUpperCase()
                        )
                );
                inventory.setQuantity(
                        record.get("quantity")
                );
                inventory.setUnit(
                        record.get("unit")
                );
                inventory.setExpiryDate(
                        LocalDate.parse(record.get("expiryDate"),DateTimeFormatter.ofPattern("dd-MM-yyyy"))
                );
                inventories.add(inventory);
            }
            for (Inventory inventory : inventories) {
                inventory.setBarcode("TEMP-" + UUID.randomUUID());
            }
            List<Inventory> savedInventories = inventoryRepository.saveAll(inventories);
            for(Inventory inventory : savedInventories){
                inventory.setBarcode(String.valueOf("NF-" + inventory.getId()));
            }
            inventoryRepository.saveAll(savedInventories);

        } catch (Exception e) {
            throw new ImportCSVError(
                    "CSV import failed: " + e.getMessage()
            );
        }
    }

    @Override
    public List<InventoryDto> getAllItems() {
        List<Inventory> listOfProducts = inventoryRepository.findAll();
        return listOfProducts.stream().map((element) -> modelMapper.map(element, InventoryDto.class)).toList();
    }

    @Override
    public void addSingleItem(InventoryDto inventoryDto,Users user) {
        inventoryDto.setUser(user);
        inventoryDto.setBarcode("TEMP-" + UUID.randomUUID());
        Inventory inventory = inventoryRepository.save(modelMapper.map(inventoryDto,Inventory.class));
        inventory.setBarcode(String.valueOf("NF-" + inventory.getId()));
        inventoryRepository.save(inventory);
        return;
    }

    @Override
    @Transactional
    public void deleteSIngleItem(UUID id, Users user) {
        inventoryRepository.deleteByIdAndUserId(id,user.getId());
    }

    @Override
    @Transactional
    public void updateSingleItem(UUID id, InventoryDto inventoryDto , Users user) {

        Inventory existingItem = inventoryRepository.findByIdAndUserId(id,user.getId())
                .orElseThrow(() ->
                        new RuntimeException("Inventory item not found"));
        existingItem.setUser(user);
        existingItem.setProductName(inventoryDto.getProductName());
        existingItem.setCategory(inventoryDto.getCategory());
        existingItem.setQuantity(inventoryDto.getQuantity());
        existingItem.setUnit(inventoryDto.getUnit());
        existingItem.setExpiryDate(inventoryDto.getExpiryDate());

        inventoryRepository.save(existingItem);
    }

}
