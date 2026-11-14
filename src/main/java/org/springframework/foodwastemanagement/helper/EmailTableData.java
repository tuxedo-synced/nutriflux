package org.springframework.foodwastemanagement.helper;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class EmailTableData {
    String productName ;
    long daysLeft ;
}
