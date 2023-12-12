package com.avo.www.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.avo.www.domain.JobBoardDTO;
import com.avo.www.domain.LikeItemVO;
import com.avo.www.domain.PagingVO;
import com.avo.www.domain.ProductBoardVO;

public interface JobBoardDAO {

	ProductBoardVO detail(long proBno);

	List<ProductBoardVO> getList();

	ProductBoardVO jobLike(long proBno);

	int modify(ProductBoardVO pbvo);

	void readCount(@Param("proBno")long proBno, @Param("cnt")int cnt);

	int post(ProductBoardVO pbvo);

	long selectOneBno();

	int delete(long proBno);

	int updateLikeCnt(@Param("livo")LikeItemVO livo,@Param("i")int i);

	int checkLikeCnt(long proBno);

	int getTotalCount(PagingVO pgvo);

	List<ProductBoardVO> listPaging(PagingVO pgvo);

//	PagingHandler getList(long pbno, PagingVO pgvo);


}
