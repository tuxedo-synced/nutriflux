package org.springframework.foodwastemanagement.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.foodwastemanagement.entity.present.Inventory;

import java.util.UUID;

public interface ApiRepository extends JpaRepository<Inventory , UUID> {

}
