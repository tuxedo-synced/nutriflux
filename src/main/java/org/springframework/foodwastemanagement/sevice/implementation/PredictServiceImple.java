package org.springframework.foodwastemanagement.sevice.implementation;

import lombok.RequiredArgsConstructor;
import org.springframework.foodwastemanagement.dto.responses.AIAnalyzeRequestDto;
import org.springframework.foodwastemanagement.dto.responses.AiAnalyzeResponseDto;
import org.springframework.foodwastemanagement.dto.responses.PredictionResponse;
import org.springframework.foodwastemanagement.entity.present.Inventory;
import org.springframework.foodwastemanagement.repository.AiPredictRepository;
import org.springframework.foodwastemanagement.sevice.blueprint.PredictService;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestClient;
import org.springframework.web.client.RestClientResponseException;
import tools.jackson.databind.ObjectMapper;

import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.util.List;
import java.util.Objects;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class PredictServiceImple implements PredictService {

    private final RestClient restClient;
    private final AiPredictRepository aiPredictRepository;

    @Override
    public PredictionResponse getAllProductNames() {
        return restClient.get()
                .uri("/api/v1/ai/products")
                .accept(MediaType.APPLICATION_JSON)
                .retrieve()
                .body(PredictionResponse.class);
    }


    @Override
    public AiAnalyzeResponseDto getCurrentProductsDetails(
            UUID userId, String productName) {

        List<Inventory> products =
                aiPredictRepository
                        .findByUser_IdAndProductNameIgnoreCase(userId,productName);

        AIAnalyzeRequestDto request = new AIAnalyzeRequestDto();

        request.setProductName(productName);

        int totalStock = 0;
        LocalDate expiryDate = null;

        if (products != null && !products.isEmpty()) {

            totalStock = products.stream()
                    .mapToInt(inventory ->
                            Integer.parseInt(inventory.getQuantity()))
                    .sum();

            expiryDate = products.stream()
                    .map(Inventory::getExpiryDate)
                    .filter(Objects::nonNull)
                    .min(LocalDate::compareTo)
                    .orElse(null);
        }

        request.setCurrentStock(totalStock);
        request.setExpiryDate(expiryDate);

        System.out.println("Product: " + request.getProductName());
        System.out.println("Stock: " + request.getCurrentStock());
        System.out.println("Expiry: " + request.getExpiryDate());
        System.out.println("Sending request: " + request);
        return restClient.post()
                .uri("/api/v1/ai/analyze")
                .contentType(MediaType.APPLICATION_JSON)
                .accept(MediaType.APPLICATION_JSON)
                .body(request)
                .retrieve()
                .body(AiAnalyzeResponseDto.class);
    }

}
