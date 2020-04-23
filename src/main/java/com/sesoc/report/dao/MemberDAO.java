package com.sesoc.report.dao;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sesoc.report.vo.MemberVO;

@Repository
public class MemberDAO {

	@Autowired
	private SqlSession sqlSession;
	
	
	//회원가입 dao
	public boolean signup(MemberVO vo) {
		int result = 0;
		
		try {
			MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
			result = mapper.signup(vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(result == 0) return false;
		else return true;
	}
	
	//아이디 중복체크
	public int idcheck(String user_id) {
		int result = 0;
		
		try {
			MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
			result = mapper.idcheck(user_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	//로그인 dao
	public boolean login(MemberVO vo, HttpSession session) {
		int result = 0;
		
		try {
			MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
			result = mapper.login(vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		if(result == 0) return false;
		session.setAttribute("user_id", vo.getUser_id());
		return true;
	}
}
