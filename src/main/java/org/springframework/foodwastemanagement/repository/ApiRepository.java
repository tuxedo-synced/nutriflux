package org.springframework.foodwastemanagement.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.foodwastemanagement.entity.Inventory;

import java.util.List;
import java.util.UUID;

public interface ApiRepository extends JpaRepository<Inventory , UUID> {

}
