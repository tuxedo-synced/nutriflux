package org.springframework.foodwastemanagement.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import org.springframework.foodwastemanagement.helper.InventoryCategory;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.UUID;

@Entity
@RequiredArgsConstructor
@Getter
@Setter
@Table(name = "inventory")
public class Inventory {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(
            name = "userId",
            referencedColumnName = "id",
            nullable = false
    )
    private Users user;

    private String productName;

    @Enumerated(EnumType.STRING)
    private InventoryCategory category;

    private String quantity;

    private String unit;

    private LocalDate expiryDate;

    @Column(nullable = false, unique = true)
    private String barcode;

    private long daysLeft ;

    @PrePersist
    @PreUpdate
    public void updateDaysLeft() {
        if (expiryDate == null) {
            daysLeft = 0 ;
        }
        else {
            daysLeft = ChronoUnit.DAYS.between(
                    LocalDate.now(),
                    expiryDate
            );
        }
    }
}