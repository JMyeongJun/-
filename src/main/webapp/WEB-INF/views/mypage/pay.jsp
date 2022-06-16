<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/basic.css" />
<link rel="stylesheet" href="/css/pay.css" />
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<!-- daumPostcode -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	window.onload = function() {
		var IMP = window.IMP;
		IMP.init("imp19543974");
	}
	
	function btn(){
		alert(getAddress());
	}
	
	function getTimeStamp(){
		var now = new Date();
		var hours = now.getHours();
		var minutes = now.getMinutes();
		var seconds = now.getSeconds();
		var milliseconds = now.getMilliseconds();
		
		return ('' + hours + minutes + seconds + milliseconds);
	}
	
	function getAddress(){
		var address = $("#address").val();
		var detailAddress = $("#detailAddress").val();
		var extraAddress = $("#extraAddress").val();
		
		var ret = address + extraAddress + detailAddress;
		return ret;
	}
	
	// 결제
  function requestPay() {
	  // IMP.request_pay(param, callback) 결제창 호출
	  IMP.request_pay({ // param
      pg: "html5_inicis",
      pay_method: "card",
      merchant_uid: getTimeStamp(), // 같으면 안됨
      name: "${book.title}",
      amount: "${totalPrice}", // 가격
      buyer_email: "${email}",
      buyer_name: "${username}",
      buyer_tel: "${mobile}",
      buyer_addr: getAddress(),
      buyer_postcode: $("#postcode").val()
	  }, function (rsp) { // callback
      if (rsp.success) {
          /* ...,
          // 결제 성공 시 로직,
          ... */
          alert('결제완');
          var form = document.createElement('form');
          form.setAttribute('method', 'post');
          form.setAttribute('action', '/Mypage/PayComplete');
					form.append('<input type="hidden" name="zipcode" value=$("#postcode").val() />');
					form.append('<input type="hidden" name="address" value=getAddress() />');
					form.append('<input type="hidden" name="payment" value="${totalPrice}" />');
					form.append('<input type="hidden" name="isbn" value="${book.isbn}" />');
					form.append('<input type="hidden" name="quantity" value="${quantity}" />');
					
					document.body.appendChild(form);
					form.submit();
      } else {
         /*  ...,
          // 결제 실패 시 로직,
          ... */
          alert('결제실패');
      }
	  });
	}
	
	////////////////////////////////////////////////////
	function requestPayTest() {
		if($('#postcode').val() == ''){
			alert('주소를 입력하세요.');
			return
		}
		
		alert('결제완');
    var form = document.createElement('form');
    form.setAttribute('method', 'post');
    form.setAttribute('action', '/Mypage/PayComplete');
    
    var input = '';
    input += '<input type="hidden" name="zipcode" value="' + $("#postcode").val() + '" />';
    input += '<input type="hidden" name="address" value="' + getAddress() + '" />';
    input += '<input type="hidden" name="payment" value="${totalPrice}" />';
    input += '<input type="hidden" name="isbn" value="${book.isbn}" />';
    input += '<input type="hidden" name="quantity" value="${quantity}" />';
		form.innerHTML = input;
		document.body.appendChild(form);
		form.submit();
	}
	//////////////////////////////////////////////////////////////
  // 우편 번호 찾기
  function execDaumPostcode() {
  	new daum.Postcode({
   		popupTitle: '우편번호 찾기',
      oncomplete: function(data) {
	      var addr = ''; // 주소 변수
	      var extraAddr = ''; // 참고항목 변수
	
	      //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	      if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	          addr = data.roadAddress;
	      } else { // 사용자가 지번 주소를 선택했을 경우(J)
	          addr = data.jibunAddress;
	      }
	
	      if(data.userSelectedType === 'R'){
	        if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	            extraAddr += data.bname;
	        }
	        if(data.buildingName !== '' && data.apartment === 'Y'){
	            extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	        }
	        if(extraAddr !== ''){
	            extraAddr = ' (' + extraAddr + ')';
	        }
		      document.getElementById("extraAddress").value = extraAddr;
		    } else {
		      document.getElementById("extraAddress").value = '';
		    }
	      // 우편번호와 주소 정보를 해당 필드에 넣는다.
	      document.getElementById('postcode').value = data.zonecode;
	      document.getElementById("address").value = addr;
	      // 커서를 상세주소 필드로 이동한다.
	      document.getElementById("detailAddress").focus();
      }
  	}).open();
	}
</script>
</head>
<body>
	<div id="container">
		<div id="sidenav">
			<div id="side_top"><%@ include file="/WEB-INF/include/sideTop.jsp" %></div>
			<div id="side_bottom">
				<ul id="sideList">
					<li><a href="/Mypage/Cart">장바구니</a></li>
					<li><a href="/Mypage/OrderList">주문내역</a></li>
				</ul>
			</div>
		</div>
		<div id="top">
			<h1><a href="/">책방</a></h1>
			<div id="top_bottom"><%@ include file="/WEB-INF/include/topBottom.jsp" %></div>
		</div>
		<div id="main">
			<div id="pay_main">
				<table id="bookTable">
					<tr>
						<th colspan="2">상품</th>
						<th>수량</th>
						<th>상품금액</th>
						<th>합계</th>
					</tr>
					<tr>
						<td><img src="${book.image }" alt="" /></td>
						<td>${book.title }</td>
						<td>${quantity}</td>
						<td>${book.price } 원</td>
						<td>${totalPrice} 원</td>
					</tr>
				</table>
				<hr />
				<div id="postnPay">
					<div id="postSearch">
						<input type="text" id="postcode" placeholder="우편번호">
						<input type="button" class="btn" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
						<input type="text" id="address" placeholder="주소"><br />
						<input type="text" id="extraAddress" placeholder="참고항목"><br />
						<input type="text" id="detailAddress" placeholder="상세주소">
					</div>
					<div id="pay">
						<p id="totalPrice">최종 결제금액: ${totalPrice} 원</p>
						<input type="button" onclick="requestPayTest()" id="payBtn" class="btn" value="결제">
					</div>
				</div>
				<hr />
			</div>
		</div>
	</div>
</body>
</html>