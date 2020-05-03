package net.softsociety.zawa.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import net.softsociety.zawa.vo.LikeVO;
import net.softsociety.zawa.vo.PostVO;

@Repository
public class PostDAO {
	private static final int POSTS_PER_PAGE = 10;

	@Autowired
	SqlSession sqlSession;

	/**
	 * 특정 한 사용자의 타임라인에 사용되는 navigator
	 */
	public ScrollPageNavigator getNavi(int currentPage, String displayid) {
		int totalRecordsCount = 0;
		try {
			PostMapper mapper = sqlSession.getMapper(PostMapper.class);
			totalRecordsCount = mapper.getTotal(displayid);
		} catch (Exception e) {
			e.printStackTrace();
		}
		ScrollPageNavigator navi = new ScrollPageNavigator(POSTS_PER_PAGE, currentPage, totalRecordsCount);
		return navi;
	}

	public ArrayList<PostVO> getUserPosts(String displayid, ScrollPageNavigator navi) {
		ArrayList<PostVO> list = null;
		RowBounds rb = new RowBounds(navi.getStartRecord(), navi.getCountPerPage());
		try {
			PostMapper mapper = sqlSession.getMapper(PostMapper.class);
			list = mapper.getUserPosts(displayid, rb);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public boolean createPost(PostVO vo) {
		boolean result = false;
		try {
			PostMapper mapper = sqlSession.getMapper(PostMapper.class);
			if (mapper.createPost(vo) > 0) {
				result = true;
			} else {
				result = false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public boolean deletePost(PostVO vo) {
		boolean result = false;
		try {
			PostMapper mapper = sqlSession.getMapper(PostMapper.class);
			if (mapper.deletePost(vo) > 0) {
				result = true;
			} else {
				result = false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public ScrollPageNavigator getSearchNavi(int currentPage, String searchKeyword) {
		int totalRecordsCount = 0;
		try {
			PostMapper mapper = sqlSession.getMapper(PostMapper.class);
			totalRecordsCount = mapper.getSearchTotal(searchKeyword);
		} catch (Exception e) {
			e.printStackTrace();
		}
		ScrollPageNavigator navi = new ScrollPageNavigator(POSTS_PER_PAGE, currentPage, totalRecordsCount);
		return navi;
	}

	public ArrayList<PostVO> getSearchPosts(String searchKeyword, ScrollPageNavigator navi) {
		ArrayList<PostVO> list = null;
		RowBounds rb = new RowBounds(navi.getStartRecord(), navi.getCountPerPage());
		try {
			PostMapper mapper = sqlSession.getMapper(PostMapper.class);
			list = mapper.getSearchPosts(searchKeyword, rb);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public int getLikeTotal(int post_no) {
		int result = 0;
		try {
			PostMapper mapper = sqlSession.getMapper(PostMapper.class);
			result = mapper.getLikeTotal(post_no);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	public int like(LikeVO vo) {
		int result = 0;
		try {
			PostMapper mapper = sqlSession.getMapper(PostMapper.class);
			if (mapper.like(vo) > 0) {
				result = mapper.getLikeTotal(vo.getPost_no());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	public int unlike(LikeVO vo) {
		int result = 0;
		try {
			PostMapper mapper = sqlSession.getMapper(PostMapper.class);
			if (mapper.unlike(vo) > 0) {
				result = mapper.getLikeTotal(vo.getPost_no());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	public boolean isLikedByMe(LikeVO vo) {
		boolean result = false;
		try {
			PostMapper mapper = sqlSession.getMapper(PostMapper.class);
			if (mapper.isLikedByMe(vo) > 0) {
				result = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	public int toggleLike(LikeVO vo) {
		int result = 0;
		try {
			PostMapper mapper = sqlSession.getMapper(PostMapper.class);
			if (mapper.isLikedByMe(vo) > 0) {
				mapper.unlike(vo);
			} else {
				mapper.like(vo);
			}
			result = mapper.getLikeTotal(vo.getPost_no());
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	public ScrollPageNavigator getLikesNavi(int currentPage, String user_id) {
		int totalRecordsCount = 0;
		try {
			PostMapper mapper = sqlSession.getMapper(PostMapper.class);
			totalRecordsCount = mapper.getLikesTotal(user_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		ScrollPageNavigator navi = new ScrollPageNavigator(POSTS_PER_PAGE, currentPage, totalRecordsCount);
		return navi;
	}

	public ArrayList<PostVO> getLikesPosts(String user_id, ScrollPageNavigator navi) {
		ArrayList<PostVO> list = null;
		RowBounds rb = new RowBounds(navi.getStartRecord(), navi.getCountPerPage());
		try {
			PostMapper mapper = sqlSession.getMapper(PostMapper.class);
			list = mapper.getLikedPosts(user_id, rb);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
