package org.springframework.foodwastemanagement.controller;

import lombok.RequiredArgsConstructor;
import net.minidev.json.JSONUtil;
import org.springframework.foodwastemanagement.dto.InventoryDto;
import org.springframework.foodwastemanagement.entity.Users;
import org.springframework.foodwastemanagement.exception.ImportCSVError;
import org.springframework.foodwastemanagement.sevice.blueprint.InventoryService;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Controller
@RequiredArgsConstructor
public class InventoryController {

    private final InventoryService inventoryService ;
    private List<InventoryDto> listOfProducts;

    @GetMapping("/inventory")
    public String inventory(
            @AuthenticationPrincipal Users currentUser,
            Model model) {

        model.addAttribute(
                "listOfProducts",
                inventoryService.getAllItems()
        );

        return "inventory";
    }

    @PostMapping("/inventory/import")
    public String importCSV(
            @RequestParam("file") MultipartFile file,
            @AuthenticationPrincipal Users currentUser,
            Model model) {
        if (file.isEmpty()) {
            model.addAttribute("error", "Please select a CSV file");
            model.addAttribute("listOfProducts", inventoryService.getAllItems());
            return "inventory";
        }
        try {
            inventoryService.addCSV(file, currentUser);
            model.addAttribute(
                    "success", "Inventory imported successfully!"
            );
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", e.getMessage());
        }
        model.addAttribute("listOfProducts", inventoryService.getAllItems());
        return "inventory";
    }

    @PostMapping("/inventory/create")
    public String addProduct(@ModelAttribute InventoryDto inventoryDto , @AuthenticationPrincipal Users user){
        inventoryService.addSingleItem(inventoryDto,user);
        return "redirect:/inventory";
    }

    @PostMapping("inventory/delete/{id}")
    public String deleteProduct(@PathVariable("id") UUID id , @AuthenticationPrincipal Users user){
        inventoryService.deleteSIngleItem(id,user);
        return "redirect:/inventory";
    }

    @PostMapping("inventory/update/{id}")
    public String updateProduct(@PathVariable("id") UUID id ,
                                @ModelAttribute InventoryDto inventoryDto,
                                @AuthenticationPrincipal Users user){
        inventoryService.updateSingleItem(id,inventoryDto,user);
        return "redirect:/inventory";
    }

    @GetMapping("/scanner")
    public String scanner() {
        return "scanner";
    }


}
