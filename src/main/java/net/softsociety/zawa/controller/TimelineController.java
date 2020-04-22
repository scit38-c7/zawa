package net.softsociety.zawa.controller;

import java.util.ArrayList;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import net.softsociety.zawa.dao.TimelinePageNavigator;
import net.softsociety.zawa.vo.PostVO;

@Controller
public class TimelineController {

	@RequestMapping(value = "user", method = RequestMethod.GET)
	public String user(String id) {
		return "dashboard/timeline";
	}

	@ResponseBody
	@RequestMapping(value = "readTimelinePage", method = RequestMethod.GET)
	public ArrayList<PostVO> readTimelinePage(String id,
			@RequestParam(value = "currentPage", defaultValue = "1") int currentPage) {
		ArrayList<PostVO> list = null;

		return list;
	}
}
