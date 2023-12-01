package com.avo.www.service;

import javax.inject.Inject;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.avo.www.repository.HmemberDAO;
import com.avo.www.security.MemberVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class HmemberServiceImpl implements HmemberService {
	@Inject
	private HmemberDAO hdao;
	
	@Inject
    private PasswordEncoder passwordEncoder;
	
	@Override
	public MemberVO getDetail(String email) {
		MemberVO mvo = hdao.getDeail(email);
		return mvo;
	}

	@Override
	public String getPw(String email) {
		return hdao.getPw(email);
	}

	@Override
	public boolean isPasswordCorrect(String email, String pw) {
	    MemberVO mvo = hdao.getDeail(email);
    
	    if (mvo!=null) {
	        String storedPassword = mvo.getMemPw();
	        boolean passwordMatches = passwordEncoder.matches(pw, storedPassword);
	        
	        return passwordMatches;
	    } else {
	        return false;
	    }
	}

}
