<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="/WEB-INF/views/layout/header.jsp"%>
<%@include file="/WEB-INF/views/layout/myHeader.jsp"%>
<div class="sool-delviery-header-title">새 배송지를 추가해주세요</div>

<form action="${pageContext.request.contextPath }/delivery/insert"
	onsubmit="return check(this);" method="post" name="find">
	<table>
		<tr>
			<td><input type="text" id="deliveryPname" placeholder="수령인"
				name="mngdeliveryPname"></td>
		</tr>

		<tr>
			<td><input type="text" id="sample6_postcode" placeholder="우편번호"
				name="mngdeliveryZipcode"></td>
			<td><input type="button" onclick="sample6_execDaumPostcode()"
				value="우편번호 찾기" name=></td>
		</tr>

		<tr>
			<td><input type="text" id="sample6_address" placeholder="주소"
				name="mngdeliveryAddress"> <br> <input type="text"
				id="sample6_detailAddress" placeholder="상세주소"
				name="mngdeliveryDetail"></td>
		</tr>

		<tr>
			<td><input type="text" id="addressMemo" placeholder="배송메모(선택)"
				name="mngdeliveryMemo"> <br> <input type="text"
				id="deliveryDname" placeholder="배송지명(선택)" name="mngdeliveryDname"></td>
		</tr>

		<tr>
			<td>기본배송지 여부 <input type="checkbox" id="addressYN"
				placeholder="기본배송지 여부" name="check"></td>
		</tr>

		<tr>
			<td><input type="submit" value="저장하기" id="add"></td>
			<td><input type="submit" value="취소" id="back"
				onclick="location.href${pageContext.request.contextPath}/delivery/form"></td>
		</tr>
	</table>
</form>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	function check(f){
		if(f.mngdeliveryAddress.value == ''){
			alert("주소를 입력 하십시오!");
			return false;
		}
		if(f.mngdeliveryDetai.value == ''){
			alert("상세주소를 입력 하십시오!");
			return false;
		}
		if(f.mngdeliveryPname.value == ''){
			alert("수신인 성함을 입력 하십시오!");
			return false;
		}
		return true;
	}
	function sample6_execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

						// 각 주소의 노출 규칙에 따라 주소를 조합한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var addr = ''; // 주소 변수
						var extraAddr = ''; // 참고항목 변수

						//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
						if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
							addr = data.roadAddress;
						} else { // 사용자가 지번 주소를 선택했을 경우(J)
							addr = data.jibunAddress;
						}

						// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
						if (data.userSelectedType === 'R') {
							// 법정동명이 있을 경우 추가한다. (법정리는 제외)
							// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
							if (data.bname !== ''
									&& /[동|로|가]$/g.test(data.bname)) {
								extraAddr += data.bname;
							}
							// 건물명이 있고, 공동주택일 경우 추가한다.
							if (data.buildingName !== ''
									&& data.apartment === 'Y') {
								extraAddr += (extraAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}
							// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
							if (extraAddr !== '') {
								extraAddr = ' (' + extraAddr + ')';
							}
							// 조합된 참고항목을 해당 필드에 넣는다.
							//document.getElementById("sample6_extraAddress").value = extraAddr;

						} else {
							//document.getElementById("sample6_extraAddress").value = '';
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('sample6_postcode').value = data.zonecode;
						document.getElementById("sample6_address").value = (addr + ' ' + extraAddr);
						// 커서를 상세주소 필드로 이동한다.
						document.getElementById("sample6_detailAddress")
								.focus();
					}
				}).open();
	}
</script>
<%@include file="/WEB-INF/views/layout/footer.jsp"%>