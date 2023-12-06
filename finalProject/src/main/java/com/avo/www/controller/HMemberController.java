package com.avo.www.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.avo.www.domain.FileVO;
import com.avo.www.domain.StoreMenuVO;
import com.avo.www.handler.FileHandler;
import com.avo.www.security.MemberVO;
import com.avo.www.service.HmemberService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/hmember/*")
@Controller
public class HMemberController {
	@Inject 
	private HmemberService hsv;

	@Inject
	private BCryptPasswordEncoder bcEncoder;

	@Inject
	private FileHandler fh;
	
	@GetMapping({"/detail", "/modify"})
	public void detail(Model m, @RequestParam("memEmail") String email)  {
		FileVO fvo = hsv.getProfile(email);
		String src = null;
		if(fvo!=null) {
			src = "/upload/profile/" + fvo.getSaveDir().replace('\\', '/') + "/" + fvo.getUuid() + "_" + fvo.getFileName();
		} else {
			src = "../resources/image/기본 프로필.png";
		}
		m.addAttribute("mvo", hsv.getDetail(email));
		m.addAttribute("src", src);
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
		//비밀번호 변경X	
		if(mvo.getMemPw().isEmpty()) {
			mvo.setMemNickName(mvo.getMemNickName());
			mvo.setMemSido(mvo.getMemSido());
			mvo.setMemSigg(mvo.getMemSigg());
			mvo.setMemEmd(mvo.getMemEmd());
			hsv.modifyPwEmpty(mvo);		
		} else {
			//변경O
			mvo.setMemPw(bcEncoder.encode(mvo.getMemPw()));
			mvo.setMemNickName(mvo.getMemNickName());
			mvo.setMemSido(mvo.getMemSido());
			mvo.setMemSigg(mvo.getMemSigg());
			mvo.setMemEmd(mvo.getMemEmd());
			hsv.modify(mvo);
		}
		String email = principal.getName();
		re.addAttribute("memEmail", email);
		return "redirect:/hmember/modify";		
	}
	
	@PostMapping(value="/editFile/{email}")
	public String editFile(RedirectAttributes re,
		@PathVariable String email,
		@RequestParam(name="file")MultipartFile[] file){	
		
		List<FileVO> flist = new ArrayList<FileVO>();
		if(file[0].getSize()>0) {
			flist = fh.uploadFiles(file, "profile");
		}

		int isOk = hsv.proInsert(email, flist);
		re.addAttribute("memEmail", email);
		return "redirect:/hmember/detail";
	}
	
	@DeleteMapping(value="/deleteFile/{email}")
	public String deleteFile(RedirectAttributes re, @PathVariable String email) {
		int isOk = hsv.proDelete(email);
		re.addAttribute("memEmail", email);
		return "redirect:/hmember/detail";
	}
	
	@DeleteMapping(value="/deleteMember/{email}")
	public String deleteMember(RedirectAttributes re, @PathVariable String email) {
		int isDel = hsv.memDelete(email);
		re.addAttribute("isDel", isDel);
		log.info("zzzzzzzzzzzzz 장난하나");
		
		 return "/";
	}

}