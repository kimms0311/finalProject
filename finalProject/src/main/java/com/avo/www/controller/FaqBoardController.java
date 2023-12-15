package com.avo.www.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.avo.www.domain.FaqBoardVO;
import com.avo.www.domain.PagingVO;
import com.avo.www.service.FaqBoardService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/faq/*")
@Controller
public class FaqBoardController {
	
	@Inject
	private FaqBoardService fsv;

	@GetMapping("/register")
	public void register() {}
	
	@PostMapping("/register")
	public String register(FaqBoardVO bvo, RedirectAttributes re) {
		log.info(">>>>> bvo >>> "+bvo);
		
		int isUp = fsv.regiser(bvo);
		log.info(">>>>> faq register >>> "+(isUp>0? "성공":"실패"));
		
		return "redirect:/faq/list";
	}
	
	@GetMapping("/list")
	public void list(@RequestParam(name = "faqCategory", required = false)String faqCategory, Model m, PagingVO pgvo) {
		log.info(">>>>> category >> "+faqCategory);
		log.info(">>>>> pgvo >> "+pgvo.getKeyword());
		
		List<FaqBoardVO> list = null;
		if("전체".equals(faqCategory) || faqCategory == null) {
			list = fsv.getList(pgvo);			
		}else {
			list = fsv.getMenuList(faqCategory);
		}

		log.info(">>>>> faq list >> "+list);
		m.addAttribute("list", list);
	}
	
	@GetMapping("/adminList")
	public void adminList(@RequestParam(name = "faqCategory", required = false)String faqCategory, Model m, PagingVO pgvo) {
		
		List<FaqBoardVO> list = null;
		if("전체".equals(faqCategory) || faqCategory == null) {
			list = fsv.getList(pgvo);			
		}else {
			list = fsv.getMenuList(faqCategory);
		}

		m.addAttribute("list", list);
	}
	
}
