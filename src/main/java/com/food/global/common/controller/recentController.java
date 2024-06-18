package com.food.global.common.controller;

import org.springframework.stereotype.Controller;

@Controller
public class recentController {

//    @Autowired
//    private ProductService productService;
//
//    @GetMapping("/product/{productNumber}")
//    public String viewProduct(@PathVariable String productNumber, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
//        ProductDTO product = productService.getProductById(productNumber);
//        model.addAttribute("product", product);
//
//        // Get recentViewedProducts from cookies
//        String recentViewedProductsJson = getCookieValue("recentViewedProducts", request);
//
//        LinkedList<ProductDTO> recentViewedProducts = new LinkedList<>();
//        ObjectMapper mapper = new ObjectMapper();
//        if (recentViewedProductsJson != null) {
//            recentViewedProducts = mapper.readValue(recentViewedProductsJson, new TypeReference<LinkedList<ProductDTO>>() {});
//        }
//
//        // Update recentViewedProducts
//        recentViewedProducts.removeIf(p -> p.getId().equals(productNumber));
//        recentViewedProducts.addFirst(product);
//
//        if (recentViewedProducts.size() > 10) {
//            recentViewedProducts.removeLast();
//        }
//
//        // Save updated recentViewedProducts to cookies
//        Cookie cookie = new Cookie("recentViewedProducts", URLEncoder.encode(mapper.writeValueAsString(recentViewedProducts), "UTF-8"));
//        cookie.setMaxAge(60 * 60 * 24 * 7); // 1 week
//        cookie.setPath("/");
//        response.addCookie(cookie);
//
//        return "product/viewProduct";  // 실제 뷰의 이름으로 변경
//    }
//
//    private String getCookieValue(String name, HttpServletRequest request) {
//        Cookie[] cookies = request.getCookies();
//        if (cookies != null) {
//            for (Cookie cookie : cookies) {
//                if (name.equals(cookie.getName())) {
//                    try {
//                        return URLDecoder.decode(cookie.getValue(), "UTF-8");
//                    } catch (UnsupportedEncodingException e) {
//                        e.printStackTrace();
//                    }
//                }
//            }
//        }
//        return null;
//    }
}
