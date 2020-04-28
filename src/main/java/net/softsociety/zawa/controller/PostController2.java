package net.softsociety.zawa.controller;

import java.util.ArrayList;
import java.util.StringTokenizer;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import net.softsociety.zawa.dao.PageNavigator;
import net.softsociety.zawa.dao.PostListDAO;
import net.softsociety.zawa.vo.PostTagVO;
import net.softsociety.zawa.vo.PostVO;
import net.softsociety.zawa.vo.ReplyVO;
import net.softsociety.zawa.vo.TagVO;

@Controller
public class PostController2 {

	@Autowired
	private PostListDAO dao;
	
	//게시글 리스트
	@RequestMapping(value = "postlist", method = {RequestMethod.GET, RequestMethod.POST})
	public String postlist(Model model,
			@RequestParam(name = "currentPage", defaultValue ="1") int currentPage,
			@RequestParam(value="searchItem", defaultValue ="title") String searchItem,
			@RequestParam(value="searchKeyword", defaultValue ="") String searchKeyword
			) {
		
		//페이징,검색
		PageNavigator navi = dao.getNavi(currentPage, searchItem, searchKeyword);
		ArrayList<PostVO> list = dao.PostList(searchItem, searchKeyword, navi);
		ArrayList<PostVO> hitlist = dao.hitRead();
		int post_no = dao.hitPost_no();
		ArrayList<TagVO> taglist = dao.getTag(post_no);
		String tag_name = "";
		for(TagVO tag : taglist) {
			tag_name += tag.getTag_name()+',';
		}
		ArrayList<ReplyVO> hitReplyList = dao.replyList(post_no);
		
		model.addAttribute("hitReplyList", hitReplyList);
		model.addAttribute("tag_name", tag_name);
		model.addAttribute("hitlist", hitlist);
		model.addAttribute("list", list);
		model.addAttribute("navi", navi);
		model.addAttribute("searchItem", searchItem);
		model.addAttribute("searchKeyword", searchKeyword);
		return "post";
	}
	
	//게시글 쓰기폼 이동
	@RequestMapping(value = "postWriteForm", method = RequestMethod.GET)
	public String postWriteForm() {
		return "postWriteForm";
	}
	
	//태그검색
	@RequestMapping(value = "tagSearch", method = RequestMethod.GET)
	public String tagSearch(String tag_name, Model model) {
				System.out.println("=========================================================="+tag_name);
		ArrayList<TagVO> taglist = new ArrayList<TagVO>();
		ArrayList<PostVO> tagSearchList = new ArrayList<PostVO>();
		String tag_names = "";
		ArrayList<PostVO> tagPostList = dao.tagSearch(tag_name);
		
				//확인용
				for(PostVO test123 : tagPostList) {
					System.out.println("========"+test123.toString());
				}
		
				
		for(PostVO tplPost_no : tagPostList) { 
			tagSearchList = dao.tagRead(tplPost_no);
			//확인용
			for(PostVO test2 : tagSearchList ) {
				System.out.println("@@@@@@@@@@"+test2.toString());
			}
			taglist = dao.getTag(tplPost_no.getPost_no());
		}
		
		/*
		 * for(PostVO tsl : tagSearchList) { PostVO vo1 = new PostVO(tsl.getPost_no(),
		 * tsl.getUser_id(), tsl.getTitle(), tsl.getContent(), tsl.getInputdate(),
		 * tsl.getHit(), tsl.getLike_cnt(), tsl.getOriginalFilename(),
		 * tsl.getSavedFilename()); }
		 */
		
		for(TagVO tag : taglist) {
			tag_names += tag.getTag_name()+',';
		}
				
		
		model.addAttribute("tag_name", tag_name);
		model.addAttribute("tag_names", tag_names);
		model.addAttribute("tagPostList", tagPostList);
		model.addAttribute("tagSearchList", tagSearchList);
		
		return "tagSearchForm";
	}
	
