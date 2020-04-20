package net.softsociety.zawa.dao;

import net.softsociety.zawa.vo.AccountVO;

public interface UserMapper {
	public int signin(AccountVO vo);

	public int createAccount(AccountVO vo);

	public int findByEmail(String email);
}
