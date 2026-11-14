package org.springframework.foodwastemanagement.sevice.implementation;

import lombok.RequiredArgsConstructor;
import org.springframework.foodwastemanagement.entity.Inventory;
import org.springframework.foodwastemanagement.helper.EmailTableData;
import org.springframework.foodwastemanagement.repository.AutoSchedulerRepository;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class AutoSchedulerService {

    private final AutoSchedulerRepository autoSchedulerRepository;
    private final EmailService emailService;

    @Scheduled(fixedRate = 20000)
    public void updateScheduledValues() {
        LocalDate today = LocalDate.now();
        List<Inventory> items = autoSchedulerRepository.findAll();
        for (Inventory item : items) {
            long daysLeft = ChronoUnit.DAYS.between(
                    today,
                    item.getExpiryDate()
            );
            item.setDaysLeft(daysLeft);
        }
        autoSchedulerRepository.saveAll(items);
        sendEmailChecks();
    }

    public void sendEmailChecks() {
        System.out.println(">>> sendEmailChecks() REACHED");
        List<UUID> userIds = autoSchedulerRepository.findAllUserIds();
        for (UUID userId : userIds) {
            List<Inventory> inventories =
                    autoSchedulerRepository
                            .findEligibleInventories(userId, 0L, 7L);
            if (inventories.isEmpty()) {
                continue;
            }
            String email = inventories.get(0).getUser().getEmail();
            List<EmailTableData> products = inventories.stream()
                    .map(item -> new EmailTableData(
                            item.getProductName(),
                            item.getDaysLeft()
                    ))
                    .toList();
            try {
                emailService.sendExpiryMail(email, products);
            } catch (Exception e) {
                System.err.println("Email failed for user " + userId
                        + ": " + e.getMessage());
            }
        }
    }
}