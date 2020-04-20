package net.softsociety.zawa.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * 계성, 프로필 관련 컨트롤러
 * <p>
 * Account를 등록 및 인증하거나 Profile을 등록 및 관리하는 기능을 담당한다.
 * </p>
 */
@Controller
public class UserController {

	/**
	 * 계정 등록 페이지 이동
	 * <p>
	 * Account 등록을 위한 페이지로 이동한다
	 * </p>
	 */
	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public String signup() {
		return "user/createAccountForm";
	}

	/**
	 * 계정 신규 등록 쿼리
	 * <p>
	 * 계정을 신규 등록하는 쿼리를 보내어, id를 성공적으로 부여 받은 경우 등록 완료 페이지로 이동한다.
	 * </p>
	 */
	@RequestMapping(value = "/createAccount", method = RequestMethod.POST)
	public String createAccount() {
		
		return "redirect: /";
	}
}
