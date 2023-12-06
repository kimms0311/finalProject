package com.avo.www.service;

import java.util.List;

import com.avo.www.domain.FileVO;
import com.avo.www.security.MemberVO;

public interface HmemberService {

	MemberVO getDetail(String email);

	String getPw(String email);

	boolean isPasswordCorrect(String email, String pw);

	int modifyPwEmpty(MemberVO mvo);

	int modify(MemberVO mvo);

	int proInsert(String email, List<FileVO> flist);

	FileVO getProfile(String email);

	int proDelete(String email);

	int memDelete(String email);

}
