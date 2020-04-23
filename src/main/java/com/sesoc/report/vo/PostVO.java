package com.sesoc.report.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PostVO {

	private int post_no;
	private String user_id;
	private String title;
	private String content;
	private String inputdate;
	private int hit;
	private int like_cnt;
	private String originalFilename;
	private String savedFilename;
}
