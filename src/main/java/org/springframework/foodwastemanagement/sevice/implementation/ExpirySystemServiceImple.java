package org.springframework.foodwastemanagement.sevice.implementation;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Sort;
import org.springframework.foodwastemanagement.entity.Inventory;
import org.springframework.foodwastemanagement.repository.ExpirySystemRepository;
import org.springframework.foodwastemanagement.sevice.blueprint.ExpirySystemService;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ExpirySystemServiceImple implements ExpirySystemService {

    private final ExpirySystemRepository expirySystemRepository ;

    @Override
    public List<Inventory> getCriticalExpiryData() {
        return expirySystemRepository.findAllOrderByExpiryDifference();
    }

    @Override
    public List<Inventory> getPrioritizedItemsList() {
        return expirySystemRepository.findExpiredAndCriticalItems();
    }

    @Override
    public List<Inventory> getAllData() {
        return expirySystemRepository.findAll();
    }

    @Override
    public List<Integer> getCounts(List<Inventory> allItems) {
        List<Integer> counts = new ArrayList<>(5);
        int expiredItems = 0, expiringToday = 0, criticalItems = 0, expiringSoon = 0,totalCount = 0;
        for (Inventory item : allItems) {
            int days = (int) item.getDaysLeft();
            if (days < 0) {
                expiredItems++;
            } else if (days == 0) {
                expiringToday++;
            } else if (days >= 1 && days <= 3) {
                criticalItems++;
            } else if (days >= 4 && days <= 7) {
                expiringSoon++;
            }
            totalCount+=1;
        }
        counts.add(expiredItems);
        counts.add(expiringToday);
        counts.add(criticalItems);
        counts.add(expiringSoon);
        counts.add(totalCount);
        return counts;
    }

}
