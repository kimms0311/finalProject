package com.avo.www.repository;

import com.avo.www.security.MemberVO;

public interface HmemberDAO {

	MemberVO getDeail(String email);

	String getPw(String email);

	int modifyPwEmpty(MemberVO mvo);

	int modify(MemberVO mvo);

	//탈퇴 관련
	int jjsDelete(String email);

	int cmDelete(String email);

	int amDelte(String email);

	int mbDelete(String email);

}
