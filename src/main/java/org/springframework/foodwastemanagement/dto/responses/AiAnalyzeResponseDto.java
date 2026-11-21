
package org.springframework.foodwastemanagement.dto.responses;

import lombok.Data;
import java.util.List;

@Data
public class AiAnalyzeResponseDto {

    private String productName;
    private String category;
    private String units;
    private String generatedAt;
    private Integer expiryDaysRemaining;

    private DemandForecast demandForecast;
    private WasteRisk wasteRisk;
    private StockRecommendation stockRecommendation;

    @Data
    public static class DemandForecast {
        private List<HistoricalDemand> history;
        private List<PredictedDemand> next7Days;
        private Double dailyAverage;
        private Double weeklyDemand;
        private Double validationMAE;
    }

    @Data
    public static class HistoricalDemand {
        private String date;
        private Double actualDemand;
    }

    @Data
    public static class PredictedDemand {
        private String date;
        private Double predictedDemand;
    }

    @Data
    public static class WasteRisk {
        private Double riskScore;
        private String riskLevel;
        private Double expiryUrgencyScore;
        private Double stockSurplusScore;
        private Double expectedDemandBeforeExpiry;
        private Double estimatedSurplusQuantity;
        private String explanation;
    }

    @Data
    public static class StockRecommendation {
        private Double leadTimeDemand;
        private Double safetyStock;
        private Double targetStock;
        private Double recommendedPurchaseQty;
        private String recommendation;
        private String reason;
    }
}
