package com.bookroom.search.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bookroom.search.service.SearchService;
import com.bookroom.search.vo.SearchVo;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;

@Controller
@RequestMapping("/Search")
public class SearchController {

	@Autowired
	private SearchService newsService;

	// 검색버튼 눌렸을 때
	@RequestMapping
	@ResponseBody
	public ModelAndView search(String keyword, String searchOption, String sortOption, String display, String pageNum) throws JsonMappingException, JsonProcessingException {
		
		if(sortOption == null) {
			sortOption = "sim";
		}
		if(display == null) {
			display = "10";
		}
		if(pageNum == null) {
			pageNum = "1";
		}
		
		ModelAndView mv = new ModelAndView();
		
		SearchVo searchVo = newsService.searchBooks(keyword, searchOption, sortOption, display, pageNum);
		
		mv.addObject("keyword", keyword);
		mv.addObject("searchOption", searchOption);
		mv.addObject("sortOption", sortOption);
		mv.addObject("display", searchVo.getDisplay());
		mv.addObject("pageNum", pageNum);
		mv.addObject("total", searchVo.getTotal());
		mv.addObject("bookList", searchVo.getItems());
		
		mv.setViewName("search");
		return mv;
	}
	
	@RequestMapping("/Prod")
	public ModelAndView prod(String title, String price) {
		ModelAndView mv = new ModelAndView();
		
		System.out.println(title);
		System.out.println(price);
		
		mv.setViewName("search");
		return mv;
	}
}
