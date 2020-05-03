package net.softsociety.zawa.controller;

import java.util.ArrayList;
import java.util.HashMap;

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
import net.softsociety.zawa.vo.LikeVO;
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

	/*
	 * @ResponseBody
	 * 
	 * @RequestMapping(value = "readTimelinePage", method = RequestMethod.GET)
	 * public ArrayList<PostVO> readTimelinePage(String id,
	 * 
	 * @RequestParam(value = "currentPage", defaultValue = "1") int currentPage) {
	 * ArrayList<PostVO> list = null; ScrollPageNavigator navi =
	 * postDao.getNavi(currentPage, id); list = postDao.getUserPosts(id, navi);
	 * return list; }
	 */

	@ResponseBody
	@RequestMapping(value = "readTimelinePage", method = RequestMethod.GET)
	public ArrayList<Object> readTimelinePage(String id,
			@RequestParam(value = "currentPage", defaultValue = "1") int currentPage, HttpSession httpSession) {
		ArrayList<Object> list = new ArrayList<>();
		ArrayList<PostVO> postList = null;
		ScrollPageNavigator navi = postDao.getNavi(currentPage, id);
		postList = postDao.getUserPosts(id, navi);
		if (postList == null)
			return null;
		for (PostVO p : postList) {
			HashMap<String, Object> map = new HashMap<>();
			map.put("post", p);
			map.put("user", userDao.getProfile(p.getAuthor()));
			map.put("likes", postDao.getLikeTotal(p.getPost_no()));
			map.put("liked", postDao.isLikedByMe(new LikeVO(
					((ProfileVO) httpSession.getAttribute("currentProfile")).getDisplayid(), p.getPost_no())));
			list.add(map);
		}
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

	// 검색 결과로 이동
	@RequestMapping(value = "search", method = RequestMethod.GET)
	public String user(String searchKeyword, Model model) {
		model.addAttribute("searchKeyword", searchKeyword);
		return "dashboard/search";
	}

	// 검색 결과 로드
	@ResponseBody
	@RequestMapping(value = "readSearchPage", method = RequestMethod.GET)
	public ArrayList<Object> readSearchPage(String searchKeyword,
			@RequestParam(value = "currentPage", defaultValue = "1") int currentPage, HttpSession httpSession) {
		ArrayList<Object> list = new ArrayList<>();
		ArrayList<PostVO> postList = null;
		ScrollPageNavigator navi = postDao.getSearchNavi(currentPage, searchKeyword);
		postList = postDao.getSearchPosts(searchKeyword, navi);
		if (postList == null)
			return null;
		for (PostVO p : postList) {
			HashMap<String, Object> map = new HashMap<>();
			map.put("post", p);
			map.put("user", userDao.getProfile(p.getAuthor()));
			map.put("likes", postDao.getLikeTotal(p.getPost_no()));
			map.put("liked", postDao.isLikedByMe(new LikeVO(
					((ProfileVO) httpSession.getAttribute("currentProfile")).getDisplayid(), p.getPost_no())));
			list.add(map);
		}
		return list;
	}

	@ResponseBody
	@RequestMapping(value = "getLikeTotal", method = RequestMethod.GET)
	public int getLikeTotal(int post_no) {
		int result = 0;
		result = postDao.getLikeTotal(post_no);
		return result;
	}

	@ResponseBody
	@RequestMapping(value = "like", method = RequestMethod.GET)
	public int like(LikeVO vo) {
		int result = 0;
		result = postDao.like(vo);
		return result;
	}

	@ResponseBody
	@RequestMapping(value = "unlike", method = RequestMethod.GET)
	public int unlike(LikeVO vo) {
		int result = 0;
		result = postDao.unlike(vo);
		return result;
	}

	@ResponseBody
	@RequestMapping(value = "toggleLike", method = RequestMethod.GET)
	public int toggleLike(LikeVO vo) {
		int result = 0;
		result = postDao.toggleLike(vo);
		return result;
	}

	@ResponseBody
	@RequestMapping(value = "isLikedByMe", method = RequestMethod.GET)
	public boolean isLikedByMe(LikeVO vo) {
		boolean result = false;
		result = postDao.isLikedByMe(vo);
		return result;
	}

	@ResponseBody
	@RequestMapping(value = "readLikesPage", method = RequestMethod.GET)
	public ArrayList<Object> readLikesPage(String id,
			@RequestParam(value = "currentPage", defaultValue = "1") int currentPage, HttpSession httpSession) {
		ArrayList<Object> list = new ArrayList<>();
		ArrayList<PostVO> postList = null;
		ScrollPageNavigator navi = postDao.getLikesNavi(currentPage, id);
		postList = postDao.getLikesPosts(id, navi);
		if (postList == null)
			return null;
		for (PostVO p : postList) {
			HashMap<String, Object> map = new HashMap<>();
			map.put("post", p);
			map.put("user", userDao.getProfile(p.getAuthor()));
			map.put("likes", postDao.getLikeTotal(p.getPost_no()));
			map.put("liked", postDao.isLikedByMe(new LikeVO(
					((ProfileVO) httpSession.getAttribute("currentProfile")).getDisplayid(), p.getPost_no())));
			list.add(map);
		}
		return list;
	}

	// 좋아요 페이지로 이동
	@RequestMapping(value = "likes", method = RequestMethod.GET)
	public String likes() {
		return "dashboard/likes";
	}
}
