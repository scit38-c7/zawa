package com.sesoc.report.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class LikeVO {

	private int like_no;
	private int post_no;
	private String user_id;
	private int like_check;
}
