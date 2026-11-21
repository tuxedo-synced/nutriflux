package org.springframework.foodwastemanagement.sevice.blueprint;

import org.springframework.foodwastemanagement.dto.responses.AiAnalyzeResponseDto;
import org.springframework.foodwastemanagement.dto.responses.PredictionResponse;
import org.springframework.foodwastemanagement.entity.present.Inventory;

import java.util.UUID;

public interface PredictService {
    PredictionResponse getAllProductNames();

    AiAnalyzeResponseDto getCurrentProductsDetails(UUID id, String productName);
}
