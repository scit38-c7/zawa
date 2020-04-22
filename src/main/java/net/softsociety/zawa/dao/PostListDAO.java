package net.softsociety.zawa.dao;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import net.softsociety.zawa.vo.PostTagVO;
import net.softsociety.zawa.vo.PostVO;
import net.softsociety.zawa.vo.ReplyVO;
import net.softsociety.zawa.vo.TagVO;

@Repository
public class PostListDAO {

	private final int countPerPage = 10;
	private final int pagePerGroup = 5;

	@Autowired
	private SqlSession sqlsession;

	// 게시판 리스트
	public ArrayList<PostVO> PostList(String searchItem, String searchKeyword, PageNavigator navi) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("searchItem", searchItem);
		map.put("searchKeyword", searchKeyword);
		ArrayList<PostVO> list = null;
		RowBounds rb = new RowBounds(navi.getStartRecord(), navi.getCountPerPage());

		try {
			PostListMapper mapper = sqlsession.getMapper(PostListMapper.class);
			list = mapper.PostList(map, rb);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	//조회수 높은글 읽기
	public ArrayList<PostVO> hitRead(){
		ArrayList<PostVO> hitlist = null;
		
		try {
			PostListMapper mapper = sqlsession.getMapper(PostListMapper.class);
			hitlist = mapper.hitRead();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return hitlist;
	}
	
	//조회수 높은글 번호 가져오기
		public int hitPost_no(){
			int post_no = 0;
			
			try {
				PostListMapper mapper = sqlsession.getMapper(PostListMapper.class);
				post_no = mapper.hitPost_no();
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			return post_no;
		}

	// 페이징
	public PageNavigator getNavi(int currentPage, String searchItem, String searchKeyword) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("searchItem", searchItem);
		map.put("searchKeyword", searchKeyword);
		int totalRecordsCount = 0;

		try {
			PostListMapper mapper = sqlsession.getMapper(PostListMapper.class);
			totalRecordsCount = mapper.getTotal(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, currentPage, totalRecordsCount);
		return navi;
	}

	// 게시글 작성
	public int postWrite(PostVO vo, HttpSession session, MultipartFile uploadFile) {
		String user_id = (String) session.getAttribute("user_id");
		vo.setUser_id(user_id);
		int result = 0;

		if (!uploadFile.isEmpty()) {
			String savedFilename = UUID.randomUUID().toString();
			String originalFilename = uploadFile.getOriginalFilename();
			vo.setOriginalFilename(originalFilename);
			vo.setSavedFilename(savedFilename);

			try {
				uploadFile.transferTo(new File("C:/reportFile/" + savedFilename));
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}

		}

		try {
			PostListMapper mapper = sqlsession.getMapper(PostListMapper.class);
			result = mapper.postWrite(vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	// 게시판 읽기
	public PostVO postRead(int post_no) {
		PostVO vo = null;
		try {
			PostListMapper mapper = sqlsession.getMapper(PostListMapper.class);
			mapper.hitCount(post_no);
			vo = mapper.postRead(post_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return vo;
	}
	
	//태그 검색 읽기
	public ArrayList<PostVO> tagSearch(String tag_name){
		ArrayList<PostVO> tagPostList = null;
		try {
			PostListMapper mapper = sqlsession.getMapper(PostListMapper.class);
			tagPostList = mapper.tagSearch(tag_name);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return tagPostList;
	}
	
	//태그 읽어 오기
	public ArrayList<PostVO> tagRead(PostVO tagPostList) {
		ArrayList<PostVO> tagSearchList = null;
		try {
			PostListMapper mapper = sqlsession.getMapper(PostListMapper.class);
			tagSearchList = mapper.tagRead(tagPostList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return tagSearchList;
	}

	// 게시판 삭제
	public int postDelete(PostVO vo, HttpSession session) {
		String user_id = (String) session.getAttribute("user_id");
		vo.setUser_id(user_id);
		int result = 0;
		try {
			PostListMapper mapper = sqlsession.getMapper(PostListMapper.class); // 인터페이스 클래스 객체화
			result = mapper.postDelete(vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	
	//게시판 댓글 쓰기
	public void replyWrite(ReplyVO vo, HttpSession session) {
		String user_id = (String)session.getAttribute("user_id");
		vo.setUser_id(user_id);
		try {
			ReplyMapper mapper = sqlsession.getMapper(ReplyMapper.class);
			mapper.replyWrite(vo);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	  //게시판 댓글 목록
	  public ArrayList<ReplyVO> replyList(int post_no) {
	  ArrayList<ReplyVO> replyList = null; 
	  try { 
		  ReplyMapper mapper = sqlsession.getMapper(ReplyMapper.class);
		  replyList = mapper.replyList(post_no); 
	  }
	  catch (Exception e) 
	  { 
		  e.printStackTrace(); 
	  }
	  return replyList; 
	  }
	  
	//댓글 삭제
	  public void replyDelete(ReplyVO vo, HttpSession session) {
		String user_id = (String)session.getAttribute("user_id");
		vo.setUser_id(user_id);
		try {
			ReplyMapper mapper = sqlsession.getMapper(ReplyMapper.class);
			mapper.replyDelete(vo);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	 

	// 게시판 수정
	public PostVO postReader(int post_no) {
		PostVO vo = null;
		try {
			PostListMapper mapper = sqlsession.getMapper(PostListMapper.class); // 인터페이스 클래스 객체화
			vo = mapper.postRead(post_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return vo;
	}

	public int postUpdate(PostVO vo, HttpSession session, MultipartFile uploadFile) {
		String user_id = (String) session.getAttribute("user_id");
		vo.setUser_id(user_id);
		int result = 0;
		try {
			PostListMapper mapper = sqlsession.getMapper(PostListMapper.class); // 인터페이스 클래스 객체화

			if (!uploadFile.isEmpty()) {
				// 기존의 게시글 정보를 읽어온다
				PostVO temp = mapper.postRead(vo.getPost_no());
				// 예전 첨부파일을 서버에서 삭제한다
				File oldFile = new File("C:/reportFile/" + temp.getSavedFilename());
				if (oldFile.exists())
					oldFile.delete();
				// 새로운 첨부파일의 정보를 읽어와 원본 파일명과 저장용 파일명을 준비한다
				String originalFilename = uploadFile.getOriginalFilename();
				String savedFilename = UUID.randomUUID().toString();
				// VO 객체에 원본 파일명과 저장용 파일명을 전달한다
				vo.setOriginalFilename(originalFilename);
				vo.setSavedFilename(savedFilename);
				// 새로운 첨부파일을 서버에 저장
				File newFile = new File("C:/reportFile/" + savedFilename);
				uploadFile.transferTo(newFile);
				// update query를 실행한다
			}

			result = mapper.postUpdate(vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	// 태그확인
	public TagVO checkTag(String tag_name) {
		TagVO vo = null;
		try {
			PostListMapper mapper = sqlsession.getMapper(PostListMapper.class); // 인터페이스 클래스 객체화
			vo = mapper.checkTag(tag_name);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return vo;
	}
	
	// 태그 넣기
	public boolean insertTag(String tag_name) {
		int result = 0;
		try {
			PostListMapper mapper = sqlsession.getMapper(PostListMapper.class); // 인터페이스 클래스 객체화
			result = mapper.insertTag(tag_name);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(result == 0) return false;
		return true;
	}
	
	// posttag테이블에 데이터넣기
	public boolean insertPostTag(PostTagVO vo) {
		int result = 0;
		try {
			PostListMapper mapper = sqlsession.getMapper(PostListMapper.class); // 인터페이스 클래스 객체화
			result = mapper.insertPostTag(vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(result == 0) return false;
		return true;
	}
	
	// 포스트 태그 포스트번호 가져오기
	public int getPost_no() {
		int result = 0 ;
		try {
			PostListMapper mapper = sqlsession.getMapper(PostListMapper.class); // 인터페이스 클래스 객체화
			result = mapper.getPost_no();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	// 태그네임 가져오기
	public ArrayList<TagVO> getTag (int post_no){
		ArrayList<TagVO> taglist = null;
		try {
			PostListMapper mapper = sqlsession.getMapper(PostListMapper.class); // 인터페이스 클래스 객체화
			taglist = mapper.getTag(post_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return taglist;
	}
}
