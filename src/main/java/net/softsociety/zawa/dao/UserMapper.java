package net.softsociety.zawa.dao;

import net.softsociety.zawa.vo.AccountVO;

public interface UserMapper {

	public int createAccount(AccountVO vo);

	public int signinAccount(AccountVO vo);

	public int findAccountByEmail(String email);

}