	//게시글 등록
	@RequestMapping(value = "postWrite", method = RequestMethod.POST)
	public String postWrite(String tag_name, PostVO vo, HttpSession session, RedirectAttributes rttr, MultipartFile uploadFile) {
		boolean result = false;
		if(dao.postWrite(vo, session, uploadFile) == 1) result = true;
		rttr.addFlashAttribute("writeResult", result);
		
		int post_no = dao.getPost_no();
		// 확인용 System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@" + post_no);
		//String[] tagList = tag_name.split("#", 0);
		
		/*
		 * for (int i = 0; i < tagList.length; i++) {
		 * System.out.println("==================================="+tagList[i]); }
		 */
		
		/*
		 * for(String tag : tagList) { 
		 * TagVO tagVO = dao.checkTag(tag); 
		 * if(tagVO == null) dao.insertTag(tag);
		 * int tag_id = dao.checkTag(tag).getTag_id(); 
		 * PostTagVO ptVO = new PostTagVO();
		 * ptVO.setPost_no(post_no); 
		 * ptVO.setTag_id(tag_id); 
		 * // 확인용  System.out.println("$$$$$$$$$$$$$$$$$"+ptVO); 
		 * dao.insertPostTag(ptVO); 
		 * }
		 */
		
		//split은 null까지 같이 인식해버리기떄문에 사용불가 StrignTokenizer로 사용
		StringTokenizer tokens = new StringTokenizer(tag_name, "#");
		int countTokens = tokens.countTokens();
		for (int i = 0; i < countTokens; i++) {
			String token_tag_name = tokens.nextToken();
				System.out.println("======================================"+token_tag_name);
			TagVO tagVO = dao.checkTag(token_tag_name); 
			if(tagVO == null) dao.insertTag(token_tag_name);
			int tag_id = dao.checkTag(token_tag_name).getTag_id(); 
			PostTagVO ptVO = new PostTagVO();
			ptVO.setPost_no(post_no); 
			ptVO.setTag_id(tag_id); 
				System.out.println("$$$$$$$$$$$$$$$$$"+ptVO);
			dao.insertPostTag(ptVO);
			token_tag_name= "";
		}
		
		return "redirect:/postlist";
	}
	
	//게시글 읽기
	@RequestMapping(value = "postRead", method = RequestMethod.GET)
	public String postRead(int post_no, Model model) {
		PostVO vo = dao.postRead(post_no);
		ArrayList<TagVO> taglist = dao.getTag(post_no);
		String tag_name = "";
		for(TagVO tag : taglist) {
			tag_name += tag.getTag_name()+",";
		}
		ArrayList<ReplyVO> replyList = dao.replyList(post_no);
		model.addAttribute("vo", vo);
		model.addAttribute("tag_name", tag_name);
		model.addAttribute("replyList", replyList);
		return "postRead";
	}
	
	
	//게시글 삭제
	@RequestMapping(value = "postDelete", method = RequestMethod.GET)
	public String postDelete(PostVO vo, HttpSession session, RedirectAttributes rttr) {
		boolean result = false;
		if(dao.postDelete(vo, session) != 0) result = true;
		rttr.addFlashAttribute("deleteResult", result);
		return "redirect:postlist";
	}
	
	//게시글 수정 화면 이동
	@RequestMapping(value = "postUpdateForm", method = RequestMethod.GET)
	public String postUpdateForm(int post_no, Model model) {
		PostVO vo = dao.postReader(post_no);
		model.addAttribute("vo", vo);
		
		return "postUpdate";
	}
	
	//게시글 수정 
	@RequestMapping(value = "postUpdate", method = RequestMethod.POST)
	public String postUpdate(PostVO vo, HttpSession session, RedirectAttributes rttr, MultipartFile uploadFile) {
		boolean result = false;
		if(dao.postUpdate(vo, session, uploadFile) != 0) result = true;
		rttr.addFlashAttribute("updateResult", result);
		
		return "redirect:postRead?post_no=" + vo.getPost_no();
	}
	
	// 댓글 등록
		@RequestMapping(value="replyWrite", method=RequestMethod.POST)
		public String replyWrite(ReplyVO vo, HttpSession session) {
			dao.replyWrite(vo, session);
			return "redirect:postRead?post_no=" + vo.getPost_no();
		}
		
	// 댓글 삭제
	@RequestMapping(value = "replyDelete", method = RequestMethod.GET)
	public String replyDelete(ReplyVO vo, HttpSession session) {
		dao.replyDelete(vo, session);
		return "redirect:postRead?post_no="+vo.getPost_no();
	}
	
	// 댓글 등록 인기글
	@RequestMapping(value="hitReplyWrite", method=RequestMethod.POST)
	public String hitReplyWrite(ReplyVO vo, HttpSession session) {
		dao.replyWrite(vo, session);
		return "redirect:postlist?post_no=" + vo.getPost_no();
	}
	
	// 댓글 삭제 인기글
	@RequestMapping(value = "hitReplyDelete", method = RequestMethod.GET)
	public String hitReplyDelete(ReplyVO vo, HttpSession session) {
		dao.replyDelete(vo, session);
		return "redirect:postlist?post_no="+vo.getPost_no();
	}
	
	//좋아요
	@RequestMapping(value = "like_check", method = RequestMethod.GET)
	public String like_check(ReplyVO vo, HttpSession session) {
		dao.replyDelete(vo, session);
		return "redirect:postRead?post_no="+vo.getPost_no();
	}
}
