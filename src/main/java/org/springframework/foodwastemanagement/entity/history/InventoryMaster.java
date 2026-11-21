package org.springframework.foodwastemanagement.entity.history;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Entity
@Table(name = "INVENTORY_MASTER")
@Getter
@Setter
public class InventoryMaster {

    @Id
    @Column(name = "pid")
    private String pid;

    @Column(name = "pname")
    private String pname;

    @Column(name = "category")
    private String category;

    @Column(name = "qty")
    private Double qty;

    @Column(name = "units")
    private String units;

    @Column(name = "expirydate")
    private LocalDate expirydate;

    @Column(name = "status")
    private String status;
}
