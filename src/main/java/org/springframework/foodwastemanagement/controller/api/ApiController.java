package org.springframework.foodwastemanagement.controller.api;

import lombok.RequiredArgsConstructor;
import org.springframework.foodwastemanagement.entity.present.Inventory;
import org.springframework.foodwastemanagement.repository.ApiRepository;
import org.springframework.foodwastemanagement.sevice.blueprint.ApiService;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequiredArgsConstructor
public class ApiController {

    private final ApiRepository apiRepository;

        private final ApiService apiService;

        @PostMapping("/api/inventory/scan/{barcode}")
        public Map<String, Object> incQtyQr(
                @PathVariable String barcode) {

            Inventory inventory = apiService.incrementQuantity(barcode);

            return Map.of(
                    "message", "Quantity increased successfully",
                    "product", inventory.getProductName(),
                    "quantity", inventory.getQuantity()
            );
        }
    }

