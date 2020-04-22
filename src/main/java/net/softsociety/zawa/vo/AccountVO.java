package net.softsociety.zawa.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AccountVO {
	private int id;
	private String email;
	private String pwhash;
	private String dob;
	private String datecreated;
	private int suspended;
}
