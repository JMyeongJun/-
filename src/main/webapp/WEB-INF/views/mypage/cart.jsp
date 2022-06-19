<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/basic.css" />
<link rel="stylesheet" href="/css/cart.css" />
<link rel="shortcut icon" type="image/x-icon" href="/img/favicon.ico" />
<title>책방</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
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
        priceSumEl.innerHTML = quantity * price + '원';
        totalEl.innerHTML    = totalPrice + '원';
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
	       priceSumEl.innerHTML = priceSum + '원';
	       totalPrice += priceSum;
	     }
    
    	totalEl.innerHTML = totalPrice + '원';
   })
   
   function movePay() {
      
         let size       = ${size};
         
         if (size == 0) {
        	 return;
         }
         
         for (var i = 0; i < size; i++) {
            let quantityEl = document.getElementById('bookQuantityCnt' + i);
            let submitQuantityEl = document.getElementById('subQuantity' + i);
            let quantity   = quantityEl.value;
            submitQuantityEl.value = quantity;
         }
      $("#movePayForm").submit();
   }
   
</script>
</head>
<body>
   <div id="container">
      <div id="sidenav">
         <div id="side_top"><%@ include file="/WEB-INF/include/sideTop.jsp" %></div>
         <div id="side_bottom">
            <ul id="categoryList">
               <li><a href="/Mypage/Cart" class="active">장바구니</a></li>
               <li><a href="/Mypage/OrderList">주문내역</a></li>
            </ul>
         </div>
      </div>
      <div id="top">
         <h1>
            <a href="/">책방</a>
         </h1>
         <div id="top_bottom"><%@ include file="/WEB-INF/include/topBottom.jsp" %></div>
      </div>
      <div id="main">
         <h2>${username}cart</h2>
         <table>
         	<tr>
             <th colspan="2">상품</th>
             <th>상품 금액</th>
             <th>수량</th>
             <th>합계</th>
             <th></th>
         	</tr>
            <form action="/Mypage/Pay?cart=true" id="movePayForm">
               <c:forEach var="userCart" items="${ userCart }" varStatus="status">
                  <tr style="border-bottom: 1px solid black;">
                     <td><img src=${ userCart.img }></td>
                     <td>
                        <div id="bookInfo">
                           <div id="bookName">${ userCart.bookName }</div>
                           <div id="bookAuth">작가: ${ userCart.auth }</div>
                           <div id="bookPublisher">출판사: ${ userCart.publisher }</div>
                        </div>
                     </td>
                     <td id="bookPrice${status.index}">${ userCart.price}</td>
                     <td>
                        <div id="bookQuantityCount">
                           <input type="button" onclick="count(${status.index},-1)"value="-" />
                           <input type="number" id="bookQuantityCnt${status.index}"value="${ userCart.quantity }"> 
                           <input type="button" onclick="count(${status.index},1)" value="+" />
                        </div>
                     </td>
                     <td id="total${status.index}"></td>
                     <td><a href="/Mypage/Delete?isbn=${userCart.isbn}"id="btnDelete">삭제</a></td>
                     <input type="hidden" name="isbn" value="${userCart.isbn}" />
                     <input type="hidden" name="quantity" id="subQuantity${status.index}" value="" />
                  </tr>
               </c:forEach>
            </form>
         </table>
         <div id="tot">총 결제금액: </div>
         <div id="totalPrice"></div>
         <div id="movePay"><a href="javascript:void(0)" onclick="movePay()">주문하기</a></div>
      </div>
   </div>
</body>
</html>