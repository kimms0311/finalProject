package com.avo.www.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.avo.www.domain.ProductBoardVO;
import com.avo.www.repository.JoongoBoardDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class JoongoBoardServiceImpl implements JoongoBoardService {

	@Inject
	private JoongoBoardDAO jbdao;

	@Override
	public int register(ProductBoardVO pbvo) {
		log.info("register service");
		return jbdao.insert(pbvo);
	}

	@Override
	public List<ProductBoardVO> getList() {
		return jbdao.getList();
	}
	
}
