package com.avo.www.service;

import java.util.List;

import com.avo.www.domain.ProductBoardVO;

public interface JoongoBoardService {

	int register(ProductBoardVO pbvo);

	List<ProductBoardVO> getList();

}
