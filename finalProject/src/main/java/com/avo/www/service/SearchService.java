package com.avo.www.service;

import java.util.List;

import com.avo.www.domain.CommunityBoardVO;
import com.avo.www.domain.PagingVO;
import com.avo.www.domain.ProductBoardVO;

public interface SearchService {

	List<ProductBoardVO> searchProBoard(PagingVO pgvo);

//	List<CommunityBoardVO> searchCommuBoard(PagingVO pgvo);

}
