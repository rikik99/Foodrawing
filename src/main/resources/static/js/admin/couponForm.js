document.addEventListener('DOMContentLoaded', function() {
    const couponDetails = {
        'Summer Sale': {
            description: '여름 특별 할인',
            discountType: '%',
            discountValue: '15%',
            minPrice: '₩10,000',
            maxDiscount: '₩50,000',
            startDate: '2024-07-01',
            endDate: '2024-07-31'
        },
        'Winter Sale': {
            description: '겨울 특별 할인',
            discountType: '₩',
            discountValue: '₩5,000',
            minPrice: '₩20,000',
            maxDiscount: '₩30,000',
            startDate: '2024-12-01',
            endDate: '2024-12-31'
        },
        'Black Friday': {
            description: '블랙 프라이데이 특별 할인',
            discountType: '%',
            discountValue: '20%',
            minPrice: '₩50,000',
            maxDiscount: '₩100,000',
            startDate: '2024-11-25',
            endDate: '2024-11-27'
        },
        'New Year Coupon': {
            description: '새해 맞이 쿠폰',
            discountType: '₩',
            discountValue: '₩10,000',
            minPrice: '₩30,000',
            maxDiscount: '₩50,000',
            startDate: '2025-01-01',
            endDate: '2025-01-15'
        },
        'Ongoing Discount': {
            description: '현재 진행 중인 할인',
            discountType: '₩',
            discountValue: '₩8,000',
            minPrice: '₩25,000',
            maxDiscount: '₩40,000',
            startDate: '2024-06-01',
            endDate: '2024-06-30'
        }
    };

    window.updateCouponDetails = function() {
        const selectedCoupon = document.getElementById('couponName').value;
        const details = couponDetails[selectedCoupon];
        if (details) {
            document.getElementById('couponDetails').innerHTML = `
                <ul>
                    <li>설명: ${details.description}</li>
                    <li>할인 타입: ${details.discountType}</li>
                    <li>할인 값: ${details.discountValue}</li>
                    <li>최소 구매 금액: ${details.minPrice}</li>
                    <li>최대 할인 금액: ${details.maxDiscount}</li>
                    <li>시작 날짜: ${details.startDate}</li>
                    <li>종료 날짜: ${details.endDate}</li>
                </ul>
            `;
        } else {
            document.getElementById('couponDetails').innerHTML = '';
        }
    };

    window.showTargetInput = function() {
        const selectedTarget = document.querySelector('input[name="targetType"]:checked').value;
        document.getElementById('individualInput').style.display = selectedTarget === 'individual' ? '' : 'none';
        document.getElementById('membershipInput').style.display = selectedTarget === 'membership' ? '' : 'none';
    };
});
