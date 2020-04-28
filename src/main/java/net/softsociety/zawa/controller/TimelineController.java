package net.softsociety.zawa.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import net.softsociety.zawa.dao.ScrollPageNavigator;
import net.softsociety.zawa.dao.UserDAO;
import net.softsociety.zawa.vo.PostVO;

@Controller
public class TimelineController {

	@Autowired
	UserDAO userDao;

	@RequestMapping(value = "profiles/selectProfile", method = RequestMethod.GET)
	public String selectProfile(String displayid, HttpSession httpSession) {
		httpSession.setAttribute("currentProfile", userDao.getProfileId(displayid));
		return "redirect:/user?u=" + displayid;
	}

	@RequestMapping(value = "user", method = RequestMethod.GET)
	public String user(String u, HttpSession httpSession, Model model) {
		if (u.equals("")) {
			model.addAttribute("viewingUserId", httpSession.getAttribute("currentProfile"));
		} else {
			model.addAttribute("viewingUser", u);
			model.addAttribute("viewingUserId", userDao.getProfileId(u));
		}
		return "dashboard/timeline";
	}

	@ResponseBody
	@RequestMapping(value = "readTimelinePage", method = RequestMethod.GET)
	public ArrayList<PostVO> readTimelinePage(String id,
			@RequestParam(value = "currentPage", defaultValue = "1") int currentPage) {
		ArrayList<PostVO> list = null;

		return list;
	}
}
