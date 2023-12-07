package com.avo.www.controller;

import java.util.Random;

import javax.inject.Inject;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.avo.www.domain.CommunityCmtVO;
import com.avo.www.security.MemberVO;
import com.avo.www.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/member/*")
@Controller
public class MemberController {

	@Inject
	private BCryptPasswordEncoder bcEncoder;
	
	@Inject
	private MemberService msv;
	
	@Autowired  
	private JavaMailSender mailSender;
	
	@GetMapping("/register")
	public void register() {}
	
	@PostMapping("/register")
	public String register(MemberVO mvo, Model m) {
		log.info(">>>>> register mvo >> "+mvo);
		
		mvo.setMemPw(bcEncoder.encode(mvo.getMemPw())); //받은 비밀번호 암호화
		int isJoin = msv.register(mvo);
		log.info(">>>>> member register >> "+(isJoin>0? "성공":"실패"));
		
		return "index";
	}
	
	@GetMapping("/login")
	public void login() {}
	
	@PostMapping("/login")
	public String login(HttpServletRequest request, RedirectAttributes re) {
		//로그인 실패시 다시 로그인 페이지로 돌아와 오류 메시지 전송
		//다시 로그인 유도
		re.addAttribute("email", request.getAttribute("email")); //큰 의미없
		re.addAttribute("errMsg", request.getAttribute("errMsg"));
		
		return "redirect:/member/login";
	}
	
	//이메일 존재여부 확인
	@GetMapping(value = "/email/{memEmail}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> hasEmail(@PathVariable("memEmail")String memEmail){
		log.info(">>>>> memEmail >>> "+memEmail);
		int isOk = msv.hasEmail(memEmail);
		
		return isOk > 0 ? new ResponseEntity<String>("1", HttpStatus.OK) 
				: new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//닉네임 존재여부 확인
	@GetMapping(value = "/nick/{memNickName}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> hasNick(@PathVariable("memNickName")String memNickName){
		log.info(">>>>> memNickName >>> "+memNickName);
		int isOk = msv.hasNick(memNickName);
		
		return isOk > 0 ? new ResponseEntity<String>("1", HttpStatus.OK) 
				: new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value = "/test/{memEmail}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> mail(@PathVariable("memEmail")String memEmail, Model m){
		log.info(">>>>> 인증 이메일 >>> "+memEmail);
		
		//인증번호 생성
		Random random = new Random();
		int checkNum = random.nextInt(888888) + 111111;
		log.info("인증번호 >>> "+checkNum);
		
		//이메일 전송 내용
		String setFrom = "ezenfinal@gmail.com"; //발신 이메일
		String toMail = memEmail;         //받는 이메일
		String title = "Avocart 회원가입 인증 이메일입니다.";
		String content = 
						"인증번호는 " + "<b style='color:blue'>" + checkNum + "</b>" + "입니다.<br>"  
								+ "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";
		
		//이메일 전송 코드
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content,true);
			mailSender.send(message);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		String num = Integer.toString(checkNum); 
		return new ResponseEntity<String>(num, HttpStatus.OK);
	}

	
}
