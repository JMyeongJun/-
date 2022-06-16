<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/basic.css" />
<link rel="shortcut icon" type="image/x-icon" href="/img/favicon.ico" />
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
   $(function(){
      // 로그인버튼 관련
      if("${username}" != "") {
         $("#login").attr("href", "/Login/Logout");
         $("#login button").html("로그아웃");
      }
      
      // 검색창 submit 제한
      $("#searchForm").submit(function(event){
         var keyword = $("#keyword").val();
         if(keyword == ""){
            alert("검색어를 입력하세요.");
            event.preventDefault();
            return;
         }
      });
   });
   
 
   // 수량 변경에 따른 가격표시
	function count(index,type)  {

		  let quantityEl    = document.getElementById('bookQuantityCnt' + index);
		  let priceEl       = document.getElementById('bookPrice'+ index);
		  let priceSumEl    = document.getElementById('total' + index);
		  let totalEl       = document.getElementById('totalPrice');
		 
		  let quantity      = quantityEl.value;
		  let price         = parseInt(priceEl.innerHTML); 
		  let totalPrice    = parseInt(totalEl.innerHTML);
		  
		  if(type == 1) {
			  quantity = parseInt(quantity) + 1;
			  totalPrice +=  price;
		  }else if(type == -1 && quantity > 0)  {
			  quantity = parseInt(quantity) - 1;
			  totalPrice -=  price;
		    	if(quantity <=0) {
		    		quantity = 0;	    		
		    	}
		  } 

		  quantityEl.value     = quantity;
		  priceSumEl.innerHTML = quantity * price;
		  totalEl.innerHTML = totalPrice;
	}
		  
	
   // 초기화면 가격표시
	$(function(){
	 	 let size       = ${size};
	 	 let totalEl    = document.getElementById('totalPrice');
	 	 let totalPrice = 0;

	 for (var i = 0; i < size; i++) {
		 let priceEl    = document.getElementById('bookPrice'+ i);
		 let priceSumEl = document.getElementById('total' + i);
		 let quantityEl = document.getElementById('bookQuantityCnt' + i);
	 	 let quantity   = quantityEl.value;
	 	 let price      = priceEl.innerHTML;
	 	 let priceSum   = quantity * price;
	 	 priceSumEl.innerHTML = priceSum;
	 	 totalPrice += priceSum;
	  }
	 
	 totalEl.innerHTML = totalPrice;
	})
   
   function movePay() {
		$("#movePayForm").submit();
			}
	
   
</script>

<style>
#main {
width:100%;
}
.hrBar {
width: 90%;

}
#prodInfo {
padding-left: 175px;
}
#prodPrice {
padding-left: 470px;
}
#prodCount {
padding-left: 250px;
}
 img{
 width:150px;
 float: left;
 margin-left: 100px;
 margin-top: 20px;
 margin-bottom: 20px;
 }
 #bookInfo {
 width:25%;
 float: left;
 margin-top: 50px;
 margin-left: 10px;
 }
 #bookPrice {
 float: left;
 margin-left: 75px;
 margin-top: 80px;
}
 #bookQuantityCount {
 float: left;
 }

 #bookQuantityCount {
 margin-left: 230px;
 margin-bottom: 50px;
 margin-top: 79px;
 }
 #bookQuantityCnt {
  width:90px;
  text-align: center;
 }
 
 #btnDelete{
 float:left;
 margin-left: 150px;
 margin-top: 79px;
 width:100px;
 height:30px;
 border: 0;
 outline: 0;
 }
 
 #totalPrice {
 width:200px;
 margin: 0 auto;
 padding-top: 50px;
 padding-bottom: 50px;
 }
 
 #btnBuy {
 width:200px;
 height:50px;
 margin-left: 620px;
 margin-bottom: 150px;
 background-color: #3498DB;
 border: 0;
 outline: 0;
 color: white;
 border-radius: 20px;
 }
</style>
</head>
<body>
   <div id="container">
      <div id="sidenav">
         <div id="side_top">
            <a href="/Login" id="login"><button>로그인</button></a>
            <a href="/Mypage/Cart"><button>장바구니</button></a>
            <a href="/Mypage/OrderList"><button>주문내역</button></a>
            <c:choose>
               <c:when test="${username != null}">
                  <div id="printname"  style="text-align:center;">${username}님</div>
             </c:when>
            </c:choose>
         </div>
         <div id="side_bottom">
            <ul id="sideList">
               <li><a href="/Mypage/Cart" class="active">장바구니</a></li>
               <li><a href="/Mypage/OrderList">주문내역</a></li>
               <li><a href="/Mypage/Pay">결제</a></li>
            </ul>
         </div>
      </div>
      <div id="top">
         <h1><a href="/">책방</a></h1>
         <div id="top_bottom">
            <form action="/Search" id="searchForm">
               <select name="searchOption" >
                 <option value="all">통합검색</option>
                 <option value="title">제목검색</option>
                 <option value="auth">저자검색</option>
              </select>
              <input type="hidden" name="pageNum" value="1" />
              <input type="text" name="keyword" id="keyword" autocomplete='off' placeholder="검색" />
              <input type="submit" class="btnOk" value="검색" />
            </form>
         </div>
      </div>
      <div id="main">
         <h2>${username} cart</h2>
         <hr style="width:90%">
         <span id="prodInfo">상품</span>
         <span id="prodPrice">상품금액</span>
         <span id="prodCount">수량</span> 
         <span>합계</span> 
         <form action="/Mypage/Pay" id="movePayForm">
         <c:forEach var="userCart" items="${ userCart }" varStatus="status">
            <hr class="hrBar">
            <div id="bookImage"><img src=${ userCart.img } ></div>
              <div id="bookInfo">   
               <div id="bookName">책 이름:${ userCart.bookName }</div>
               <div id="bookAuth">책 작가:${ userCart.auth }</div>
               <div id="bookPublisher">책 출판:${ userCart.publisher }</div>
            </div>
            <div id="bookPrice${status.index}">${ userCart.price }</div>
            <div id="bookQuantityCount">
            	<input type="button" onclick="count(${status.index},-1)" value="-" />						
         	    <input type="number" id="bookQuantityCnt${status.index}" value="${ userCart.quantity }">
				<input type="button" onclick="count(${status.index},1)" value="+" />
            </div>
            <div id="total${status.index}"></div>
            <a href="/Mypage/Delete?isbn=${userCart.isbn}" id="btnDelete">삭제</a>
            <input type="hidden" name="isbn" value="${userCart.isbn}" />
            <input type="hidden" name="quantity" value="${userCart.quantity}" />
         </c:forEach>
         </form>
         <div style="padding: 100px;">
         </div>
         <h2 id="totalPrice"></h2>
         <a href="javascript:void(0)" onclick="movePay()" style="font-size:30px";>주문하기</a>
      </div>
   </div>
</body>
</html>