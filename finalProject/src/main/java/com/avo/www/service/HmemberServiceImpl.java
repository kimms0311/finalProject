package com.avo.www.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.avo.www.domain.FileVO;
import com.avo.www.repository.HmemberDAO;
import com.avo.www.repository.ProfileFileDAO;
import com.avo.www.security.MemberVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class HmemberServiceImpl implements HmemberService {
	@Inject
	private HmemberDAO hdao;
	
	@Inject
    private PasswordEncoder passwordEncoder;
	
	@Inject
	private ProfileFileDAO pdao;
	
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

	@Override
	public int modifyPwEmpty(MemberVO mvo) {
		return hdao.modifyPwEmpty(mvo);
	}

	@Override
	public int modify(MemberVO mvo) {
		return hdao.modify(mvo);
	}

	@Override
	public int proInsert(String email, List<FileVO> flist) {
		//기존 프로필 삭제
		int isOk = pdao.proDelete(email);
		if(flist.size() > 0) {
			for(FileVO fvo : flist) {
				fvo.setPrEmail(email);
				isOk = pdao.proInsert(fvo);
			}
		}
		return isOk;
	}

	@Override
	public FileVO getProfile(String email) {
		return pdao.getProfile(email);
	}

	@Override
	public int proDelete(String email) {
		return pdao.proDelete(email);
	}

	@Override
	public int memDelete(String email) {
		int isDel = 0;
		//중고 게시글 삭제
		isDel = hdao.jgDelete(email);
		//동네 게시글 삭제
		isDel = hdao.cmDelete(email);
		//알바 게시글 삭제
		isDel = hdao.jobDelete(email);
		//업체 게시글 삭제
		isDel = hdao.stDelete(email);
		//권한 삭제
		isDel = hdao.amDelte(email);
		//멤버 삭제
		isDel = hdao.mbDelete(email);
		return isDel;
	}

}
