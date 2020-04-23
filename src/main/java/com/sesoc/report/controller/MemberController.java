package com.sesoc.report.controller;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sesoc.report.dao.MemberDAO;
import com.sesoc.report.vo.MemberVO;

@Controller
public class MemberController {
	
	@Autowired
	private MemberDAO dao;
	
	@RequestMapping(value = "main", method = RequestMethod.GET)
	public String main() {
		return "redirect:/";
	}
	
	
	//회원가입페이지 이동
	@RequestMapping(value = "boardsignup", method = RequestMethod.GET)
	public String boardsignup() {
		return "boardsignup";
	}
	
	//회원가입 후 메인페이지 이동
	@RequestMapping(value = "signup", method = RequestMethod.POST)
	public String signup(MemberVO vo, RedirectAttributes rttr) {
		boolean result = dao.signup(vo);
		rttr.addFlashAttribute("signupresult", result);
		return "redirect:/";
	}
	
	
	// 아이디 중복확인
	@ResponseBody
	@RequestMapping(value = "idcheck", method = RequestMethod.GET)
	public int idcheck(@RequestParam("user_id") String user_id) {
		
		return dao.idcheck(user_id);
	}
	
	//로그인 페이지 이동
	@RequestMapping(value = "boardlogin", method = RequestMethod.GET)
	public String boardlogin() {
		return "boardlogin";
	}
	
	//로그인 후 메인페이지 이동
	
	@RequestMapping(value = "login", method = RequestMethod.POST) 
	public String login(MemberVO vo, RedirectAttributes rttr, HttpSession session) {
	boolean result = dao.login(vo, session);
	if(result) return "redirect:/";
	rttr.addFlashAttribute("loginresult", result);
	
	return "redirect:boardlogin";
	}
	
	@RequestMapping(value = "logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
}
