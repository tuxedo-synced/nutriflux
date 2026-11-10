package org.springframework.foodwastemanagement.security.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.foodwastemanagement.entity.Users;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface UsersRepository extends JpaRepository<Users, UUID> {
    public Optional<Users> findByUserName(String username);
    public boolean existsByUserName(String userName);
    public boolean existsByEmail(String email);
}
