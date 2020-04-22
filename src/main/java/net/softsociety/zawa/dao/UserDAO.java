package net.softsociety.zawa.dao;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import net.softsociety.zawa.vo.AccountVO;
import net.softsociety.zawa.vo.ProfileVO;

@Repository
public class UserDAO {
	@Autowired
	SqlSession sqlSession;

	/**
	 * @param email 중복 여부를 체크할 이메일 주소
	 * @return 이미 가입된 이메일 주소가 있다면 true, 없다면 false
	 */
	public boolean findAccountByEmail(String email) {
		int count = 0;
		try {
			UserMapper mapper = sqlSession.getMapper(UserMapper.class);
			count = mapper.findAccountByEmail(email);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (count != 0) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * @param vo 계정 등록 폼에 입력한 계정 정보
	 * @param pw 계정 등록 폼에 입력한 평문 패스워드
	 * @return 계정 등록 처리 결과
	 */
	public boolean createAccount(AccountVO vo, String pw) {
		boolean result = false;
		try {
			// 패스워드 해시 값 생성
			vo.setPwhash(getPwhash(pw));
			// 계정 등록
			UserMapper mapper = sqlSession.getMapper(UserMapper.class);
			if (mapper.createAccount(vo) > 0) {
				result = true;
			} else {
				result = false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	private String getPwhash(String pw) {
		StringBuilder sb = new StringBuilder();
		try {
			MessageDigest md = MessageDigest.getInstance("SHA-512");
			byte[] hashBytes = md.digest(pw.getBytes(StandardCharsets.UTF_8));
			for (byte b : hashBytes) {
				sb.append(String.format("%02x", b));
			}
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return new String(sb);
	}

	public boolean signin(AccountVO vo, String pw, HttpSession httpSession) {
		AccountVO currentAccount = null;
		try {
			// 패스워드 해시 값 생성
			vo.setPwhash(getPwhash(pw));
			// 로그인 처리
			UserMapper mapper = sqlSession.getMapper(UserMapper.class);
			currentAccount = mapper.signinAccount(vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (currentAccount == null) {
			return false;
		}
		httpSession.setAttribute("currentAccount", currentAccount);
		return true;
	}

	public ArrayList<ProfileVO> getAccountProfiles(long owner) {
		ArrayList<ProfileVO> list = null;
		try {
			UserMapper mapper = sqlSession.getMapper(UserMapper.class);
			list = mapper.getAccountProfiles(owner);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
