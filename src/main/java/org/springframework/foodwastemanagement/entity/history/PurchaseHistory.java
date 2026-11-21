package org.springframework.foodwastemanagement.entity.history;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Table(name = "PURCHASE_HISTORY")
@Getter
@Setter
public class PurchaseHistory {

    @Id
    @Column(name = "purchase_id")
    private String purchase_id;

    @Column(name = "pid")
    private String pid;

    @Column(name = "pname")
    private String pname;

    @Column(name = "datetime")
    private LocalDateTime datetime;

    @Column(name = "purchased_qty")
    private Double purchased_qty;

    @Column(name = "units")
    private String units;
}
