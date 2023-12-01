package com.avo.www.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.avo.www.domain.CommunityBoardVO;
import com.avo.www.domain.PagingVO;
import com.avo.www.domain.ProductBoardVO;
import com.avo.www.repository.CommunityBoardDAO;
import com.avo.www.repository.JoongoBoardDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class SearchServiceImpl implements SearchService {
	
	@Inject
	private JoongoBoardDAO pgdao;
	
	@Inject
	private CommunityBoardDAO cgdao;
	
	@Override
	public List<ProductBoardVO> searchProBoard(PagingVO pgvo) {
		// TODO Auto-generated method stub
		return pgdao.searchProBoard(pgvo);
	}

//	@Override
//	public List<CommunityBoardVO> searchCommuBoard(PagingVO pgvo) {
//		// TODO Auto-generated method stub
//		return cgdao.searchCommuBoard(pgvo);
//	}

	
}
