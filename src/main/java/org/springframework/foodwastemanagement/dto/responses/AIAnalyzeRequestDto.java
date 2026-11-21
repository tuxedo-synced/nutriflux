package org.springframework.foodwastemanagement.dto.responses;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@NoArgsConstructor
public class AIAnalyzeRequestDto {

    private String productName;

    private double currentStock;

    private LocalDate expiryDate;

    private int leadTimeDays = 7;   // Default value

    private int safetyDays = 7;     // Default value
}
