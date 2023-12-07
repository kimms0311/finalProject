package com.avo.www.repository;

import com.avo.www.domain.FileVO;

public interface ProfileFileDAO {

	int proInsert(FileVO fvo);

	FileVO getProfile(String email);

	int proDelete(String email);

}
