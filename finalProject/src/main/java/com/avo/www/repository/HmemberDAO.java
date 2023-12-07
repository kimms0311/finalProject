package com.avo.www.repository;

import com.avo.www.security.MemberVO;

public interface HmemberDAO {

	MemberVO getDeail(String email);

	String getPw(String email);

	int modifyPwEmpty(MemberVO mvo);

	int modify(MemberVO mvo);

	int jgDelete(String email);

	int cmDelete(String email);

	int jobDelete(String email);

	int stDelete(String email);

	int amDelte(String email);

	int mbDelete(String email);

}
