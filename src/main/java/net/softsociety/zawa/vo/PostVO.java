package net.softsociety.zawa.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PostVO {

	private int post_no;
	private String author;
	private String content;
	private String inputdate;
	private int like_count;
	private String originalfilename;
	private String savedfilename;
}
