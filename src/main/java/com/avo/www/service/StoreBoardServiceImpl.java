package com.avo.www.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.avo.www.repository.StoareBoardDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class StoreBoardServiceImpl implements StoreBoardService {
	@Inject
	private StoareBoardDAO sdao;
}
