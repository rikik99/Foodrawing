package com.food.global.common.controller;

import org.springframework.web.bind.annotation.ControllerAdvice;

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
