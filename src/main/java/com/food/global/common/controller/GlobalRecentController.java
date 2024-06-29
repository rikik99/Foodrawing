package com.food.global.common.controller;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.food.global.common.dto.RecentProductInfo;
import com.nimbusds.jose.shaded.gson.Gson;
import com.nimbusds.jose.shaded.gson.reflect.TypeToken;

@ControllerAdvice
public class GlobalRecentController {
//	@ModelAttribute("recentViewedProducts")
//    public List<RecentProductInfo> recentViewedProducts(HttpServletRequest request) {
//        Cookie[] cookies = request.getCookies();
//        if (cookies != null) {
//            for (Cookie cookie : cookies) {
//                if ("recentViewedProducts".equals(cookie.getName())) {
//                    String decodedValue = new String(Base64.getDecoder().decode(cookie.getValue()));
//                    Type listType = new TypeToken<ArrayList<RecentProductInfo>>() {}.getType();
//                    return new Gson().fromJson(decodedValue, listType);
//                }
//            }
//        }
//        return new ArrayList<>();
//    }
}
