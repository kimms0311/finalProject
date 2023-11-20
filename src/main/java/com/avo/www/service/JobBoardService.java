package com.avo.www.service;

import java.util.List;

import com.avo.www.domain.PagingVO;
import com.avo.www.domain.ProductBoardVO;
import com.avo.www.handler.PagingHandler;

public interface JobBoardService {

	int post(ProductBoardVO pbvo);

	ProductBoardVO getDetail(long proBno);

	List<ProductBoardVO> getList();

	ProductBoardVO jobLike(long proBno);

//	List<ProductBoardVO> getList(long pbno, PagingVO pgvo);


}
