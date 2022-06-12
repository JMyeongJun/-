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
<script src="js/categoryList.js"></script>
<script>
	$(function(){
		$("#displayOption").val("${display}").prop("selected", true);
		$("#sortOption").val("${sortOption}").prop("selected", true);

		// 검색창 submit
		$("#searchForm").submit(function(event){
			var keyword = $("#keyword").val();
			if(keyword == ""){
				alert("검색어를 입력하세요.");
				event.preventDefault();
				return;
			}
		});
		
		alert('total: ' + ${total});
		alert('pageNum: ' + ${pageNum});
	});
	
	
	// sort, display 옵션 선택 시 동작
	function optionFormSubmit() {
		var optionForm = $("#optionForm");
		var html = $("<input type='hidden' name='searchOption' value=${searchOption} />")
		optionForm.append(html);			
		html = $("<input type='hidden' name='keyword' value=${keyword} />")
		optionForm.append(html);			
		
		optionForm.submit();
	}
</script>
</head>
<body>
	<div id="container">
		<div id="sidenav">
			<div id="side_top">
				<button>로그인</button>
				<button>장바구니</button>
				<button>주문내역</button>
				</div>
			<div id="side_bottom">
				<ul id="categoryList"></ul>
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
							<li><img src="${ book.image }" alt="" /></li>
							<li>제목: ${book.title}</li>
							<li>저자: ${book.author }</li>
							<li>지은이: ${book.publisher }</li>
						</ul>
					</div>
				</c:forEach>
			</div>
			<div id="pageBar" style="text-align: center; margin: 20px;">
				<button>a</button>
				<button>a</button>
				<button>a</button>
				<button>a</button>
			</div>
		</div>
	</div>
</body>
</html>