package com.avo.www.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.avo.www.domain.ProductBoardVO;
import com.avo.www.service.StoreBoardService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/store/*")
public class StoreBoardController {
	@Inject
	private StoreBoardService sbs;
	
	@GetMapping("/list")
	public void list() {}
	
	@GetMapping("/register")
	public void register() {}
	
	@PostMapping("/register")
	public String register(ProductBoardVO pvo, RedirectAttributes re, 
		@RequestParam(name="files", required = false)MultipartFile[] files) {
				
		return "redirect:/store/list";
		
	}
}
