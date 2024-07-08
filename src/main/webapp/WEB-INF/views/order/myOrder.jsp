<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문 정보</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="/css/common.css"/>
    <link rel="stylesheet" href="/css/sidebar.css"/>
    <style>
        .order-info-container {
            margin-top: 20px;
        }
        .order-item {
            border-bottom: 1px solid #ccc;
            padding: 10px 0;
        }
        .order-item img {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 5px;
        }
        .order-item-details {
            margin-left: 20px;
            flex-grow: 1;
        }
        .order-item-title {
            font-size: 1.2em;
            margin-bottom: 5px;
        }
        .order-item-price {
            color: #f00;
            font-size: 1.1em;
        }
        .order-item-old-price {
            text-decoration: line-through;
            color: #999;
        }
    </style>
</head>
<body>
    <%@include file="/WEB-INF/include/header.jsp"%>
    <%@include file="/WEB-INF/include/nav.jsp"%>
    <%@include file="/WEB-INF/include/sidebar.jsp"%>
    <div class="container order-info-container">
        <div class="card">
            <div class="card-header">
                <h1>주문 정보</h1>
            </div>
            <div class="card-body">
                <div>
                    <h2>주문 번호: ${guestOrderInfoDTO.order.orderNumber}</h2>
                    <p>주문 상태: ${guestOrderInfoDTO.orderStatus.orderStatus}</p>
                    <p>결제 방식: ${guestOrderInfoDTO.order.paymentType}</p>
                    <p>총 금액: ${guestOrderInfoDTO.order.totalAmount}원</p>
                </div>
                <hr/>
                <c:forEach var="orderDetailInfo" items="${guestOrderInfoDTO.orderDetailInfo}">
                    <c:forEach var="detail" items="${orderDetailInfo.orderDetail}" varStatus="status">
                        <div class="order-item d-flex">
                            <div>
                                <img src="${orderDetailInfo.productFile[status.index].filePath}" alt="${orderDetailInfo.product[status.index].name}">
                            </div>
                            <div class="order-item-details">
                                <div class="order-item-title">${orderDetailInfo.product[status.index].name}</div>
                                <div>${orderDetailInfo.product[status.index].description}</div>
                                <c:choose>
                                    <c:when test="${detail.discountPrice > 0}">
                                        <div class="order-item-price">${detail.discountPrice}원</div>
                                        <div class="order-item-old-price">${detail.unitPrice}원</div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="order-item-price">${detail.unitPrice}원</div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </c:forEach>
                </c:forEach>
                <hr/>
                <div>
                    <h3>배송 정보</h3>
                    <p>받는 사람: ${guestOrderInfoDTO.delivery.recipientName}</p>
                    <p>연락처: ${guestOrderInfoDTO.delivery.recipientPhone}</p>
                    <p>주소: ${guestOrderInfoDTO.delivery.recipientAddress} ${guestOrderInfoDTO.delivery.recipientAddressDetail}</p>
                    <p>우편번호: ${guestOrderInfoDTO.delivery.recipientZipcode}</p>
                    <p>배송 상태: ${guestOrderInfoDTO.delivery.deliveryStatus}</p>
                    <p>배송 메시지: ${guestOrderInfoDTO.delivery.deliveryComment}</p>
                </div>
                <a href="/mainpage?category=11" class="btn btn-primary">홈으로 돌아가기</a>
            </div>
        </div>
    </div>
    <%@include file="/WEB-INF/include/footer.jsp"%>
</body>
</html>
