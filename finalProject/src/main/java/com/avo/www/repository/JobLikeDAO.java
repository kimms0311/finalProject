package com.avo.www.repository;

import org.apache.ibatis.annotations.Param;

import com.avo.www.domain.LikeItemVO;

public interface JobLikeDAO {

	int insertLike(LikeItemVO livo);

	int updateLike(LikeItemVO livo);

	int checkLike(@Param("proBno")long proBno, @Param("memEmail") String memEmail);
	

}
