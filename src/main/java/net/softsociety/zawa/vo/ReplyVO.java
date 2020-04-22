package com.sesoc.report.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReplyVO {

	private int replynum;
	private int post_no;
	private String user_id;
	private String replytext;
	private String inputdate;
}
