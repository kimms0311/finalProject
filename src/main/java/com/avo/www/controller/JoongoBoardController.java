package com.avo.www.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.avo.www.domain.ProductBoardVO;
import com.avo.www.service.JoongoBoardService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/joongo/**")
public class JoongoBoardController {

	@Inject
	private JoongoBoardService jbsv;
	
	@GetMapping("/list")
	public void list(Model m) {
		List<ProductBoardVO> list = jbsv.getList();
		m.addAttribute("list",list);
	}
	
	@GetMapping("/register")
	public void getReg() {
	}
	
	@PostMapping("/register")
	public String postReg(ProductBoardVO pbvo) {
		log.info(">>>>>>> pbvo >>> "+pbvo);
		int isOk = jbsv.register(pbvo);
		log.info("등록 "+(isOk > 0 ? "성공" : "실패"));
		
		return "redirect:/joongo/list";
	}
	
}
