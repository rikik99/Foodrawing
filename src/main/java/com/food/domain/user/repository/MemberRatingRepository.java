package com.food.domain.user.repository;
import org.springframework.data.jpa.repository.JpaRepository;

import com.food.domain.user.entity.MemberRating;

public interface MemberRatingRepository extends JpaRepository<MemberRating, Long> {

    
}