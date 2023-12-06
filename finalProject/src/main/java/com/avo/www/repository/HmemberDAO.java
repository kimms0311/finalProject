package com.avo.www.repository;

import com.avo.www.security.MemberVO;

public interface HmemberDAO {

	MemberVO getDeail(String email);

	String getPw(String email);

}
