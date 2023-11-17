package com.avo.www.service;

import java.util.List;

import com.avo.www.domain.ProductBoardVO;

public interface JobBoardService {

	int post(ProductBoardVO pbvo);

	ProductBoardVO getDetail(long pbno);

	List<ProductBoardVO> getList();

}
