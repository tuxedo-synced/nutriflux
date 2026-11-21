package org.springframework.foodwastemanagement.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.foodwastemanagement.dto.UsersDto;
import org.springframework.foodwastemanagement.dto.responses.AiAnalyzeResponseDto;
import org.springframework.foodwastemanagement.dto.responses.PredictionResponse;
import org.springframework.foodwastemanagement.entity.present.Inventory;
import org.springframework.foodwastemanagement.entity.present.Users;
import org.springframework.foodwastemanagement.sevice.blueprint.PredictService;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class AiPredictionController {

    private final PredictService predictService ;

    @GetMapping("/ai-prediction")
    public String aiPrediction(Model model) {
        PredictionResponse listOfProductNames = predictService.getAllProductNames();
        model.addAttribute("listOfProductNames",listOfProductNames.getProductsList());
        return "ai-prediction";
    }

    @PostMapping("/ai-prediction/analyze")
    public String analyze(
            @AuthenticationPrincipal Users user,
            @RequestParam("productName") String productName,
            RedirectAttributes redirectAttributes) {
        AiAnalyzeResponseDto aiAnalyzeResponseDto =
                predictService.getCurrentProductsDetails(
                        user.getId(), productName);
        redirectAttributes.addFlashAttribute("GraphPlot", aiAnalyzeResponseDto);
        redirectAttributes.addFlashAttribute("selectedProductName", productName);
        return "redirect:/ai-prediction";
    }

    @GetMapping("/ai-prediction/refresh")
    public String refresh(){
        return "redirect:/ai-prediction";
    }


}
