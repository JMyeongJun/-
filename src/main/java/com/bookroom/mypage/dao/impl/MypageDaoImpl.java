package com.bookroom.mypage.dao.impl;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bookroom.mypage.dao.MypageDao;
import com.bookroom.mypage.vo.MypageVo;

@Repository
public class MypageDaoImpl implements MypageDao{

	@Autowired
	private SqlSession sqlSession;
	
	// 주문조회
	@Override
	public List<MypageVo> getOrderList(String userid) {
		List<MypageVo> getOrderList = sqlSession.selectList("OrderList.GetOrderList", userid);
		
		return getOrderList;
	}
	@Override
	public List<MypageVo> userView(String UserNum) {
		List<MypageVo> userView = sqlSession.selectList( "User.UserSelect", UserNum );
		return userView;
	}
	@Override
	public List<MypageVo> getOrderListByPeriod(HashMap<String, Object> map, String userid) {
		
		System.out.println("적용됨");
		map.put("userid", userid);
		List<MypageVo> list =  sqlSession.selectList("OrderList.getOrderListByPeriod", map);
		System.out.println(list);
		return list;
	}
	
}