<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>회원가입</title>
<link rel="stylesheet" type="text/css"
	href="<c:url value='/css/signup.css' />">
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script src="<c:url value='/js/signup.js' />"></script>
</head>
<body>
	<div class="signup-container">
		<h1>회원가입</h1>
		<form action="<c:url value='/signup' />" method="post">
			<!-- 유저 정보 입력 -->
			<div class="form-group">
				<label for="username">아이디 *</label> <input type="text" id="username"
					name="username" value="${username}"  required>
			</div>
			<div id="usernameFeedback" class="text-danger"></div>
			<div class="form-group">
				<label for="password">비밀번호 *</label> <input type="password"
					id="password" name="password" value="${password}" required>
			</div>
			<div id="invalidPw" class="text-danger"></div>
			<div class="form-group">
				<label for="confirm-password">비밀번호 확인 *</label> <input
					type="password" id="confirm-password" name="confirm-password" value="${password}"
					required>
			</div>
			<div id="invalidPwCheck" class="text-danger"></div>
			<!-- 고객 정보 입력 -->
			<div class="form-group">
				<label for="nickname">닉네임 *</label> <input type="text" id="nickname" value="${nickname}"
					name="nickname" required>
			</div>
			<div id="invalidNickname" class="text-danger"></div>
			<div class="form-group">
				<label for="name">이름 *</label> <input type="text" id="name" value="${name}"
					name="name" required>
			</div>
			<div id="invalidName" class="text-danger"></div>
			<div class="form-group">
				<label for="gender">성별 *</label>
            <div class="gender-group">
                <label><input type="radio" name="gender" value="M" <c:if test="${gender == 'M'}">checked</c:if> required> 남자</label>
                <label><input type="radio" name="gender" value="F" <c:if test="${gender == 'F'}">checked</c:if>> 여자</label>
            </div>
			</div>
			<div class="form-group">
				<label for="phone">휴대전화 *</label> <input type="text" id="phone" value="${phoneNumber}"
					name="phone" required placeholder="010-XXXX-XXXX">

			</div>
			<div id="invalidPhone" class="text-danger"></div>
			<div class="form-group">
				<label for="email">이메일 *</label> <input type="email" id="email" value="${email}"
					name="email" required>
				<button type="button" id="auth-check" class="auth-check">이메일
					인증</button>
			</div>
			<div id="invalidEmail" class="text-danger"></div>
			<div class="form-group">
				<label for="birthYear">생년월일 *</label>
				<div class="birthdate-group">
					<input type="text" id="birthYear" name="birthYear" value="${birthYear}"
						placeholder="YYYY" maxlength="4" required> <input
						type="text" id="birthMonth" name="birthMonth" placeholder="MM" value="${birthMonth}"
						maxlength="2" required> <input type="text" id="birthDay"
						name="birthDay" placeholder="DD" maxlength="2" value="${birthDay}" required>
				</div>
			</div>
			<div class="form-group">
				<label for="zipcode">우편번호 *</label> <input type="text" id="zipcode"
					name="zipcode" required readonly>
				<button type="button" id="referrer-check" class="referrer-check">우편번호
					찾기</button>
			</div>
			<div class="form-group">
				<label for="address">주소 *</label> <input type="text" id="address"
					name="address" required readonly>
			</div>
			<div class="form-group">
				<label for="addressDetail">상세 주소</label> <input type="text"
					id="addressDetail" name="addressDetail">
			</div>
			<div class="page-container">
				<h3>Foodrawing 약관동의</h3>
				<div class="terms-container">
					<div class="all-terms-container">
						<div class="all-terms">
							<input type="checkbox" id="all-terms" onclick="checkAll(this)">
							<label for="all-terms" class="term-label">Foodrawing의 모든
								약관을 확인하고 전체 동의합니다.</label>
						</div>
					</div>
					<div class="terms-group">
						<div class="term-item">
							<input type="checkbox" name="terms" value="usage" required>
							<label class="term-label">이용약관 (필수)</label>
							<button type="button" class="view-btn"
								onclick="toggleTerms('usage')">보기</button>
						</div>
						<div id="usage" class="term-content">
							<p>
								제1조 목적<br>이 약관은 주식회사 더나음(전자상거래 사업자)가 운영하는 Foodrawing(이하
								“몰”이라 한다)에서 제공하는 인터넷 관련 서비스(이하 “서비스”라 한다)를 이용함에 있어 몰과 이용자의 권리․의무
								및 책임사항을 규정함을 목적으로 합니다.<br>※「PC통신, 무선 등을 이용하는 전자상거래에 대해서도 그
								성질에 반하지 않는 한 이 약관을 준용합니다.」
							</p>
							<p>
								제2조 서비스의 제공 및 변경<br>"몰"은 다음과 같은 업무를 수행합니다.<br>재화 또는
								용역에 대한 정보 제공 및 구매계약의 체결<br>구매계약이 체결된 재화 또는 용역의 배송<br>기타
								"몰"이 정하는 업무<br>"몰"은 재화 또는 용역의 품절 또는 기술적 사양의 변경 등의 경우에는 장차
								체결되는 계약에 의해 제공할 재화 또는 용역의 내용을 변경할 수 있습니다.
							</p>
							<p>
								제3조 회원가입<br>이용자는 "몰"이 정한 가입 양식에 따라 회원 정보를 기입한 후 이 약관에 동의한다는
								의사표시를 함으로써 회원가입을 신청합니다.<br>"몰"은 제1항과 같이 회원으로 가입할 것을 신청한 이용자
								중 다음 각 호에 해당하지 않는 한 회원으로 등록합니다.<br>가입 신청자가 이 약관 제7조 제3항에
								의하여 이전에 회원 자격을 상실한 적이 있는 경우<br>등록 내용에 허위, 기재누락, 오기가 있는 경우<br>기타
								회원으로 등록하는 것이 "몰"의 기술상 현저히 지장이 있다고 판단되는 경우
							</p>
							<p>
								제4조 회원 탈퇴 및 자격 상실 등<br>회원은 "몰"에 언제든지 탈퇴를 요청할 수 있으며 "몰"은 즉시
								회원 탈퇴를 처리합니다.<br>회원이 다음 각 호의 사유에 해당하는 경우, "몰"은 회원 자격을 제한 및
								정지시킬 수 있습니다.<br>가입 신청 시에 허위 내용을 등록한 경우<br>"몰"을 이용하여
								구입한 재화 등의 대금, 기타 "몰" 이용에 관련하여 회원이 부담하는 채무를 기일에 지급하지 않는 경우<br>다른
								사람의 "몰" 이용을 방해하거나 그 정보를 도용하는 등 전자상거래 질서를 위협하는 경우<br>"몰"을
								이용하여 법령 또는 이 약관이 금지하거나 공서양속에 반하는 행위를 하는 경우
							</p>
							<p>
								제5조 개인정보보호<br>"몰"은 이용자의 정보 수집 시 구매계약 이행에 필요한 최소한의 정보를
								수집합니다.<br>필수항목: 성명, 주소, 전화번호, 이메일 주소, 결제정보<br>선택항목:
								생년월일, 성별, 관심분야, 서비스 이용 기록<br>"몰"은 이용자의 개인정보를 수집·이용하는 때에는 당해
								이용자의 동의를 받습니다.<br>제공된 개인정보는 당해 이용자의 동의 없이 목적 외의 이용이나 제3자에게
								제공할 수 없으며, 이에 대한 모든 책임은 "몰"이 집니다.<br>"몰"이 제2항과 제3항에 의해 이용자의
								동의를 받아야 하는 경우에는 개인정보관리 책임자의 신원, 정보의 수집목적 및 이용목적, 제3자에 대한 정보 제공
								관련 사항 등을 미리 명시하거나 고지해야 하며 이용자는 언제든지 이 동의를 철회할 수 있습니다.
							</p>
						</div>
						<div class="term-item">
							<input type="checkbox" name="terms" value="privacy" required>
							<label class="term-label">개인정보 수집 및 이용 (필수)</label>
							<button type="button" class="view-btn"
								onclick="toggleTerms('privacy')">보기</button>
						</div>
						<div id="privacy" class="term-content">
							<p>
								제1조 개인정보의 수집 항목 및 수집 방법<br>수집 항목<br>필수항목: 성명, 주소,
								전화번호, 이메일 주소, 결제정보<br>선택항목: 생년월일, 성별, 관심분야, 서비스 이용 기록<br>수집
								방법<br>홈페이지 회원가입, 상품 구매, 고객문의, 이벤트 응모 등
							</p>
							<p>
								제2조 개인정보의 수집 및 이용 목적<br>회원 관리<br>회원제 서비스 이용 및 본인 확인<br>개인
								식별, 부정 이용 방지<br>서비스 제공 및 이행<br>상품 및 서비스 제공, 계약 이행, 요금
								결제<br>물품 배송, 본인 인증, 구매 및 요금 결제
							</p>
							<p>
								제3조 개인정보의 보유 및 이용 기간<br>보유 기간<br>회원 탈퇴 시까지 또는 관련 법령에
								따른 보존 기간까지<br>보유 이유<br>법령에 따른 보존 의무 이행, 분쟁 해결, 민원 처리
							</p>
							<p>
								제4조 개인정보의 제3자 제공<br>제공 대상 및 목적<br>배송업체: 물품 배송 목적<br>결제
								대행사: 요금 결제 목적<br>법령에 의한 경우: 법령에서 정한 목적<br>제공 항목<br>성명,
								주소, 전화번호, 결제 정보 등
							</p>
							<p>
								제5조 개인정보의 파기 절차 및 방법<br>파기 절차<br>목적 달성 후 내부 방침 및 기타 관련
								법령에 의한 정보 보호 사유에 따라 일정 기간 저장된 후 삭제<br>파기 방법<br>전자적 파일:
								기술적 방법을 이용하여 삭제<br>종이 문서: 분쇄기로 분쇄하거나 소각
							</p>
						</div>
					</div>
				</div>
			</div>
			           <!-- Hidden fields for social login -->
            <input type="hidden" id="provider" name="provider" value="${provider}">
            <input type="hidden" id="providerId" name="providerId" value="${providerId}">
			<button type="submit" id="signup-btn" class="signup-btn">회원가입</button>
		</form>
	</div>
</body>
</html>
