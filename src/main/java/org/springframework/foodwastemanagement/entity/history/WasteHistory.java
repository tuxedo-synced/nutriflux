package org.springframework.foodwastemanagement.entity.history;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Table(name = "WASTE_HISTORY")
@Getter
@Setter
public class WasteHistory {

    @Id
    @Column(name = "waste_id")
    private String waste_id;

    @Column(name = "pid")
    private String pid;

    @Column(name = "pname")
    private String pname;

    @Column(name = "datetime")
    private LocalDateTime datetime;

    @Column(name = "result_qty")
    private Double result_qty;

    @Column(name = "units")
    private String units;

    @Column(name = "waste_reason")
    private String waste_reason;
}