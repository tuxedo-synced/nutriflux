package org.springframework.foodwastemanagement.dto.responses;

import lombok.Data;

import java.util.List;

@Data
public class PredictionResponse {

    private List<ProductResponseDto> products;
    private int count;

    public List<String> getProductsList() {
        return products == null
                ? List.of()
                : products.stream()
                .map(ProductResponseDto::getProductName)
                .toList();
    }

}

