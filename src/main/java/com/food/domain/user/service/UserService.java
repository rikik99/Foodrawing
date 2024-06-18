package com.food.domain.user.service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

import org.springframework.context.annotation.Lazy;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.food.domain.user.dto.CustomerDTO;
import com.food.domain.user.dto.UserDTO;
import com.food.domain.user.dto.UserSocialLinksDTO;
import com.food.domain.user.dto.VerificationTokenDTO;
import com.food.domain.user.mapper.CustomerMapper;
import com.food.domain.user.mapper.UserMapper;
import com.food.domain.user.mapper.UserSocialLinksMapper;

import jakarta.mail.MessagingException;
import jakarta.transaction.Transactional;

@Service
public class UserService {

    private final UserMapper userMapper;
    private final PasswordEncoder passwordEncoder;
    private final EmailService emailService;
    private final CustomerMapper customerMapper;
    private final UserSocialLinksMapper userSocialLinksMapper;

    public UserService(UserMapper userMapper, @Lazy PasswordEncoder passwordEncoder, EmailService emailService,
            CustomerMapper customerMapper, UserSocialLinksMapper userSocialLinksMapper) {
        this.userMapper = userMapper;
        this.passwordEncoder = passwordEncoder;
        this.emailService = emailService;
        this.customerMapper = customerMapper;
        this.userSocialLinksMapper = userSocialLinksMapper;
    }

    public UserDTO loadUser(String username) {
        return userMapper.findByUsername(username);
    }

    public UserDTO loadUserById(Long id) {
        return userMapper.findById(id);
    }

    public String sendVerificationEmail(String email) {
        int verifiedCount = userMapper.isEmailVerified(email);
        if (verifiedCount > 0) {
            return "이미 인증된 이메일입니다.";
        }

        String token = UUID.randomUUID().toString();
        VerificationTokenDTO verificationToken = new VerificationTokenDTO(null, token, email, LocalDateTime.now().plusMinutes(5), "N");
        userMapper.insertToken(verificationToken);

        String verificationLink = "http://localhost:9093/verify?token=" + token;
        String subject = "이메일 인증";
        String text = "<p>다음 링크를 클릭하여 이메일을 인증하세요:</p><a href=\"" + verificationLink + "\">" + verificationLink + "</a>";

        try {
            emailService.sendEmail(email, subject, text);
            return "인증 이메일이 발송되었습니다.";
        } catch (MessagingException e) {
            return "인증 이메일 발송에 실패했습니다.";
        }
    }

    public String verifyUser(String token) {
        VerificationTokenDTO verificationToken = userMapper.findByToken(token);
        if (verificationToken == null) {
            return "유효하지 않은 토큰입니다.";
        }

        if (verificationToken.getExpiryDate().isBefore(LocalDateTime.now())) {
            return "토큰이 만료되었습니다.";
        }

        userMapper.updateEmailVerified(verificationToken.getEmail(), "Y");

        return "사용자가 성공적으로 인증되었습니다.";
    }

    public boolean isUserIdExists(String userName) {
        boolean isUserIdExists = false;
        UserDTO user = userMapper.findByUsername(userName);
        if (user != null) {
            isUserIdExists = true;
        }
        return isUserIdExists;
    }

    @Transactional
    public void signup(UserDTO userDTO, CustomerDTO customerDTO) {
        userDTO.setPassword(passwordEncoder.encode(userDTO.getPassword()));
        userMapper.insertUser(userDTO);
        customerDTO.setUserId(userDTO.getId());
        customerMapper.insertCustomer(customerDTO);
    }

    public void linkSocialAccount(Long userId, String provider, String providerId) {
        UserSocialLinksDTO socialLink = new UserSocialLinksDTO();
        socialLink.setUserId(userId);
        socialLink.setProvider(provider);
        socialLink.setProviderId(providerId);
        userSocialLinksMapper.insertLinks(socialLink);
    }

    public UserSocialLinksDTO findSocialLinkByProviderAndProviderId(String provider, String providerId) {
        return userSocialLinksMapper.findByProviderAndProviderId(provider, providerId);
    }

    public List<UserSocialLinksDTO> findSocialLinksByUserId(Long userId) {
        return userSocialLinksMapper.findByUserId(userId);
    }

    public CustomerDTO findCustomerByEmail(String email) {
        return customerMapper.findCustomerByEmail(email);
    }

    public void markEmailAsVerified(String email) {
        VerificationTokenDTO token = new VerificationTokenDTO();
        token.setEmail(email);
        token.setToken(UUID.randomUUID().toString());
        token.setExpiryDate(LocalDateTime.now().plusMinutes(5));
        token.setVerified("Y");
        userMapper.insertToken(token);
    }

    public void deleteVerificationTokenByEmail(String email) {
        userMapper.deleteToken(email);
    }

    public void sendFindUsernameEmail(String email, String username) {
        String subject = "아이디 찾기";
        String text = "<p>고객님의 아이디는 다음과 같습니다: " + username + "</p>";
        try {
            emailService.sendEmail(email, subject, text);
        } catch (MessagingException e) {
            // 예외 처리 로직 추가
        }
    }

    public String findUsernameByEmail(String email) {
        return userMapper.findUsernameByEmail(email);
    }

    public void updatePasswordByEmail(String email, String newPassword) {
        String encodedPassword = passwordEncoder.encode(newPassword);
        userMapper.updatePasswordByEmail(email, encodedPassword);
    }
}
