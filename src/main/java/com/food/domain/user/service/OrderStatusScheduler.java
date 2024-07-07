package com.food.domain.user.service;



import java.time.LocalDateTime;
import java.util.List;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.food.domain.user.mapper.AdminMapper;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@Service
public class OrderStatusScheduler {

    private final AdminMapper adminMapper;

    public OrderStatusScheduler(AdminMapper adminMapper) {
        this.adminMapper = adminMapper;
    }

    @Scheduled(cron = "0 0 0 * * *") // 매일 자정에 실행
    @Transactional
    public void updateOrderStatusToConfirmed() {
        LocalDateTime oneWeekAgo = LocalDateTime.now().minusWeeks(1);
        List<Long> orderIds = adminMapper.findOrdersToConfirm(oneWeekAgo);
        
        for (Long orderId : orderIds) {
            adminMapper.updateOrderStatus(orderId, "구매 확정");
        }
        
        if (!orderIds.isEmpty()) {
            log.info("Updated {} orders to '구매 확정'", orderIds.size());
        }
    }
}
