package com.avo.www.repository;

import java.util.List;

import com.avo.www.domain.ProductBoardVO;

public interface JoongoBoardDAO {

	int insert(ProductBoardVO pbvo);

	List<ProductBoardVO> getList();

}
