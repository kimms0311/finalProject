package com.avo.www.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.avo.www.domain.FileVO;
import com.avo.www.domain.JobBoardDTO;
import com.avo.www.domain.ProductBoardVO;
import com.avo.www.repository.JobFileDAO;
import com.avo.www.repository.JobBoardDAO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class JobBoardServiceImpl implements JobBoardService {
	@Inject
	private JobBoardDAO jdao;
	@Inject
	private JobFileDAO fdao;
	
//	@Override
//	@Transactional
//	public int post(ProductBoardVO pbvo) {
//		return jdao.post(pbvo);
//	}

	@Override
	public JobBoardDTO getDetail(long proBno) {
		log.info("proBno>>"+proBno);
		jdao.readCount(proBno,1);
		JobBoardDTO jbdto = new JobBoardDTO(jdao.detail(proBno),fdao.getFileList(proBno));
		return jbdto;
	}
	
	@Transactional
	@Override
	public List<ProductBoardVO> getList() {
		return jdao.getList();
	}

	@Transactional
	@Override
	public ProductBoardVO jobLike(long proBno) {
		log.info("proBno>>"+proBno);
		return jdao.jobLike(proBno);
	}

	
	@Transactional
	@Override
	public int modify(ProductBoardVO pbvo) {
//		수정시 1개씩 조회올라가는거 방지
		jdao.readCount(pbvo.getProBno(),-1);
		return jdao.modify(pbvo);
	}

	@Transactional
	@Override
	public int post(JobBoardDTO jbdto) {
		//jbdto에 담긴 pbvo, flist 각자 db에 저장
		
		// post는 pbvo
		int isUp = jdao.post(jbdto.getPbvo());
		
		// fileUpload는 flist
		// 파일이 없을 경우 생략
		if(jbdto.getFlist() == null) {
			isUp *= 1;
			return isUp;
		}
		// 파일이 있는 경우 조건 확인 후 insertFile
		if(isUp > 0 && jbdto.getFlist().size() > 0) {
			long bno = jdao.selectOneBno(); // 가장 마지막에 등록된 bno 가져오기
			log.info("getFlist >> max bno>> " + bno);
			
			for(FileVO fvo : jbdto.getFlist()) {
				fvo.setBno(bno);
				isUp *= fdao.insertFile(fvo);
			}
		}
		
		
		return isUp;
	}

//	@Override
//	public PagingHandler getList(long pbno, PagingVO pgvo) {
//		return jdao.getList(pbno,pgvo);
//	}
	
	
	
	

}
