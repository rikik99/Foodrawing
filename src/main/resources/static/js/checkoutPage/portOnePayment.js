const userCode = "imp16305777"; // 고객사 식별코드로 변경해야 합니다
    IMP.init(userCode);

    function pay() {        
    	var customerId = 1; // 실제 고객 ID로 변경해야 합니다
        var customerName = document.getElementById('customerName').value;
        var deliverName = document.getElementById('deliverName').value;
        const customerEmail = document.getElementById('customerEmail').value;
        var customerPhone = document.getElementById('customerPhone').value;
        var deliverPhone = document.getElementById('deliverPhone').value;
        const address = document.getElementById('address').value;
        const detailAddress = document.getElementById('detailAddress').value;
        const zipCode = document.getElementById('zipCode').value;
        
     // 필수 입력 필드 체크
        if (!customerName || !customerEmail || !customerPhone || !deliverName || !deliverPhone || !address || !detailAddress || !zipCode) {
            alert('정보를 모두 입력해 주세요.');
            return;
        }
        
        const orderNumber = document.getElementById('orderNumber').value;
        const paymentMethod = document.querySelector('.payment-method.selected').getAttribute('data-method');
        const finalPrice = parseInt(document.getElementById('finalPrice').innerText.replace('원', '').replace(',', ''));
        var discount = parseInt(document.getElementById('discountPrice').innerText.replace('원', '').replace(',', ''));
        

        var productNumbers = Array.from(document.querySelectorAll('.productNumber')).map(input => input.value);
        var salesPostIds = Array.from(document.querySelectorAll('.salesPostId')).map(input => input.value);
        var quantities = Array.from(document.querySelectorAll('.quantity')).map(input => input.innerText.replace('수량: ', ''));
        var originalPrices = Array.from(document.querySelectorAll('.originalPrice')).map(input => input.innerText.replace('원', ''));
        var discounts = Array.from(document.querySelectorAll('.discountValue')).map(input => input.innerText.replace('원', ''));
        
        var deliveryComment = document.getElementById('deliveryRequest').value;
        if (deliveryComment === 'other') {
            deliveryComment = document.getElementById('extraRequestInput').value;
        } else {
            deliveryComment = document.getElementById('deliveryRequest').options[document.getElementById('deliveryRequest').selectedIndex].innerText;
        }
        
        const orderDetails = productNumbers.map((productNumber, index) => ({
            salesPostId: salesPostIds[index], //넣기
            unitPrice: originalPrices[index],
            discountPrice: discounts[index],
            quantity: quantities[index]
        }));
        
        const jsonData = {
        	    customerId: customerId,
        	    customerName: customerName,
        	    deliverName: deliverName,
        	    customerPhone: customerPhone,
        	    deliverPhone: deliverPhone,
        	    finalPrice: finalPrice,
        	    discount: discount,
        	    orderDetails: orderDetails,
        	    order: {
        	        identifierId: customerId,
        	        identifierType: "customer",
        	        orderDate: new Date().toISOString(),
        	        totalAmount: finalPrice.toString(),
        	        orderNumber: orderNumber,
        	        paymentId: 'merchant_' + orderNumber,
        	        paymentType: paymentMethod
        	    },
        	    delivery: {
        	        recipientName: deliverName,
        	        recipientPhone: deliverPhone,
        	        recipientAddress: address,
        	        recipientAddressDetail: detailAddress,
        	        recipientZipcode: zipCode,
        	        deliveryStatus: "배송 전",
        	        deliveryComment: deliveryComment,
        	        deliveryStartDate: new Date().toISOString(),
        	        estimatedArrivalDate: new Date(Date.now() + 3 * 24 * 60 * 60 * 1000).toISOString() // 3일 후 예상 도착
        	    }
        	};
        
        console.log(JSON.stringify(jsonData));
        
        
        const IMP = window.IMP; // 생략 가능
        const userCode = "imp16305777"; // 고객사 식별코드로 변경해야 합니다
        IMP.init(userCode);

        if (paymentMethod === "card") {
        		const pgProviders = ["uplus.tlgdacomxpay", "danal_tpay.9810030929", "nice_v2.iamport00m", 'kicc.T5102001']; // Add other PG providers as needed
            var randomPgProvider = pgProviders[Math.floor(Math.random() * pgProviders.length)];

            IMP.request_pay({
            		//pg: randomPgProvider,
                pg: "kicc.T5102001",
                pay_method: "card",
                merchant_uid: 'merchant_' + orderNumber,
                name: '주문명:결제테스트',
                amount: 500,
                buyer_email: customerEmail,
                buyer_name: customerName,
                buyer_tel: customerPhone,
                buyer_addr: address + ' ' + detailAddress,
                buyer_postcode: zipCode,
                m_redirect_url:  "{모바일에서 결제 완료 후 리디렉션 될 URL}", // 실제 리디렉션 URL로 변경해야 합니다
                appCard: true,
            }, function(response) {
                const { status, err_msg } = response;
                
                console.dir(response);
                
                if (err_msg) {
                   alert(err_msg);
                }
								
                if (status === 'paid') {
                    const { imp_uid } = response;
                    //verifyPayment(imp_uid);
                    // 결제가 성공한 경우 필요한 정보를 서버로 전달

		            	fetch('/payment/result', {
		                    method: 'POST',
		                    headers: {
		                        'Content-Type': 'application/json',
		                    },
		                    body: JSON.stringify(jsonData),
		                 })
		                 .then(res => res.json())
		                 .then(data => {
		                	 console.log(data);
		                     if (data.status === 'success') {
		                         alert('결제가 성공적으로 완료되었습니다.');
		                         window.location.href = '/best';
		                     } else {
		                         alert('결제 처리 중 문제가 발생했습니다: ' + data.message);
		                     }
		                 })
		                 .catch(err => {
		                     console.error(err);
		                     alert('결제 처리 중 오류가 발생했습니다.');
		                 });
		              }
		              
		              if (status === 'failed') {
		                  alert('결제가 실패하였습니다. 에러 메시지: ' + err_msg);
		                  // 추가적으로 실패 로그를 서버로 전송하거나 다른 조치를 취할 수 있습니다.
		                  fetch('/payment/fail', {
		                      method: 'POST',
		                      headers: {
		                          'Content-Type': 'application/json'
		                      },
		                      body: JSON.stringify({
		                          orderId: orderId,
		                          userId: userId,
		                          errMsg: err_msg
		                      })
		                  })
		                  .then(res => res.json())
		                  .then(data => {
		                      console.log(data);
		                  })
		                  .catch(err => {
		                      console.error(err);
		                  });
		              }
		              
		           })
        } else if (paymentMethod === "vbank") {
            var today = new Date();

            var year = today.getFullYear();
            var month = ('0' + (today.getMonth() + 1)).slice(-2);
            var day = ('0' + today.getDate()).slice(-2);

            var dateString = year + '-' + month  + '-' + day;

            IMP.request_pay(
            		  {
            		    pg: "nice_v2.iamport03m",
            		    pay_method: "vbank",
		                merchant_uid: 'merchant_' + orderNumber,
		                name: '주문명:결제테스트',
		                amount: 500,
		                buyer_email: customerEmail,
		                buyer_name: customerName,
		                buyer_tel: customerPhone,
		                buyer_addr: address + ' ' + detailAddress,
		                buyer_postcode: zipCode,
		                m_redirect_url:  "{모바일에서 결제 완료 후 리디렉션 될 URL}", // 실제 리디렉션 URL로 변경해야 합니다
            		    vbank_due: dateString,
            }, function(response) {
                const { status, err_msg } = response;
                
                console.dir(response);
                
                if (err_msg) {
                   alert(err_msg);
                }
								
                if (status === 'paid') {
                    const { imp_uid } = response;
                    //verifyPayment(imp_uid);
                    // 결제가 성공한 경우 필요한 정보를 서버로 전달

		            	fetch('/payment/result', {
		                    method: 'POST',
		                    headers: {
		                        'Content-Type': 'application/json',
		                    },
		                    body: JSON.stringify(jsonData),
		                 })
		                 .then(res => res.json())
		                 .then(data => {
		                	 console.log(data);
		                     if (data.status === 'success') {
		                         alert('결제가 성공적으로 완료되었습니다.');
		                         window.location.href = '/best';
		                     } else {
		                         alert('결제 처리 중 문제가 발생했습니다: ' + data.message);
		                     }
		                 })
		                 .catch(err => {
		                     console.error(err);
		                     alert('결제 처리 중 오류가 발생했습니다.');
		                 });
		              }
		              
		              if (status === 'failed') {
		                  alert('결제가 실패하였습니다. 에러 메시지: ' + err_msg);
		                  // 추가적으로 실패 로그를 서버로 전송하거나 다른 조치를 취할 수 있습니다.
		                  fetch('/payment/fail', {
		                      method: 'POST',
		                      headers: {
		                          'Content-Type': 'application/json'
		                      },
		                      body: JSON.stringify({
		                          orderId: orderId,
		                          userId: userId,
		                          errMsg: err_msg
		                      })
		                  })
		                  .then(res => res.json())
		                  .then(data => {
		                      console.log(data);
		                  })
		                  .catch(err => {
		                      console.error(err);
		                  });
		              }
		              
		           })
        } else if (paymentMethod === "phone") {
            const userCode = "imp16305777"; // 고객사 식별코드로 변경해야 합니다
            IMP.init(userCode);

            IMP.request_pay(
            		  {
            		    pg: "danal.A010002002",
            		    pay_method: "phone",
		                merchant_uid: 'merchant_' + orderNumber,
		                name: '주문명:결제테스트',
		                amount: 500,
		                buyer_email: customerEmail,
		                buyer_name: customerName,
		                buyer_tel: customerPhone,
		                buyer_addr: address + ' ' + detailAddress,
		                buyer_postcode: zipCode,
		                m_redirect_url:  "{모바일에서 결제 완료 후 리디렉션 될 URL}", // 실제 리디렉션 URL로 변경해야 합니다
            }, function(response) {
                const { status, err_msg } = response;
                
                console.dir(response);
                
                if (err_msg) {
                   alert(err_msg);
                }
								
                if (status === 'paid') {
                    const { imp_uid } = response;
                    //verifyPayment(imp_uid);
                    // 결제가 성공한 경우 필요한 정보를 서버로 전달

		            	fetch('/payment/result', {
		                    method: 'POST',
		                    headers: {
		                        'Content-Type': 'application/json',
		                    },
		                    body: JSON.stringify(jsonData),
		                 })
		                 .then(res => res.json())
		                 .then(data => {
		                	 console.log(data);
		                     if (data.status === 'success') {
		                         alert('결제가 성공적으로 완료되었습니다.');
		                         window.location.href = '/best';
		                     } else {
		                         alert('결제 처리 중 문제가 발생했습니다: ' + data.message);
		                     }
		                 })
		                 .catch(err => {
		                     console.error(err);
		                     alert('결제 처리 중 오류가 발생했습니다.');
		                 });
		              }
		              
		              if (status === 'failed') {
		                  alert('결제가 실패하였습니다. 에러 메시지: ' + err_msg);
		                  // 추가적으로 실패 로그를 서버로 전송하거나 다른 조치를 취할 수 있습니다.
		                  fetch('/payment/fail', {
		                      method: 'POST',
		                      headers: {
		                          'Content-Type': 'application/json'
		                      },
		                      body: JSON.stringify({
		                          orderId: orderId,
		                          userId: userId,
		                          errMsg: err_msg
		                      })
		                  })
		                  .then(res => res.json())
		                  .then(data => {
		                      console.log(data);
		                  })
		                  .catch(err => {
		                      console.error(err);
		                  });
		              }
		              
		           })
        } else if (paymentMethod === "tosspayments") {
            IMP.request_pay(
            		  {
            		    pg: "tosspay",
            		    pay_method: "card",
		                merchant_uid: 'merchant_' + orderNumber,
		                name: '주문명:결제테스트',
		                amount: 500,
		                buyer_email: customerEmail,
		                buyer_name: customerName,
		                buyer_tel: customerPhone,
		                buyer_addr: address + ' ' + detailAddress,
		                buyer_postcode: zipCode,
		                m_redirect_url:  "{모바일에서 결제 완료 후 리디렉션 될 URL}", // 실제 리디렉션 URL로 변경해야 합니다
            }, function(response) {
                const { status, err_msg } = response;
                
                console.dir(response);
                
                if (err_msg) {
                   alert(err_msg);
                }
								
                if (status === 'paid') {
                    const { imp_uid } = response;
                    //verifyPayment(imp_uid);
                    // 결제가 성공한 경우 필요한 정보를 서버로 전달

		            	fetch('/payment/result', {
		                    method: 'POST',
		                    headers: {
		                        'Content-Type': 'application/json',
		                    },
		                    body: JSON.stringify(jsonData),
		                 })
		                 .then(res => res.json())
		                 .then(data => {
		                	 console.log(data);
		                     if (data.status === 'success') {
		                         alert('결제가 성공적으로 완료되었습니다.');
		                         window.location.href = '/best';
		                     } else {
		                         alert('결제 처리 중 문제가 발생했습니다: ' + data.message);
		                     }
		                 })
		                 .catch(err => {
		                     console.error(err);
		                     alert('결제 처리 중 오류가 발생했습니다.');
		                 });
		              }
		              
		              if (status === 'failed') {
		                  alert('결제가 실패하였습니다. 에러 메시지: ' + err_msg);
		                  // 추가적으로 실패 로그를 서버로 전송하거나 다른 조치를 취할 수 있습니다.
		                  fetch('/payment/fail', {
		                      method: 'POST',
		                      headers: {
		                          'Content-Type': 'application/json'
		                      },
		                      body: JSON.stringify({
		                          orderId: orderId,
		                          userId: userId,
		                          errMsg: err_msg
		                      })
		                  })
		                  .then(res => res.json())
		                  .then(data => {
		                      console.log(data);
		                  })
		                  .catch(err => {
		                      console.error(err);
		                  });
		              }
		              
		           })
        } else if (paymentMethod === "payco") {
            IMP.request_pay(
            		  {
            		    pg: "payco.PARTNERTEST",
		                merchant_uid: 'merchant_' + orderNumber,
		                name: '주문명:결제테스트',
		                amount: 500,
		                buyer_email: customerEmail,
		                buyer_name: customerName,
		                buyer_tel: customerPhone,
		                buyer_addr: address + ' ' + detailAddress,
		                buyer_postcode: zipCode,
		                m_redirect_url:  "{모바일에서 결제 완료 후 리디렉션 될 URL}", // 실제 리디렉션 URL로 변경해야 합니다
            }, function(response) {
                const { status, err_msg } = response;
                
                console.dir(response);
                
                if (err_msg) {
                   alert(err_msg);
                }
								
                if (status === 'paid') {
                    const { imp_uid } = response;
                    //verifyPayment(imp_uid);
                    // 결제가 성공한 경우 필요한 정보를 서버로 전달

		            	fetch('/payment/result', {
		                    method: 'POST',
		                    headers: {
		                        'Content-Type': 'application/json',
		                    },
		                    body: JSON.stringify(jsonData),
		                 })
		                 .then(res => res.json())
		                 .then(data => {
		                	 console.log(data);
		                     if (data.status === 'success') {
		                         alert('결제가 성공적으로 완료되었습니다.');
		                         window.location.href = '/best';
		                     } else {
		                         alert('결제 처리 중 문제가 발생했습니다: ' + data.message);
		                     }
		                 })
		                 .catch(err => {
		                     console.error(err);
		                     alert('결제 처리 중 오류가 발생했습니다.');
		                 });
		              }
		              
		              if (status === 'failed') {
		                  alert('결제가 실패하였습니다. 에러 메시지: ' + err_msg);
		                  // 추가적으로 실패 로그를 서버로 전송하거나 다른 조치를 취할 수 있습니다.
		                  fetch('/payment/fail', {
		                      method: 'POST',
		                      headers: {
		                          'Content-Type': 'application/json'
		                      },
		                      body: JSON.stringify({
		                          orderId: orderId,
		                          userId: userId,
		                          errMsg: err_msg
		                      })
		                  })
		                  .then(res => res.json())
		                  .then(data => {
		                      console.log(data);
		                  })
		                  .catch(err => {
		                      console.error(err);
		                  });
		              }
		              
		           })
        } else if (paymentMethod === "kakaopay") {
            IMP.request_pay(
            		  {
            		    pg: "kakaopay.TC0ONETIME",
            		    pay_method: "card",
		                merchant_uid: 'merchant_' + orderNumber,
		                name: '주문명:결제테스트',
		                amount: 500,
		                buyer_email: customerEmail,
		                buyer_name: customerName,
		                buyer_tel: customerPhone,
		                buyer_addr: address + ' ' + detailAddress,
		                buyer_postcode: zipCode,
		                m_redirect_url:  "{모바일에서 결제 완료 후 리디렉션 될 URL}", // 실제 리디렉션 URL로 변경해야 합니다
            }, function(response) {
                const { status, err_msg } = response;
                
                console.dir(response);
                
                if (err_msg) {
                   alert(err_msg);
                }
								
                if (status === 'paid') {
                    const { imp_uid } = response;
                    //verifyPayment(imp_uid);
                    // 결제가 성공한 경우 필요한 정보를 서버로 전달

		            	fetch('/payment/result', {
		                    method: 'POST',
		                    headers: {
		                        'Content-Type': 'application/json',
		                    },
		                    body: JSON.stringify(jsonData),
		                 })
		                 .then(res => res.json())
		                 .then(data => {
		                	 console.log(data);
		                     if (data.status === 'success') {
		                         alert('결제가 성공적으로 완료되었습니다.');
		                         window.location.href = '/best';
		                     } else {
		                         alert('결제 처리 중 문제가 발생했습니다: ' + data.message);
		                     }
		                 })
		                 .catch(err => {
		                     console.error(err);
		                     alert('결제 처리 중 오류가 발생했습니다.');
		                 });
		              }
		              
		              if (status === 'failed') {
		                  alert('결제가 실패하였습니다. 에러 메시지: ' + err_msg);
		                  // 추가적으로 실패 로그를 서버로 전송하거나 다른 조치를 취할 수 있습니다.
		                  fetch('/payment/fail', {
		                      method: 'POST',
		                      headers: {
		                          'Content-Type': 'application/json'
		                      },
		                      body: JSON.stringify({
		                          orderId: orderId,
		                          userId: userId,
		                          errMsg: err_msg
		                      })
		                  })
		                  .then(res => res.json())
		                  .then(data => {
		                      console.log(data);
		                  })
		                  .catch(err => {
		                      console.error(err);
		                  });
		              }
		              
		           })
        } 
    }