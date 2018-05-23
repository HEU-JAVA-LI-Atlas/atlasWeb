package com.atlas.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.atlas.service.TableService;


@Controller
public class PageController {
	@Autowired
	private TableService tableService;
	
	@RequestMapping("/")
	public String showIndex() {
		System.out.println("yijing执行");
		tableService.userJedisTest();
		return "index";
	}

	@RequestMapping("/{page}")
	public String showpage(@PathVariable String page) {
		System.out.println("yijing执行222");
		return page;
	}
	
}
