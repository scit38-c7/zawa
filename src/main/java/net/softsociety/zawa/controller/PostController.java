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

import net.softsociety.zawa.dao.PostDAO;
import net.softsociety.zawa.dao.ScrollPageNavigator;
import net.softsociety.zawa.dao.UserDAO;
import net.softsociety.zawa.vo.PostVO;

@Controller
public class PostController {

	@Autowired
	UserDAO userDao;
	
	@Autowired
	PostDAO postDao;

	@RequestMapping(value = "user", method = RequestMethod.GET)
	public String user(String u, HttpSession httpSession, Model model) {
		if (u.equals("")) {
			model.addAttribute("viewingUser", httpSession.getAttribute("currentProfile"));
		} else {
			model.addAttribute("viewingUser", userDao.getProfile(u));
		}
		return "dashboard/timeline";
	}

	@ResponseBody
	@RequestMapping(value = "readTimelinePage", method = RequestMethod.GET)
	public ArrayList<PostVO> readTimelinePage(String id,
			@RequestParam(value = "currentPage", defaultValue = "1") int currentPage) {
		ArrayList<PostVO> list = null;
		ScrollPageNavigator navi = postDao.getNavi(currentPage, id);
		list = postDao.getUserPosts(id, navi);
		return list;
	}
}
