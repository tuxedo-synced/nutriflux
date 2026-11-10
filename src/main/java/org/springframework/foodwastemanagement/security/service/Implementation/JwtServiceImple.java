package org.springframework.foodwastemanagement.security.service.Implementation;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import org.springframework.foodwastemanagement.entity.Users;
import org.springframework.foodwastemanagement.security.service.blueprint.JwtService;
import org.springframework.stereotype.Service;

import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import java.security.Key;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.function.Function;

@Service
public class JwtServiceImple implements JwtService {

    private String generatedKeyValue = "" ;

    public JwtServiceImple(){
        KeyGenerator keyGenerator = null;
        try {
            keyGenerator = KeyGenerator.getInstance("HmacSHA256");
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
        SecretKey secretKey = keyGenerator.generateKey();
        generatedKeyValue = Base64.getEncoder().encodeToString(secretKey.getEncoded());
    }

    public String generateToken(String username) {

        Map<String, Object> claims = new HashMap<>();

        String token = Jwts.builder()
                .claims()
                .add(claims)
                .subject(username)
                .issuedAt(new Date(System.currentTimeMillis()))
                .expiration(new Date(System.currentTimeMillis() + 60 * 60 * 30))
                .and()
                .signWith(getKey())
                .compact();

        return token;
    }

    private Key getKey() {

        byte[] keyBytes = Base64.getDecoder()
                .decode(generatedKeyValue);

        return Keys.hmacShaKeyFor(keyBytes);
    }

    public String extractUsername(String token) {
        return extractClaim(token, Claims::getSubject);
    }

    private <T> T extractClaim(
            String token,
            Function<Claims, T> claimResolver) {

        Claims claims = Jwts
                .parser()
                .verifyWith((SecretKey) getKey())
                .build()
                .parseSignedClaims(token)
                .getPayload();

        return claimResolver.apply(claims);
    }

    public boolean validatetoken(
            String token,
            Users users) {

        String username = extractUsername(token);

        return username.equals(users.getUsername())
                && !isTokenExpired(token);
    }

    private boolean isTokenExpired(String token) {

        Date expiration = extractClaim(token, Claims::getExpiration);

        return expiration.before(new Date());
    }
}

