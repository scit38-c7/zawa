package com.sesoc.report.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.StringTokenizer;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sesoc.report.dao.PageNavigator;
import com.sesoc.report.dao.PostListDAO;
import com.sesoc.report.vo.LikeVO;
import com.sesoc.report.vo.PostTagVO;
import com.sesoc.report.vo.PostVO;
import com.sesoc.report.vo.ReplyVO;
import com.sesoc.report.vo.TagVO;

@Controller
public class PostController {

	@Autowired
	private PostListDAO dao;
	
	//게시글 리스트
	@RequestMapping(value = "postlist", method = {RequestMethod.GET, RequestMethod.POST})
	public String postlist(Model model,HttpSession session,
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
		
		LikeVO likeVO = new LikeVO();
		
		String user_id = (String)session.getAttribute("user_id");
		if(user_id != null){
			HashMap<String, Object> hashMap = new HashMap<String, Object>();
			hashMap.put("post_no", post_no);
			hashMap.put("user_id", user_id); 
			if(dao.countbyLike(hashMap) == 0) {
				dao.create(hashMap);
			}
			
			likeVO = dao.like_read(hashMap);
		}
		
	    PostVO vo = dao.postRead(post_no);
		
		ArrayList<ReplyVO> hitReplyList = dao.replyList(post_no);
		int replyCnt = dao.replyCnt(post_no);
		
		model.addAttribute("replyCnt", replyCnt);
		model.addAttribute("like_check", likeVO.getLike_check());
		model.addAttribute("like_cnt", vo.getLike_cnt());
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
	public String tagSearch(String tag_name, Model model, HttpSession session) {
		
		ArrayList<PostVO> tagPostList = dao.tagSearch(tag_name);
		ArrayList<PostVO> tagSearchList = new ArrayList<PostVO>();
		ArrayList<PostVO> tpList = new ArrayList<PostVO>();
		LikeVO likeVO = new LikeVO();
		
		String user_id = (String)session.getAttribute("user_id");
			//게시글 번호및 데이터 가져오기
			for(PostVO tplPost_no : tagPostList) { 
			tpList = dao.tagRead(tplPost_no);
			for (PostVO t : tpList) {
				tagSearchList.add(t);
			}
			
			if(user_id != null){
				HashMap<String, Object> hashMap = new HashMap<String, Object>();
				hashMap.put("post_no", tplPost_no.getPost_no());
				hashMap.put("user_id", user_id); 
				if(dao.countbyLike(hashMap) == 0) {
					dao.create(hashMap);
				}
				
				likeVO = dao.like_read(hashMap);
			}
		}
			
		//해시태그
		ArrayList<HashMap<String,Object>> mapList = dao.allPost(tag_name);
		System.out.println("==================="+mapList);
		ArrayList<HashMap<String,Object>> sList = new ArrayList<>(); 
		
		for(HashMap<String,Object> map : mapList) {
			try {
					String seq = String.valueOf(map.get("POST_NO"));
					int post_no = Integer.parseInt(seq);
					sList.addAll(dao.getTagName(post_no));
			} catch (NumberFormatException e) {
			} catch (Exception e) {
			}
		}
		System.out.println("태그리스트 확인 : "+ sList);
			
			
		
		//댓글 정보
		ArrayList<HashMap<String,Object>> tagCommentList = dao.tagComment(tag_name);
		System.out.println("댓글리스트 확인 : "+ tagCommentList);
		//댓글 카운트
		ArrayList<HashMap<String,Object>> tagCommentCntList = dao.tagCommentCnt(tag_name);
		System.out.println("댓글카운트 확인 : "+ tagCommentCntList);
		    	
		model.addAttribute("like_check", likeVO.getLike_check());
		model.addAttribute("tagCommentList", tagCommentList);
		model.addAttribute("tagCommentCntList", tagCommentCntList);
		model.addAttribute("tag_name", tag_name);
		model.addAttribute("sList", sList);
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
	public String postRead(int post_no, Model model, HttpSession session) {
		String user_id = (String)session.getAttribute("user_id");
		HashMap<String, Object> hashMap = new HashMap<String, Object>();
	    
	    LikeVO likeVO = new LikeVO();
		
		if(user_id != null){
			hashMap.put("post_no", post_no);
			hashMap.put("user_id", user_id); 
			if(dao.countbyLike(hashMap) == 0) {
				dao.create(hashMap);
			}
			
			likeVO = dao.like_read(hashMap);
		}

		PostVO vo = dao.postRead(post_no);
		ArrayList<TagVO> taglist = dao.getTag(post_no);
		String tag_name = "";
		for(TagVO tag : taglist) {
			tag_name += tag.getTag_name()+",";
		}
		ArrayList<ReplyVO> replyList = dao.replyList(post_no);
		
		int replyCnt = dao.replyCnt(post_no);
		
		model.addAttribute("replyCnt", replyCnt);
		model.addAttribute("like_check", likeVO.getLike_check());
		model.addAttribute("like_cnt", vo.getLike_cnt());
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
	
	// 태그폼 댓글 등록
	@RequestMapping(value="tagReplyWrite", method=RequestMethod.POST)
	public String tagReplyWrite(ReplyVO vo, HttpSession session) {
		dao.replyWrite(vo, session);
		return "redirect:tagSearchForm?post_no=" + vo.getPost_no();
	}
		
	// 태그폼 댓글 삭제
	@RequestMapping(value = "tagReplyDelete", method = RequestMethod.GET)
	public String tagReplyDelete(ReplyVO vo, HttpSession session) {
		dao.replyDelete(vo, session);
		return "redirect:tagSearchForm?post_no="+vo.getPost_no();
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
	  @ResponseBody
	  @RequestMapping(value="like_to", method=RequestMethod.GET, produces="text/plain;charset=UTF-8")
	  public String like_to(int post_no, HttpSession session){
//		  		System.out.println("포스트넘버 확인:"+post_no);
		    String user_id = (String)session.getAttribute("user_id");
//		    	System.out.println("세션유저아이디 확인:"+user_id);
		    JSONObject obj = new JSONObject();
		 
		    HashMap <String, Object> hashMap = new HashMap<String, Object>();
		    hashMap.put("post_no", post_no);
		    hashMap.put("user_id", user_id);
		    LikeVO likeVO = dao.like_read(hashMap);
//		    	System.out.println("좋아요테이블에 들어갔는지 확인"+likeVO.toString());
		    PostVO postVO = dao.postRead(post_no);
		    int like_cnt = postVO.getLike_cnt();     //게시판의 좋아요 카운트
		    int like_check = 0;
		    like_check = likeVO.getLike_check();    //좋아요 체크 값
		    	System.out.println("라이크 카운트 확인 : "+like_cnt);
		    	System.out.println("라이크 체크 값 확인 : "+like_check);
		    
		    if(dao.countbyLike(hashMap) == 0){
		      dao.create(hashMap);
		    }
//		    	System.out.println("라이크넘버 개수 : "+dao.countbyLike(hashMap));
		    	
		    if(like_check == 0) {
		      dao.like_check(hashMap);
		      like_check++;
		      like_cnt++;
		      dao.like_cnt_up(post_no);   //좋아요 갯수 증가
		    } else {
		      dao.like_check_cancel(hashMap);
		      like_check--;
		      like_cnt--;
		      dao.like_cnt_down(post_no);   //좋아요 갯수 감소
		    }
		    	System.out.println("post_no : "+likeVO.getPost_no()+" like_check : "+like_check+" like_cnt : "+like_cnt);
		    obj.put("post_no", likeVO.getPost_no());
		    obj.put("like_check", like_check);
		    obj.put("like_cnt", like_cnt);

	    return obj.toJSONString();
	  }
	
}
