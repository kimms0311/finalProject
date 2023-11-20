package com.avo.www.repository;

import java.util.List;

import com.avo.www.domain.PagingVO;
import com.avo.www.domain.ProductBoardVO;
import com.avo.www.handler.PagingHandler;

public interface JobBoardDAO {

	int post(ProductBoardVO pbvo);

	ProductBoardVO detail(long proBno);

	List<ProductBoardVO> getList();

	void readCount(long proBno);

	ProductBoardVO jobLike(long proBno);

//	PagingHandler getList(long pbno, PagingVO pgvo);


}
