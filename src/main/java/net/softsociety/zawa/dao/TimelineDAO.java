package net.softsociety.zawa.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class TimelineDAO {
	private static final int POSTS_PER_PAGE = 10;

	@Autowired
	SqlSession sqlSession;

	public TimelinePageNavigator getNavi(int currentPage) {

		return null;
	}
}
