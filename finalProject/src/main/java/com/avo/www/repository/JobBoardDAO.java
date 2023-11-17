package com.avo.www.repository;

import java.util.List;

import com.avo.www.domain.ProductBoardVO;

public interface JobBoardDAO {

	int post(ProductBoardVO pbvo);

	ProductBoardVO detail(long pbno);

	List<ProductBoardVO> getList();


}
