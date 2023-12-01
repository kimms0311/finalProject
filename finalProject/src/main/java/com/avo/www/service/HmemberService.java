package com.avo.www.service;

import com.avo.www.security.MemberVO;

public interface HmemberService {

	MemberVO getDetail(String email);

	String getPw(String email);

	boolean isPasswordCorrect(String email, String pw);

}
