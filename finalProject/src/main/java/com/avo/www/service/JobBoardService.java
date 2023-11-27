package com.avo.www.service;

import java.util.List;

import com.avo.www.domain.JobBoardDTO;
import com.avo.www.domain.ProductBoardVO;

public interface JobBoardService {

//	int post(ProductBoardVO pbvo);

	JobBoardDTO getDetail(long proBno);

	List<ProductBoardVO> getList();

	ProductBoardVO jobLike(long proBno);

//	int modify(ProductBoardVO pbvo);

	int post(JobBoardDTO jbdto);

	int modify(JobBoardDTO jbdto);

	int remove(long proBno);

//	List<ProductBoardVO> getList(long pbno, PagingVO pgvo);


}
