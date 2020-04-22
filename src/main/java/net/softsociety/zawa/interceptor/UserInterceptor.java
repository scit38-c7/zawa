package net.softsociety.zawa.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class UserInterceptor extends HandlerInterceptorAdapter {

	/**
	 * 현재 로그인된 Account 및 활성화된 Profile을 확인하여 필요 시 적당한 페이지로 리디렉션을 수행함.
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// 세션 영역에서 현재 접속 중인 Account의 id를 가져옴
		HttpSession session = request.getSession();
		String accountId = (String) session.getAttribute("accountId");
		String profileId = (String) session.getAttribute("profileId");

		// 로그인 상태가 아닐 경우 home으로 이동
		if (accountId == null) {
			System.out.println(request.getContextPath());
			response.sendRedirect(request.getContextPath() + "/");
			return false;
		}
		// TODO 활성화된 Profile이 없는 경우 존재하는 프로필 중 하나로 지정하여 타임라인으로 보냄
		if (profileId == null) {

		}

		// 세션에 문제가 없는 경우 컨트롤러의 로직을 수행
		return super.preHandle(request, response, handler);
	}
}
