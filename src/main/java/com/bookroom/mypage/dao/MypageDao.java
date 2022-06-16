package com.bookroom.mypage.dao;

import java.util.HashMap;
import java.util.List;

import com.bookroom.mypage.vo.MypageVo;

public interface MypageDao {

	List<MypageVo> getOrderList(String userid);

	List<MypageVo> userView(String userNum);

	List<MypageVo> getOrderListByPeriod(HashMap<String, Object> map, String userid);
}
