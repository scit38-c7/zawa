package com.sesoc.report.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;

import com.sesoc.report.vo.LikeVO;
import com.sesoc.report.vo.MemberVO;
import com.sesoc.report.vo.PostTagVO;
import com.sesoc.report.vo.PostVO;
import com.sesoc.report.vo.TagVO;

public interface PostListMapper {

	//리스트
	public ArrayList<PostVO> PostList(HashMap<String, String> map, RowBounds rb);
	//글쓰기
	public int postWrite(PostVO vo);
	//페이징
	public int getTotal(HashMap<String, String> map);
	//읽기
	public PostVO postRead(int post_no);
	public PostVO postReader(int post_no);
	//인기 조회수 가져오기
	public ArrayList<PostVO> hitRead();
	//인기 조회수 글번호 가져오기
	public int hitPost_no();
	//조회수
	public void hitCount(int post_no);
	//삭제
	public int postDelete(PostVO vo);
	//업데이트
	public int postUpdate(PostVO vo);
	//해시태그 존재유무 확인
	public TagVO checkTag(String tag_name);
	//해시태그 없을시 삽입
	public int insertTag(String tag_name);
	//포스트태그 테이블에 데이터 삽입
	public int insertPostTag(PostTagVO ptVO);
	//시퀀스로된 포스트넘버 찾기
	public int getPost_no();
	//저장된 해시태그 검색
	public ArrayList<TagVO> getTag(int post_no);
	//태그 검색 읽기
	public ArrayList<PostVO> tagSearch(String tag_name);
	//태그 읽어오기
	public ArrayList<PostVO> tagRead(PostVO tagPostList);
	//좋아요 카운트
	public int countbyLike (HashMap<String, Object> map);
	//좋아요 행 추가
	public void create (HashMap<String, Object> map);
	//좋아요 글 번호로 읽어오기
	public PostVO post_read (int post_no);
	//좋아요  읽어오기
	public LikeVO like_read (HashMap<String, Object> map);
	//멤버 데이터 읽기
	public MemberVO member_read(String user_id);
	//좋아요 체크
	public void like_check(HashMap<String, Object> map);
	//좋아요 취소
	public void like_check_cancel(HashMap<String, Object> map);
	//좋아요 포스트테이블 카운트 증가
	public void like_cnt_up(int post_no);
	//좋아요 포스트테이블 카운트 감소
	public void like_cnt_down(int post_no);
	//좋아요 인서트 추가
	public int like_add(HashMap<String, Object> map);
	
	//좋아요에 체크가 되있는지 확인하는코드
	public int like_checking(HashMap<String, Object> map);
	
	public ArrayList<HashMap<String,Object>> allPost(String tag_name);
	public ArrayList<HashMap<String,Object>> getTagName(int post_no);
	
//	<!-- 	태그검색폼에 댓글정보 넣는 것 -->
	public ArrayList<HashMap<String,Object>> tagComment(String tag_name);
	
//	<!-- 	태그검색폼에 댓글카운트 -->
	public ArrayList<HashMap<String,Object>> tagCommentCnt(String tag_name);
	
}
