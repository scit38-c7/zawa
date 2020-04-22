package net.softsociety.zawa.dao;

import java.util.ArrayList;

import net.softsociety.zawa.vo.AccountVO;
import net.softsociety.zawa.vo.ProfileVO;

public interface UserMapper {

	public int createAccount(AccountVO vo);

	public AccountVO signinAccount(AccountVO vo);

	public int findAccountByEmail(String email);

	public ArrayList<ProfileVO> getAccountProfiles(int owner);

}
