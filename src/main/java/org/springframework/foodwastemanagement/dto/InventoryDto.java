package org.springframework.foodwastemanagement.dto;

import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.foodwastemanagement.entity.Users;
import org.springframework.foodwastemanagement.helper.InventoryCategory;

import java.time.LocalDate;
import java.util.UUID;

@Data
@RequiredArgsConstructor
public class InventoryDto {
    public UUID id ;
    public Users user ;
    public String productName ;
    public InventoryCategory category ;
    public String quantity ;
    public String unit ;
    public LocalDate expiryDate ;
    public long daysLeft ;
    private String barcode ;
}
