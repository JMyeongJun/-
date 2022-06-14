package com.bookroom.mypage.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/Mypage")
public class MypageController {

	@RequestMapping("/Cart")
	public ModelAndView cart(HttpSession session) {

		ModelAndView mv = new ModelAndView();

		if (session.getAttribute("userid") == null) {
			System.out.println("session is null");
			mv.setViewName("redirect:/Login");
		} else {
			// mv.addObject("username", session.getAttribute("username"));
			mv.setViewName("/mypage/cart");
		}

		return mv;
	}

	@RequestMapping("/OrderList")
	public ModelAndView orderedList(HttpSession session) {

		ModelAndView mv = new ModelAndView();

		if (session.getAttribute("userid") == null) {
			System.out.println("session is null");
			mv.setViewName("redirect:/Login");
		} else {
			//mv.addObject("username", session.getAttribute("username"));
			mv.setViewName("/mypage/orderlist");
		}

		return mv;
	}
	
	@RequestMapping("/Pay")
	public ModelAndView pay(HttpSession session) {

		ModelAndView mv = new ModelAndView();

		if (session.getAttribute("userid") == null) {
			System.out.println("session is null");
			mv.setViewName("redirect:/Login");
		} else {
			//mv.addObject("username", session.getAttribute("username"));
			mv.setViewName("/mypage/pay");
		}

		return mv;
	}
}
