package com.sesoc.report.dao;

import java.util.ArrayList;


import com.sesoc.report.vo.ReplyVO;

public interface ReplyMapper {

	//댓글등록
	public void replyWrite(ReplyVO vo);
	//댓글출력
	public ArrayList<ReplyVO> replyList(int post_no);
	//댓글삭제
	public void replyDelete(ReplyVO vo);
	//댓글카운트
	public int replyCnt(int post_no);
}
