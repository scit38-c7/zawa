package com.sesoc.report.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;

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
}
