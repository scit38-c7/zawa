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
import net.softsociety.zawa.vo.ProfileVO;

@Controller
public class PostController {

	@Autowired
	UserDAO userDao;

	@Autowired
	PostDAO postDao;

	@RequestMapping(value = "user", method = RequestMethod.GET)
	public String user(String u, HttpSession httpSession, Model model) {
		if (u == null || u.equals("")) {
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

	// 게시글 쓰기 화면
	@RequestMapping(value = "newpost", method = RequestMethod.GET)
	public String newpost() {
		return "dashboard/postWriteForm";
	}

	// 게시물 등록
	@RequestMapping(value = "newpost/write", method = RequestMethod.POST)
	public String write(PostVO vo, HttpSession httpSession) {
		String author = ((ProfileVO) httpSession.getAttribute("currentProfile")).getDisplayid();
		vo.setAuthor(author);
		postDao.createPost(vo);
		return "redirect:/user?u=" + author;
	}

	// 게시물 삭제
	@ResponseBody
	@RequestMapping(value = "deletePost", method = RequestMethod.GET)
	public void deletePost(PostVO vo, HttpSession httpSession) {
		String author = ((ProfileVO) httpSession.getAttribute("currentProfile")).getDisplayid();
		vo.setAuthor(author);
		postDao.deletePost(vo);
	}

	@RequestMapping(value = "search", method = RequestMethod.GET)
	public String user(String searchKeyword, Model model) {
		model.addAttribute("searchKeyword", searchKeyword);
		return "dashboard/search";
	}
	
	@ResponseBody
	@RequestMapping(value = "readSearchPage", method = RequestMethod.GET)
	public ArrayList<PostVO> readSearchPage(String searchKeyword,
			@RequestParam(value = "currentPage", defaultValue = "1") int currentPage) {
		ArrayList<PostVO> list = null;
		ScrollPageNavigator navi = postDao.getSearchNavi(currentPage, searchKeyword);
		list = postDao.getSearchPosts(searchKeyword, navi);
		return list;
	}
}
