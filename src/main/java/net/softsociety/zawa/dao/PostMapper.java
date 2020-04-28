package net.softsociety.zawa.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;

import net.softsociety.zawa.vo.PostVO;

public interface PostMapper {
	public int getTotal(String displayid);

	public ArrayList<PostVO> getUserPosts(String displayid, RowBounds rb);
}
