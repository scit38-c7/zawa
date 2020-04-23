package com.sesoc.report.dao;

import com.sesoc.report.vo.MemberVO;

public interface MemberMapper {

	//회원가입 인터페이스
	public int signup(MemberVO vo);
	//아이디 중복확인
	public int idcheck(String user_id);
	//로그인 인터페이스
	public int login(MemberVO vo);
	
}
