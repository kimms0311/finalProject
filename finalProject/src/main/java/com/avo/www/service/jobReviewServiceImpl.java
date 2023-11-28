package com.avo.www.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.avo.www.repository.jobReviewDAO;

@Service
public class jobReviewServiceImpl implements jobReviewService{
	
	@Inject
	private jobReviewDAO jrdao;
	

}
