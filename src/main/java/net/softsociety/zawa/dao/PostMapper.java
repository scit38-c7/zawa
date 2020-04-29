package net.softsociety.zawa.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;

import net.softsociety.zawa.vo.PostVO;

public interface PostMapper {
	public int getTotal(String author);

	public ArrayList<PostVO> getUserPosts(String author, RowBounds rb);

	public int createPost(PostVO vo);

	public int deletePost(PostVO vo);

	public int getSearchTotal(String searchKeyword);

	public ArrayList<PostVO> getSearchPosts(String searchKeyword, RowBounds rb);
}
