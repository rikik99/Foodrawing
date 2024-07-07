document.addEventListener('DOMContentLoaded', function() {
    const couponDetails = couponDetailsJson; // 쿠폰 상세 정보를 JSON으로 가져오기

    window.updateCouponDetails = function() {
        const selectedCoupon = document.getElementById('couponName').value;
        const details = couponDetails[selectedCoupon];
        if (details) {
            const discountType = details.discountType === 'P' ? '퍼센트' : '금액';
            const discountValue = details.discountType === 'P' ? `${details.discountValue}%` : `₩${details.discountValue}`;

            const startDate = new Date(details.startDate);
            const endDate = new Date(details.endDate);

            const formattedStartDate = isNaN(startDate.getTime()) ? '잘못된 날짜 형식' : `${startDate.getFullYear()}년 ${startDate.getMonth() + 1}월 ${startDate.getDate()}일 ${startDate.getHours()}시`;
            const formattedEndDate = isNaN(endDate.getTime()) ? '잘못된 날짜 형식' : `${endDate.getFullYear()}년 ${endDate.getMonth() + 1}월 ${endDate.getDate()}일 ${endDate.getHours()}시`;

            document.getElementById('couponDetails').innerHTML = `
                <ul>
                    <li>설명: ${details.description}</li>
                    <li>할인 타입: ${discountType}</li>
                    <li>할인 값: ${discountValue}</li>
                    <li>최소 구매 금액: ${details.minPrice}</li>
                    <li>최대 할인 금액: ${details.maxDiscount}</li>
                    <li>시작 날짜: ${formattedStartDate}</li>
                    <li>종료 날짜: ${formattedEndDate}</li>
                </ul>
            `;
        } else {
            document.getElementById('couponDetails').innerHTML = '';
        }
    };

    window.showTargetInput = function() {
        const selectedTarget = document.querySelector('input[name="targetType"]:checked').value;
        document.getElementById('customers').style.display = selectedTarget === 'customers' ? '' : 'none';
        document.getElementById('customerList').style.display = selectedTarget === 'customers' ? '' : 'none';
        document.getElementById('selectedcustomers').style.display = selectedTarget === 'customers' ? '' : 'none';
        document.getElementById('selectedcustomerList').style.display = selectedTarget === 'customers' ? '' : 'none';
        document.getElementById('membershipInput').style.display = selectedTarget === 'rating' ? '' : 'none';
    };

    window.selectCustomer = function(row) {
        const selectedCustomerTbody = document.getElementById('selectedCustomerTbody');
        const newRow = row.cloneNode(true); // 선택된 행을 복제
        newRow.setAttribute('data-customerId', row.getAttribute('data-customerId')); // data-customerId 속성 복사
        selectedCustomerTbody.appendChild(newRow); // 복제된 행을 추가
    };

    document.getElementById('selectedCustomerTbody').addEventListener('click', function(event) {
        const target = event.target;
        const tr = target.closest('tr');
        if (tr && this.contains(tr)) {
            tr.parentNode.removeChild(tr);
        }
    });

    const couponForm = document.getElementById('couponForm');
    if (couponForm) {
        couponForm.addEventListener('submit', async function(event) {
            event.preventDefault();

            const couponId = document.getElementById('couponName').value;
            const targetType = document.querySelector('input[name="targetType"]:checked').value;
            const issueCount = document.getElementById('issueCount').value;
            
            let customerIds = '';
            if (targetType === 'customers') {
                const selectedCustomerRows = document.querySelectorAll('#selectedCustomerTbody tr');
                customerIds = Array.from(selectedCustomerRows).map(row => row.getAttribute('data-customerId')).join(',');
            } else if (targetType === 'rating') {
                const selectedRatings = document.querySelectorAll('input[name="membershipLevels"]:checked');
                customerIds = Array.from(selectedRatings).map(rating => rating.value).join(',');
            }

            const requestData = {
                couponIds: [couponId], // 쿠폰 ID 리스트로 변경
                targetType: targetType,
                customerIds: customerIds,
                issueCount: issueCount
            };

            try {
                const response = await fetch(couponForm.action, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(requestData)
                });

                if (response.ok) {
                    const message = await response.text();
                    alert(message);
                    if (window.opener) {
                        window.opener.loadContent('/admin/couponList', 'couponList', true);
                        window.close();
                    }
                } else {
                    console.error('Failed to submit form');
                }
            } catch (error) {
                console.error('Error:', error);
            }
        });
    }
});
