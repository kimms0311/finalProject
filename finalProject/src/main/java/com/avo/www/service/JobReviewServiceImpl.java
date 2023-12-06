package com.avo.www.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.avo.www.domain.ReviewVO;
import com.avo.www.repository.JobReviewDAO;

@Service
public class JobReviewServiceImpl implements JobReviewService{
	
	@Inject
	private JobReviewDAO jrdao;

	@Override
	public int postReview(ReviewVO rvo) {
		return jrdao.postReview(rvo);
	}
	

}
