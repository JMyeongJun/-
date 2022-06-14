<%@page import="com.bookroom.book.vo.BookVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/basic.css" />
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="/js/categoryList.js"></script>
<script>
	$(function(){
		// 로그인버튼 관련
		if("${username}" != "") {
			$("#login").attr("href", "/Login/Logout");
			$("#login button").html("로그아웃");
		}
		
		// 선택된 카테고리 찾기
		$("#categoryList li a").each(function(index, item){
			if((${keyword} == item.id) && ("${searchOption}" == "catg")){
				$("#searchKeyword").html('"' + item.innerHTML + '"');
				item.className = "active";
			}
		});
		
		// option 선택 반영
		$("#displayOption").val("${display}").prop("selected", true);
		$("#sortOption").val("${sortOption}").prop("selected", true);
		
		// pagingBar
		var pageNum = ${pageNum};
		var total = ${total};
		var display = ${display};
		var totalPage = Math.ceil(total / display);
		var pagingHTML = '<button onclick="pagingBtn(this)"><<</button>';
		for(var i = parseInt((pageNum - 1) / 10) * 10 + 1; i <= (parseInt((pageNum - 1) / 10) + 1) * 10; i++){
			if(i > totalPage || display * i > 1000){
				break;
			}
			if(pageNum == i){
				pagingHTML += '<button class="active" onclick="pagingBtn(this)">' + i + '</button>';
			}else{
				pagingHTML += '<button onclick="pagingBtn(this)">' + i + '</button>';
			}
		}
		pagingHTML += '<button onclick="pagingBtn(this)">>></button>';
		$("#pagingBar").append(pagingHTML);

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
	
	// pagingBar Btn onclick()
	function pagingBtn(btn) {
		$("#optionForm input").remove();
		var pageGo = btn.innerHTML;
		if(pageGo == "&lt;&lt;"){
			pageGo = parseInt((${pageNum} - 11) / 10) * 10 + 1;
			if(pageGo < 1){
				pageGo = 1;
			}
		}else if(pageGo == "&gt;&gt;"){
			pageGo = parseInt((${pageNum} + 9) / 10) * 10 + 1;
			if(pageGo > ${total} || ${display} * pageGo > 1000){
				alert('마지막 페이지 입니다.');
				return;
			}
		}
		var optionForm = $("#optionForm");
		var html = $("<input type='hidden' name='pageNum' value=" + pageGo + " />");
		optionForm.append(html);
		optionFormSubmit();
	}
	
	// sort, display 옵션 선택 시 동작
	function optionFormSubmit() {
		var optionForm = $("#optionForm");
		var html = $("<input type='hidden' name='searchOption' value=${searchOption} />")
		optionForm.append(html);			
		html = $("<input type='hidden' name='keyword' value=${keyword} />")
		optionForm.append(html);			
		
		optionForm.submit();
	}
	
	// 해당 책 정보(BookVo) 전달
	function viewSubmit() {
		$("#prodform").submit();
	}
</script>
<style>
	.active {background-color: yellow;}
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
				<ul id="sideList"></ul>
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
				  <input type="text" name="keyword" id="keyword" autocomplete='off' placeholder="검색" />
				  <input type="submit" class="btnOk" value="검색" />
				</form>
			</div>
		</div>
		<div id="main">
			<h2 id="searchKeyword" style="display: inline">"${keyword}"</h2>검색내용에 대한 검색결과
			<!-- -    정렬기능 : 정확도순, 신상품순, 최저가순 클릭시 정렬 -->
			<form action="/Search" id="optionForm" style="display: inline;">
				<select name="sortOption" id="sortOption" onchange="optionFormSubmit()">
					<option value="sim">유사도순</option>
					<option value="date">출간일순</option>
					<option value="count">판매량순</option>
				</select>
				<select name="display" id="displayOption" onchange="optionFormSubmit()">
				 <option value="10">10개</option>
				 <option value="20">20개</option>
				 <option value="30">30개</option>
				 <option value="40">40개</option>
				</select>
			</form>
			
			<!-- 검색결과물  -->
			<div id="bookList">
				<c:forEach var="book" items="${bookList}">
					<div>
						<ul>
							<li><a href="/Search/Prod?isbn=${book.isbn}"><img src="${ book.image }" alt="book_img" class="btn"/></a></li>
							<li class="btn" ><a href="/Search/Prod?isbn=${book.isbn}">제목: ${book.title}</a></li>
							<li>저자: ${book.author }</li>
							<li>지은이: ${book.publisher }</li>
						</ul>
					</div>
				</c:forEach>
			</div>
			<div id="pagingBar" style="text-align: center; margin: 20px;">
			</div>
		</div>
	</div>
</body>
</html>