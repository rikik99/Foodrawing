package com.food.domain.user.controller;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


import com.food.domain.user.dto.CustomerDTO;
import com.food.domain.user.service.CustomerService;
import com.food.global.auth.CustomUserDetails;

@Controller
@RequestMapping("/customer")
public class CustomerController {

    @Autowired
    private CustomerService customerService;

    @GetMapping("/edit/{id}")
    public String editCustomer(@PathVariable("id") Long id, Model model, Authentication authentication) {
        CustomerDTO customer = customerService.getCustomerById(id);
        model.addAttribute("customer", customer);
        return "user/myPageInfo";
    }

    @PostMapping("/update")
    public String updateCustomer(@ModelAttribute CustomerDTO customer, Authentication authentication) {
        customerService.updateCustomer(customer);
        return "redirect:/customer/edit/" + customer.getId();
    }

    @PostMapping("/delete")
    public String deleteCustomer(@RequestParam Long id, Authentication authentication) {
        customerService.deleteCustomer(id);
        return "redirect:/logout";
    }


}
