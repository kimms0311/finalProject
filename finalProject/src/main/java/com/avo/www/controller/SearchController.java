package com.avo.www.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.avo.www.domain.CommunityBoardVO;
import com.avo.www.domain.PagingVO;
import com.avo.www.domain.ProductBoardVO;
import com.avo.www.service.SearchService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/common/*")
public class SearchController {

	@Inject
	private SearchService ssv;
	
	@PostMapping("/search")
	public void postSearch(PagingVO pgvo, Model m) {
		log.info(">>>>>>>>> SearchController >>>>> "+pgvo);
		List<ProductBoardVO> pbvo = ssv.searchProBoard(pgvo);
//		List<CommunityBoardVO> cbvo = ssv.searchCommuBoard(pgvo);

		log.info(">>>>>>>>>> searchProBoard pbvo >>>>>>>>>> "+pbvo);
		m.addAttribute("pbvo", pbvo);
		
		// 검색결과에 들어온 카테고리 종류 구하기
		List<String> category = new ArrayList<String>();
		for(ProductBoardVO bvo : pbvo) {
			category.add(bvo.getProCategory().substring(3));
		}
		log.info(">>>>>>> category >>>>> "+category);
		m.addAttribute("category", category);
		
	}
}
