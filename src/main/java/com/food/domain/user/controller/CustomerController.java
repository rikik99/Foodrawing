package com.food.domain.user.controller;

import com.food.domain.user.dto.CustomerDTO;
import com.food.domain.user.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/customer")
public class CustomerController {

    @Autowired
    private CustomerService customerService;

    @GetMapping("/edit/{id}")
    public String editCustomer(@PathVariable("id") Long id, Model model, HttpSession session) {
        CustomerDTO customer = customerService.getCustomerById(id);
        model.addAttribute("customer", customer);
        session.setAttribute("plogin", customer); // 세션 정보 업데이트
        return "customer/edit";
    }

    @PostMapping("/update")
    public String updateCustomer(@ModelAttribute CustomerDTO customer, HttpSession session) {
        customerService.updateCustomer(customer);
        session.setAttribute("plogin", customer); // 세션 정보 업데이트
        return "redirect:/customer/edit/" + customer.getId();
    }

    @PostMapping("/delete")
    public String deleteCustomer(@RequestParam Long id, HttpSession session) {
        customerService.deleteCustomer(id);
        session.invalidate(); // 세션 무효화
        return "redirect:/";
    }
}
