package org.springframework.foodwastemanagement.controller;

import lombok.RequiredArgsConstructor;
import org.eclipse.tags.shaded.org.apache.xpath.operations.Mod;
import org.springframework.foodwastemanagement.entity.Inventory;
import org.springframework.foodwastemanagement.sevice.blueprint.ExpirySystemService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class ExpiryTrackingController {

    private final ExpirySystemService expirySystemService ;

    @GetMapping("/expiry")
    public String expiryTracking(Model model){
        List<Inventory> inventoryExpiryList = expirySystemService.getCriticalExpiryData();
        model.addAttribute("expiryItems",inventoryExpiryList);
        List<Inventory> priorityItems = expirySystemService.getPrioritizedItemsList();
        model.addAttribute("priorityItems",priorityItems);
        List<Inventory> allItems = expirySystemService.getAllData();
        int expiredItems, expiringToday, criticalItems, expiringSoon, totalItems;
        List<Integer> allCounts = expirySystemService.getCounts(allItems);
        expiredItems = allCounts.get(0);
        expiringToday = allCounts.get(1);
        criticalItems = allCounts.get(2);
        expiringSoon = allCounts.get(3);
        totalItems = allCounts.get(4);
        model.addAttribute("expiredItems",expiredItems);
        model.addAttribute("expiringToday",expiringToday);
        model.addAttribute("criticalItems",criticalItems);
        model.addAttribute("expiringSoon",expiringSoon);
        model.addAttribute("totalItems",totalItems);
        return "expiry-tracking";
    }

}
