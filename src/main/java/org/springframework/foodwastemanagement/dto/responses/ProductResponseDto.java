package org.springframework.foodwastemanagement.dto.responses;

import lombok.Data;

@Data
public class ProductResponseDto {
    private String productName ;
    private String category;
    private String units;
}
