package com.bookroom.mypage.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.bookroom.book.vo.BookVo;
import com.bookroom.mypage.service.MypageService;
import com.bookroom.mypage.vo.MypageVo;
import com.bookroom.search.service.SearchService;

@Controller
@RequestMapping("/Mypage")
public class MypageController {

	@Autowired
	private MypageService mypageService;
	@Autowired
	private SearchService searchService;

	@RequestMapping("/Cart")
	public ModelAndView cart(HttpSession session) {

		ModelAndView mv = new ModelAndView();

		if (session.getAttribute("userid") == null) {
			System.out.println("session is null");
			mv.setViewName("redirect:/Login");
		} else {
			String user_id = (String) session.getAttribute("userid");
			List<MypageVo> userCart = mypageService.cartView(user_id);
			// String isbn = userCart.get(0).getBookName();
			mv.addObject("userCart", userCart);
			mv.setViewName("/mypage/cart");
		}

		return mv;
	}

	@RequestMapping("/OrderList")
	public ModelAndView orderedList(HttpSession session, @RequestParam HashMap<String, Object> map) {

		ModelAndView mv = new ModelAndView();

		if (session.getAttribute("userid") == null) {
			System.out.println("session is null");
			mv.setViewName("redirect:/Login");
		} else {
			String userid = (String) session.getAttribute("userid");

			// 전체조회
			if (map.isEmpty()) {
				List<MypageVo> list = mypageService.getOrderList(userid);
				mv.addObject("list", list);
				mv.setViewName("/mypage/orderlist");
			// 특정기간 조회
			} else {
				List<MypageVo> list = mypageService.getOrderListByPeriod(map, userid);
				mv.addObject("list", list);
				mv.setViewName("/mypage/orderlist");
				return mv;
			}
		}
		return mv;
	}

	@RequestMapping("/Pay")
	public ModelAndView pay(HttpSession session, String isbn, String quantity) {

		ModelAndView mv = new ModelAndView();

		if (session.getAttribute("userid") == null) {
			System.out.println("session is null");
			mv.setViewName("redirect:/Login");
		} else {
			BookVo book = searchService.searchBookByISBN(isbn);
			mv.addObject("book", book);
			mv.addObject("quantity", quantity);
			mv.addObject("totalPrice", Integer.parseInt(book.getPrice()) * Integer.parseInt(quantity));
			mv.setViewName("/mypage/pay");
		}

		return mv;
	}
	
	@RequestMapping("/PayComplete")
	public ModelAndView payComplete(HttpSession session, String zipcode, String address, String payment, String isbn, String quantity) {
		
		ModelAndView mv = new ModelAndView();
		
		mypageService.insertOrder((String)session.getAttribute("userid"), zipcode, address, payment, isbn, quantity);
		
		mv.setViewName("redirect:/");
		
		return mv;
	}
}
