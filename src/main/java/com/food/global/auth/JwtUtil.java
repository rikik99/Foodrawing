package com.food.global.auth;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import javax.crypto.SecretKey;
import java.util.Date;
import java.util.Map;

@Component
public class JwtUtil {

    private final SecretKey key;

    public JwtUtil(@Value("${jwt.secret}") String secretKey) {
        this.key = Keys.hmacShaKeyFor(secretKey.getBytes());
    }

    public String generateToken(String username, boolean rememberMe, String provider, Map<String, Object> additionalClaims) {
        long expirationTime = rememberMe ? 86400000L : 3600000L; // 1일 또는 1시간
        Claims claims = Jwts.claims().setSubject(username).setIssuedAt(new Date()).setExpiration(new Date(System.currentTimeMillis() + expirationTime));
        claims.put("provider", provider);
        if (additionalClaims != null) {
            claims.putAll(additionalClaims);
        }
        return Jwts.builder()
                .setClaims(claims)
                .signWith(key, SignatureAlgorithm.HS512)
                .compact();
    }

    public String generateRefreshToken(String username) {
        long expirationTime = 604800000L; // 7일
        return Jwts.builder()
                .setSubject(username)
                .setIssuedAt(new Date())
                .setExpiration(new Date(System.currentTimeMillis() + expirationTime))
                .signWith(key, SignatureAlgorithm.HS512)
                .compact();
    }

    public Claims extractAllClaims(String token) {
        return Jwts.parserBuilder()
                .setSigningKey(key)
                .build()
                .parseClaimsJws(token)
                .getBody();
    }

    public String extractUsername(String token) {
        Claims claims = extractAllClaims(token);
        String provider = claims.get("provider", String.class); // provider 정보를 가져옴
        System.out.println("extractUsername claims = " + claims);
        System.out.println("extractUsername provider = " + provider);

        if ("kakao".equals(provider)) {
            Map<String, Object> kakaoAccount = (Map<String, Object>) claims.get("kakao_account");
            return (String) kakaoAccount.get("email");
        } else if ("naver".equals(provider)) {
            Map<String, Object> response = (Map<String, Object>) claims.get("response");
            return (String) response.get("email");
        }

        return claims.getSubject();
    }

    public boolean isTokenExpired(String token) {
        return extractAllClaims(token)
                .getExpiration()
                .before(new Date());
    }

    public boolean validateToken(String token) {
        return !isTokenExpired(token);
    }

    public boolean validateToken(String token, UserDetails userDetails) {
        final String username = extractUsername(token);
        return (username.equals(userDetails.getUsername()) && !isTokenExpired(token));
    }

    public boolean validateRefreshToken(String token) {
        return !isTokenExpired(token);
    }
}
