package com.avo.www.controller;


import java.security.Principal;
import java.util.List;

import javax.inject.Inject;

import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.avo.www.domain.FileVO;
import com.avo.www.domain.JobBoardDTO;
import com.avo.www.domain.LikeItemVO;
import com.avo.www.domain.PagingVO;
import com.avo.www.domain.ProductBoardVO;
import com.avo.www.handler.FileHandler;
import com.avo.www.handler.PagingHandler;
import com.avo.www.service.JobBoardService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Configuration
@RequestMapping("/job/*")
public class JobBoardController {
	
   @Inject
   private JobBoardService jbsv;
   @Inject
	private FileHandler fh;
   
   @GetMapping("/list")
   public String getList(Model m, ProductBoardVO pbvo) {
	   log.info(">>>>> job list page >> ");
	   log.info(">>>>> pbvo >> "+pbvo);
	   
	   
	   List<JobBoardDTO> list = jbsv.getList();
	   log.info(">>>>> get list >> "+list);

	   m.addAttribute("list",list);
	   return ("/job/list");
   }
	
   @GetMapping("/register")
   public void getRegister() {
	   log.info(">>>>> job register page >> ");
   }
   
   @PostMapping("/register")
   public String postRegister(ProductBoardVO pbvo, RedirectAttributes re,
		   @RequestParam(name = "files", required = false)MultipartFile[] files) {
	   log.info(">>>>> job postRegister page >> ");
	   log.info(">>>>> pbvo >> files >> " + pbvo + " / " + files);
	   
	   List<FileVO> flist = null;
	   
//	   files 0번지의 값이 0보다 크다면 파일 有 flist에 담기
	   if(files[0].getSize() > 0) {
		   flist = fh.uploadFiles(files,"product");
	   }
	   
//	   post에 pbvo,flist값을 DTO로 보냄
	   int isUp = jbsv.post(new JobBoardDTO(pbvo,flist));
	   re.addFlashAttribute("isUp", isUp);
	   return "redirect:/job/list";
   }
   
	@GetMapping({ "/detail", "/modify" })
	public void detail(Model m, @RequestParam("proBno")long proBno, Principal principal) {
		//String으로 지정하지 않고 void로 설정 시 알아서 detail이나 modify중 진입 경로대로 감

	    log.info(">>>>> job get detail or modify page >> ");
	    log.info("proBno >> " + proBno);
	    
	    //찜하기 옆에 보여질 게시글에 대한 likeCnt;
	    int checkLikeCnt = jbsv.checkLikeCnt(proBno);
		    if(checkLikeCnt > 0) {
		    	m.addAttribute("checkLikeCnt", checkLikeCnt);
		    }
	    

	    // 로그인 한 상태일 경우 현재 사용자의 이메일 가져오기
	    if(principal != null) {
		    String memEmail = principal.getName();
		    log.info(" principal.getName() >> " +  principal.getName());
	
		    // 찜하기 여부 확인
		    int checkLike = jbsv.checkLike(proBno, memEmail);

			    // 찜하기 여부 보내기
			    if (checkLike > 0) {
			        m.addAttribute("checkLike", checkLike);
			    }
	    }

	    // 파일 내용도 포함해서 같이 가져가야 함
	    m.addAttribute("jbdto", jbsv.getDetail(proBno));
	}

	@PostMapping("/modify")
	public String modify(RedirectAttributes re, ProductBoardVO pbvo,
			@RequestParam(name = "files", required = false)MultipartFile[] files) {
		log.info(">>>>> job post modify page >> ");
		log.info(">>>>> pbvo >> files >> " + pbvo + " / " + files);
		
		List<FileVO>flist = null;

		if(files[0].getSize() > 0) {
			   flist = fh.uploadFiles(files,"product");
		   }
		
		int isOk = jbsv.modify(new JobBoardDTO(pbvo,flist));
		
		re.addAttribute("proBno", pbvo.getProBno());
		re.addFlashAttribute("isMod", isOk);
		return "redirect:/job/detail";
	}
	
	
	@GetMapping("/remove")
	public String remove(RedirectAttributes re, @RequestParam("proBno")long proBno) {
		int isDel = jbsv.remove(proBno);
		re.addFlashAttribute("isDel", isDel);
		return "redirect:/job/list";
	}
	

	@PostMapping(value = "/like", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> likeBtn(@RequestBody LikeItemVO livo){
        log.info("LikeItemVO >> "+livo);

        // likeVO service 전송
        if(livo.getLiStatus() == 1) {
        	int isOk = jbsv.insertLike(livo);
        	log.info("찜 "+(isOk > 0 ? "성공" : "실패"));
        }else {
        int isOk = jbsv.deleteLike(livo);
        log.info("like>> deleteLike >> else live >> " + livo);
        log.info("찜 "+(isOk > 0 ? "성공" : "실패"));
        }
		return new ResponseEntity<String>("", HttpStatus.OK);
	}

	
	@GetMapping(value = "/page/{page}/{type}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<PagingHandler> spread(@PathVariable("page") int page, 
	        @PathVariable("type") String type) {
	    
	    PagingVO pgvo = new PagingVO(page, 8, type);
	    return new ResponseEntity<PagingHandler>(jbsv.getPageList(pgvo), HttpStatus.OK);
	}
	
	 @GetMapping("/about")
	 public void getAbout() {
		 log.info(">>>>> job about page >> ");
	 }
   
   

}