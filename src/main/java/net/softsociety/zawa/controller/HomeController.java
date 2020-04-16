package net.softsociety.zawa.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * 홈 컨트롤러
 * <p>
 * 도메인의 최상위 페이지로서 로그인 폼을 포함하는 home으로 연결한다.
 * </p>
 */
@Controller
public class HomeController {

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		return "home";
	}
}
