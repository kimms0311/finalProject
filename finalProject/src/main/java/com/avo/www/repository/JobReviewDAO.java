package com.avo.www.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.avo.www.domain.PagingVO;
import com.avo.www.domain.ReviewVO;

public interface JobReviewDAO {

	int postReview(ReviewVO rvo);

	int selectOntBnoTotalCount(long reBno);

	List<ReviewVO> selectListPaging(@Param("reBno")long reBno, @Param("pgvo") PagingVO pgvo);

	int delete(long reRno);

	int update(@Param("reRno")long reRno, @Param("rvo")ReviewVO rvo);

}
