package net.softsociety.zawa.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import net.softsociety.zawa.dao.UserDAO;
import net.softsociety.zawa.vo.AccountVO;

/**
 * 계성, 프로필 관련 컨트롤러
 * <p>
 * Account를 등록 및 인증하거나 Profile을 등록 및 관리하는 기능을 담당한다.
 * </p>
 */
@Controller
public class UserController {
	@Autowired
	UserDAO dao;

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
	@RequestMapping(value = "/signup/createAccount", method = RequestMethod.POST)
	public String createAccount(AccountVO vo, String pw, RedirectAttributes rttr) {
		if (dao.createAccount(vo, pw)) {
			rttr.addFlashAttribute("signupSuccess", true);
			return "redirect:/";
		} else {
			rttr.addFlashAttribute("signupFailed", true);
			return "redirect:/signup";
		}
	}

	/**
	 * 계정 중복 확인
	 * <p>
	 * 비동기 통신을 이용하여 기존 회원과의 이메일 중복 여부를 확인한다.
	 * </p>
	 */
	@ResponseBody
	@RequestMapping(value = "/signup/findDuplicateEmail", method = RequestMethod.POST)
	public boolean findDuplicateEmail(String email) {
		return dao.findAccountByEmail(email);
	}
}
