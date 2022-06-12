 $.getJSON('/json/category.json', function(data) {
		let html = "";
		
		for (key in data) {
			let categoryId = data[key].Column1;
			let categoryName = data[key].Column2; 
			
			if(categoryId.toString().length == 3){
				html += '<li><a href="/Category?categoryId=' + categoryId + '">' + categoryName + '</a></li>';
				//html += '<li><a href="">카테고리</a></li>'
			}
		}
		
		$("#categoryList").append(html);
	});