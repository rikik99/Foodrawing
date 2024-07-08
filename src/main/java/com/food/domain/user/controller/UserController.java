package com.food.domain.user.controller;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.food.domain.order.dto.OrderDTO;
import com.food.domain.order.dto.OrderStatusDTO;
import com.food.domain.user.dto.CustomerDTO;
import com.food.domain.user.dto.EmailResponseDTO;
import com.food.domain.user.dto.MyPageOrderDTO;
import com.food.domain.user.dto.UserDTO;
import com.food.domain.user.dto.UserSocialLinksDTO;
import com.food.domain.user.dto.VerificationRequestDTO;
import com.food.domain.user.dto.VerificationResponseDTO;
import com.food.domain.user.service.CustomerService;
import com.food.domain.user.service.EmailService;
import com.food.domain.user.service.UserService;
import com.food.domain.user.dto.CouponDTO;
import com.food.domain.user.service.AdminService;
import com.food.domain.user.service.CouponService;
import com.food.global.auth.CustomUserDetails;
import com.food.global.auth.Oauth2AttributesToModel;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private Oauth2AttributesToModel OTM;

    @Autowired
    private EmailService emailService;

    @Autowired
    private CustomerService customerService;

    @Autowired
    private CouponService couponService;
    
    @Autowired
    private AdminService adminService;

    @GetMapping("/login")
    public ModelAndView login(Authentication authentication) {
        // 로그인된 사용자가 로그인 페이지로 접근할 경우 메인 페이지로 리다이렉트
        if (authentication != null && authentication.isAuthenticated()) {
            return new ModelAndView("redirect:/");
        }
        ModelAndView mv = new ModelAndView();
        mv.setViewName("user/login");
        return mv;
    }

    @GetMapping("/signupInfo")
    public ModelAndView signupInfo() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("user/signupInfo");
        return mv;
    }

    @GetMapping("/signup")
    public ModelAndView signup(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("user/signup");

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        String userName = null;
        if (email != null) {
            userName = email.split("@")[0]; // '@' 이전의 값을 userName으로 설정
        }
        String provider = (String) session.getAttribute("provider");
        String providerId = (String) session.getAttribute("providerId");

        mv.addObject("userName", userName);
        mv.addObject("password", session.getAttribute("password"));
        mv.addObject("nickname", session.getAttribute("nickname"));
        mv.addObject("email", email);
        mv.addObject("birthYear", session.getAttribute("birthYear"));
        mv.addObject("birthMonth", session.getAttribute("birthMonth"));
        mv.addObject("birthDay", session.getAttribute("birthDay"));
        mv.addObject("gender", session.getAttribute("gender"));
        mv.addObject("phoneNumber", session.getAttribute("phoneNumber"));
        mv.addObject("pendingRegistration", session.getAttribute("pendingRegistration"));
        mv.addObject("oauth2RedirectUrl", session.getAttribute("oauth2RedirectUrl"));
        log.info("providerId = {}", providerId);
        // 추가: 소셜 로그인 정보
        mv.addObject("provider", provider);
        mv.addObject("providerId", providerId);

        return mv;
    }

    @PostMapping("/signup")
    public ModelAndView signupProcess(@ModelAttribute UserDTO userDTO, @RequestParam String birthYear,
                                      @RequestParam String birthMonth, @RequestParam String birthDay,
                                      @ModelAttribute CustomerDTO customerDTO, @RequestParam String provider,
                                      @RequestParam String providerId, HttpServletRequest request, Model model) {
        ModelAndView mv = new ModelAndView();

        // 수동 유효성 검증 로직
        if (userDTO.getUsername() == null || userDTO.getUsername().isEmpty()) {
            model.addAttribute("error", "아이디를 입력하세요.");
            mv.setViewName("user/signup");
            return mv;
        }
        if (userDTO.getPassword() == null || userDTO.getPassword().isEmpty()) {
            model.addAttribute("error", "비밀번호를 입력하세요.");
            mv.setViewName("user/signup");
            return mv;
        }
        if (customerDTO.getNickname() == null || customerDTO.getNickname().isEmpty()) {
            model.addAttribute("error", "닉네임을 입력하세요.");
            mv.setViewName("user/signup");
            return mv;
        }
        if (customerDTO.getName() == null || customerDTO.getName().isEmpty()) {
            model.addAttribute("error", "이름을 입력하세요.");
            mv.setViewName("user/signup");
            return mv;
        }
        if (customerDTO.getEmail() == null || customerDTO.getEmail().isEmpty()) {
            model.addAttribute("error", "이메일을 입력하세요.");
            mv.setViewName("user/signup");
            return mv;
        }
        // 추가적인 유효성 검증 로직...

        // 생년월일 설정
        String birthDateString = birthYear + "-" + birthMonth + "-" + birthDay;
        customerDTO.setBirthDate(Date.valueOf(birthDateString));

        // 서비스 호출하여 사용자 저장
        userService.signup(userDTO, customerDTO);
        OTM.authenticateUserAndSetSession(userDTO, request);

        if (provider != null && providerId != null) {
            // 소셜 로그인인 경우에만 USER_SOCIAL_LINKS에 데이터 추가
            userService.linkSocialAccount(customerDTO.getUserId(), provider, providerId);
        }

        mv.setViewName("redirect:/login");
        return mv;
    }

    @GetMapping("/linkAccount")
    public ModelAndView linkAccount(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("user/linkAccount");

        HttpSession session = request.getSession();
        String provider = (String) session.getAttribute("provider");
        String email = (String) session.getAttribute("email");
        String providerId = (String) session.getAttribute("providerId");
        log.info("linkAccount provider = {}", provider);
        log.info("linkAccount providerId = {}", providerId);
        mv.addObject("email", email);
        mv.addObject("provider", provider);
        mv.addObject("providerId", providerId);
        return mv;
    }

    @PostMapping("/linkAccount")
    public ModelAndView linkAccountProcess(HttpServletRequest request, @ModelAttribute UserSocialLinksDTO social, @RequestParam String email) {
        ModelAndView mv = new ModelAndView();
        String provider = social.getProvider();
        String providerId = social.getProviderId();

        log.info("POST linkAccount provider = {}", provider);
        log.info("POST linkAccount providerId = {}", providerId);

        CustomerDTO existingCustomer = userService.findCustomerByEmail(email);
        log.info("existingCustomer = {}", existingCustomer);

        if (existingCustomer != null) {
            // 연동 처리
            log.info("Linking social account for userId = {}", existingCustomer.getUserId());
            userService.linkSocialAccount(existingCustomer.getUserId(), provider, providerId);
            mv.setViewName("redirect:/");
        } else {
            log.info("User not found, redirecting to signup");
            mv.setViewName("redirect:/signup");
        }

        return mv;
    }

    @PostMapping("/sendVerificationEmail")
    public ResponseEntity<String> sendVerificationEmail(@RequestParam String email) {
        try {
            log.info("email = {}", email);
            String response = userService.sendVerificationEmail(email);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            log.error("Error sending verification email", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("이메일 인증 요청에 실패했습니다.");
        }
    }

    @GetMapping("/verify")
    public ModelAndView verifyUser(@RequestParam String token) {
        String result = userService.verifyUser(token);
        ModelAndView mv = new ModelAndView();
        if ("사용자가 성공적으로 인증되었습니다.".equals(result)) {
            mv.addObject("message", "이메일이 성공적으로 인증되었습니다!");
            mv.setViewName("user/verificationSuccess");
        } else {
            mv.addObject("message", result);
            mv.setViewName("user/verificationFail");
        }
        return mv;
    }

    @GetMapping("/verificationSuccess")
    public ModelAndView verificationSuccess() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("verificationSuccess");
        return mv;
    }

    @GetMapping("/verificationFail")
    public ModelAndView verificationFail() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("verificationFail");
        return mv;
    }

    @ResponseBody
    @GetMapping("/checkDuplicateUsername")
    public boolean checkDuplicateUsername(@RequestParam("username") String userName) {
        return userService.isUserIdExists(userName);
    }

    @GetMapping("/logout")
    public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        session.invalidate();

        // JWT 쿠키 삭제
        Cookie cookie = new Cookie("jwt", null);
        cookie.setHttpOnly(true);
        cookie.setSecure(true);
        cookie.setPath("/");
        cookie.setMaxAge(0); // 쿠키 삭제
        response.addCookie(cookie);

        ModelAndView mv = new ModelAndView();
        mv.setViewName("redirect:/login");
        return mv;
    }

    @PostMapping("/invalidateSession")
    @ResponseBody
    public void invalidateSession(HttpServletRequest request, @RequestParam(required = false) String email) {
        if (email != null && !email.isEmpty()) {
            // 이메일에 해당하는 인증 정보를 삭제
            userService.deleteVerificationTokenByEmail(email);
        }

        // 세션 무효화
        request.getSession().invalidate();
    }

    @GetMapping("/findUsername")
    public String showFindUsernameForm() {
        return "user/findUsername";
    }

    @PostMapping("/findUsername")
    @ResponseBody
    public EmailResponseDTO findUsername(@RequestBody VerificationRequestDTO request, HttpSession session) {
        EmailResponseDTO response = new EmailResponseDTO();
        try {
            String verificationCode = generateVerificationCode();
            emailService.sendVerificationEmail(request.getEmail(), verificationCode); // 인증 코드 이메일 발송

            // 세션에 인증 코드 저장
            session.setAttribute("verificationCode", verificationCode);
            session.setAttribute("email", request.getEmail());

            response.setSuccess(true);
        } catch (Exception e) {
            response.setSuccess(false);
            response.setMessage("인증 코드 발송에 실패했습니다.");
        }
        return response;
    }

    private String generateVerificationCode() {
        // 인증 코드 생성 로직
        return UUID.randomUUID().toString().substring(0, 6);
    }

    @PostMapping("/verify-id-code")
    @ResponseBody
    public VerificationResponseDTO verifyIdCode(@RequestBody VerificationRequestDTO request, HttpSession session, Model model) {
        String sessionCode = (String) session.getAttribute("verificationCode");
        String email = request.getEmail();

        VerificationResponseDTO response = new VerificationResponseDTO();
        if (sessionCode != null && sessionCode.equals(request.getCode())) {
            session.removeAttribute("verificationCode");
            session.removeAttribute("email");

            String userId = userService.findUsernameByEmail(email);
            response.setSuccess(true);
            response.setUserId(userId);
        } else {
            response.setSuccess(false);
            response.setMessage("올바르지 않은 인증 코드입니다.");
        }

        return response;
    }

    @GetMapping("/showUsername")
    public ModelAndView showUsername(@RequestParam String userId) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("user/showUsername");
        mv.addObject("userId", userId);
        return mv;
    }

    @GetMapping("/findPassword")
    public String showFindPasswordForm() {
        return "user/findPassword";
    }

    @PostMapping("/findPassword")
    @ResponseBody
    public EmailResponseDTO sendPasswordResetCode(@RequestBody VerificationRequestDTO request, HttpSession session) {
        EmailResponseDTO response = new EmailResponseDTO();
        try {
            String verificationCode = generateVerificationCode();
            emailService.sendVerificationEmail(request.getEmail(), verificationCode);

            // 세션에 인증 코드 저장
            session.setAttribute("verificationCode", verificationCode);
            session.setAttribute("email", request.getEmail());

            response.setSuccess(true);
        } catch (Exception e) {
            response.setSuccess(false);
            response.setMessage("인증 코드 발송에 실패했습니다.");
        }
        return response;
    }

    @PostMapping("/verify-password-code")
    @ResponseBody
    public VerificationResponseDTO verifyPasswordCode(@RequestBody VerificationRequestDTO request, HttpSession session, Model model) {
        String sessionCode = (String) session.getAttribute("verificationCode");
        String email = request.getEmail();

        VerificationResponseDTO response = new VerificationResponseDTO();
        if (sessionCode != null && sessionCode.equals(request.getCode())) {
            session.removeAttribute("verificationCode");
            session.removeAttribute("email");

            session.setAttribute("emailForPasswordReset", email); // 비밀번호 재설정을 위한 이메일 저장
            response.setSuccess(true);
        } else {
            response.setSuccess(false);
            response.setMessage("올바르지 않은 인증 코드입니다.");
        }

        return response;
    }

    @GetMapping("/passwordReset")
    public String showPasswordResetForm(HttpSession session, Model model) {
        String email = (String) session.getAttribute("emailForPasswordReset");
        if (email == null) {
            return "redirect:/findPassword";
        }
        model.addAttribute("email", email);
        return "user/passwordReset";
    }

    @PostMapping("/passwordReset")
    public String resetPassword(@RequestParam String email, @RequestParam String newPassword) {
        userService.updatePasswordByEmail(email, newPassword);
        return "redirect:/login";
    }

    @GetMapping("/myPage")
    public String myPage(Model model, Authentication authentication) {
        if (authentication == null) {
            log.info("Authentication is null, redirecting to login");
            return "redirect:/login";
        }

        String username = authentication.getName();
        UserDTO user = userService.loadUser(username);
        Long userId = user.getId();
        CustomerDTO customDTO = customerService.findCustomerByUserId(userId);
        log.info("customDTO = {}", customDTO);

        if (customDTO != null) {
            model.addAttribute("customer", customDTO);
            List<CouponDTO> availableCoupons = couponService.getAvailableCoupons(customDTO.getId());
            int couponCount = couponService.getAvailableCouponCount(customDTO.getId());
            int totalReserves = customerService.getCustomerReserves(customDTO.getId());
            String rating = customerService.getCustomerRating(customDTO.getUserId());
            String customerId = String.valueOf(customDTO.getId());
            int pendingPayment = customerService.getPendingPayment(customerId);
            log.info("pendingPayment = {}",pendingPayment);
            int completedPayment = customerService.getCompletedPayment(customerId);
            int preparingShipment = customerService.getPreparingShipment(customerId);
            int shipping = customerService.getShipping(customerId);
            int shipmentCompleted = customerService.getShipmentCompleted(customerId);
            
            model.addAttribute("pendingPayment", pendingPayment);
            model.addAttribute("completedPayment", completedPayment);
            model.addAttribute("preparingShipment", preparingShipment);
            model.addAttribute("shipmentCompleted", shipmentCompleted);
            model.addAttribute("shipping", shipping);
            model.addAttribute("rating", rating);
            
            model.addAttribute("couponCount", couponCount);
            model.addAttribute("availableCoupons", availableCoupons);
            model.addAttribute("totalReserves", totalReserves);

            return "user/myPage";
        } else {
            log.info("customDTO is null, redirecting to login");
        }
        return "redirect:/login"; // 로그인되지 않은 경우 로그인 페이지로 리다이렉트
    }

    @GetMapping("/user/myPageInfo")
    public String myPageInfo(Model model, Authentication authentication) {
        if (authentication == null) {
            log.info("Authentication is null, redirecting to login");

        }

        String username = authentication.getName();
        UserDTO user = userService.loadUser(username);
        Long userId = user.getId();
        CustomerDTO customDTO = customerService.findCustomerByUserId(userId);
        log.info("customDTO = {}", customDTO);

        if (customDTO != null) {
            model.addAttribute("customer", customDTO);
            return "user/myPageInfo"; // JSP 파일 이름
        } else {
            log.info("customDTO is null, redirecting to login");
        }
        return "redirect:/login"; // 로그인되지 않은 경우 로그인 페이지로 리다이렉트
    }

    @GetMapping("/user/myPageOrder")
    public String getOrderHistory(@RequestParam(required = false) String startDate, @RequestParam(required = false) String endDate, Model model, Authentication authentication) {
        log.debug("getOrderHistory called with startDate: {}, endDate: {}", startDate, endDate);
        CustomUserDetails customUserDetails = (CustomUserDetails) authentication.getPrincipal();
        CustomerDTO customerDTO = convertToCustomerDTO(customUserDetails);
        Long customerId = customerDTO.getId();

        log.debug("Customer ID: {}", customerId);

        Date start;
        Date end;

        if (startDate == null) {
            start = Date.valueOf(LocalDate.of(1970, 1, 1));
        } else {
            start = Date.valueOf(startDate);
        }

        if (endDate == null) {
            end = Date.valueOf(LocalDate.now());
        } else {
            end = Date.valueOf(endDate);
        }

        log.debug("Start Date: {}, End Date: {}", start, end);

        List<MyPageOrderDTO> orders = customerService.getOrderHistory(customerId.toString(), start, end);

        log.debug("Orders: {}", orders);

        model.addAttribute("orders", orders);
        return "user/myPageOrder";
    }

    @PostMapping("/user/confirmOrder")
    public String confirmOrder(@RequestParam Long orderId, Authentication authentication) {
        log.debug("confirmOrder called with orderId: {}", orderId);
        CustomUserDetails customUserDetails = (CustomUserDetails) authentication.getPrincipal();
        CustomerDTO customerDTO = convertToCustomerDTO(customUserDetails);
        Long customerId = customerDTO.getId();

        log.debug("Customer ID: {}", customerId);

        // 상태를 업데이트합니다.
        customerService.updateCancelOrderStatus(orderId, "구매 확정");

        return "redirect:/user/myPageOrder";
    }

    @GetMapping("/user/myPageOrderCancel")
    public String myPageOrderCancel(@RequestParam(required = false) String startDate, @RequestParam(required = false) String endDate, Model model, Authentication authentication) {
        log.debug("getOrderHistory called with startDate: {}, endDate: {}", startDate, endDate);
        CustomUserDetails customUserDetails = (CustomUserDetails) authentication.getPrincipal();
        CustomerDTO customerDTO = convertToCustomerDTO(customUserDetails);
        Long customerId = customerDTO.getId();

        log.debug("Customer ID: {}", customerId);

        Date start;
        Date end;

        if (startDate == null) {
            start = Date.valueOf(LocalDate.of(1970, 1, 1));
        } else {
            start = Date.valueOf(startDate);
        }

        if (endDate == null) {
            end = Date.valueOf(LocalDate.now());
        } else {
            end = Date.valueOf(endDate);
        }

        log.debug("Start Date: {}, End Date: {}", start, end);

        List<MyPageOrderDTO> orders = customerService.getOrderHistory(customerId.toString(), start, end);

        // 로그로 가져온 데이터 확인
        for (MyPageOrderDTO order : orders) {
            log.debug("Order: {}", order);
        }

        model.addAttribute("orders", orders);
        return "user/myPageOrderCancel";
    }

    @PostMapping("/user/updateOrderStatus")
    public String updateOrderStatus(@RequestParam Long orderId, @RequestParam String status, Authentication authentication) {
        log.debug("updateOrderStatus called with orderId: {}, status: {}", orderId, status);
        CustomUserDetails customUserDetails = (CustomUserDetails) authentication.getPrincipal();
        CustomerDTO customerDTO = convertToCustomerDTO(customUserDetails);
        Long customerId = customerDTO.getId();

        log.debug("Customer ID: {}", customerId);

        customerService.updateCancelOrderStatus(orderId, status);

        return "redirect:/user/myPageOrderCancel";  // 필요한 페이지로 리다이렉트
    }

    private CustomerDTO convertToCustomerDTO(CustomUserDetails customUserDetails) {
        CustomerDTO customerDTO = new CustomerDTO();
        customerDTO.setId(customUserDetails.getId());
        customerDTO.setUserId(customUserDetails.getId());
        customerDTO.setNickname(customUserDetails.getUsername());
        customerDTO.setName(customUserDetails.getUsername());
        customerDTO.setBirthDate(customUserDetails.getUserDTO().getBirthDate());
        return customerDTO;
    }

}
