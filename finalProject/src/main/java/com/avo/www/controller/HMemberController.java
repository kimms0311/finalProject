package com.avo.www.controller;

import java.security.Principal;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.avo.www.security.MemberVO;
import com.avo.www.service.HmemberService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/hmember/*")
@Controller
public class HMemberController {
	@Inject 
	private HmemberService hsv;
	
	@GetMapping({"/detail", "/modify"})
	public void detail(Model m, @RequestParam("memEmail") String email)  {
		m.addAttribute("mvo", hsv.getDetail(email));
	}
	
	@GetMapping("/checkPw") 
	public void checkPw(Model m, Principal principal) {
		m.addAttribute("email", principal.getName());
	}
	
	@PostMapping("/passOrFail")
	public String passOrFail(RedirectAttributes re, @RequestParam("inputPw") String pw, Principal principal) {
		 String email = principal.getName();
		 
		 boolean isPasswordCorrect = hsv.isPasswordCorrect(email, pw);
		 if(isPasswordCorrect) {
			 log.info("match");
			 re.addAttribute("memEmail", email);
			 return "redirect:/hmember/modify";
		 } else {
			 log.info("no match");
			 int isOk = -1;
			 re.addFlashAttribute("isOk", isOk);
			 return "redirect:/hmember/checkPw"; 
		 }
	}
	
	@PostMapping("/modify")
	public String modify(RedirectAttributes re, MemberVO mvo, Principal principal) {
		log.info(mvo+"mvo >>>>>>>>>>>>>> zz"); 
		
		String email = principal.getName();
		re.addAttribute("memEmail", email);
		return "redirect:/hmember/modify";
		
	}
	
}

