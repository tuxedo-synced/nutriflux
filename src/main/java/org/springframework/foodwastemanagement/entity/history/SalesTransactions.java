package org.springframework.foodwastemanagement.entity.history;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Table(name = "SALES_TRANSACTIONS")
@Getter
@Setter
public class SalesTransactions {

    @Id
    @Column(name = "sales_id")
    private String sales_id;

    @Column(name = "pid")
    private String pid;

    @Column(name = "pname")
    private String pname;

    @Column(name = "category")
    private String category;

    @Column(name = "datetime")
    private LocalDateTime datetime;

    @Column(name = "sold_qty")
    private Double sold_qty;

    @Column(name = "units")
    private String units;
}
