package net.softsociety.zawa.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProfileVO {
	private long id;
	private String displayid;
	private String name;
	private int owner;
	private int suspended;
	private int isprivate;
	private String thumbnail;
}
