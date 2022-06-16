package com.bookroom.mypage.service;

import java.util.HashMap;
import java.util.List;

import com.bookroom.mypage.vo.MypageVo;

public interface MypageService {

	List<MypageVo> getOrderList(String userid);

	List<MypageVo> cartView(String user_id);

	List<MypageVo> getOrderListByPeriod(HashMap<String, Object> map, String userid);
}
