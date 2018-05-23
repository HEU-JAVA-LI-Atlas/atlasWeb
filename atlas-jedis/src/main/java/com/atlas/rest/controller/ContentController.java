package com.atlas.rest.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.atlas.rest.service.ContentService;




@Controller
//@RequestMapping("/content")
public class ContentController {

	@Autowired
	private ContentService contentService;
	
	
	
}