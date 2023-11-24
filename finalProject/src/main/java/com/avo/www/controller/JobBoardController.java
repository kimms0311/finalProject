package com.avo.www.controller;


import java.util.List;

import javax.inject.Inject;

import org.springframework.context.annotation.Configuration;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.avo.www.domain.FileVO;
import com.avo.www.domain.JobBoardDTO;
import com.avo.www.domain.ProductBoardVO;
import com.avo.www.handler.FileHandler;
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
   
//   @GetMapping("/list")
//   public void getList() {
//      log.info(">>>>> job list page >> ");
//   }

   @GetMapping("/list")
   public String getList(Model m, ProductBoardVO pbvo) {
	   log.info(">>>>> job list page >> ");
	   List<ProductBoardVO> list = jbsv.getList();
	   m.addAttribute("list",list);
	   
	   return ("/job/list");
   }

   
//   //LIST에 페이징추가
//   @GetMapping(value="/list", produces = MediaType.APPLICATION_JSON_VALUE)
//   public ResponseEntity<PagingHandler> spread(
//			@PathVariable("proBno") long pbno, @PathVariable("page")int page, Model m){
//	   log.info(">>>>> job list page >> ");
//	   PagingVO pgvo = new PagingVO(page , 5);
//	   List<ProductBoardVO> list = jbsv.getList(pbno,pgvo);
//	   m.addAttribute("list",list);
//	   
//	   return new ResponseEntity<PagingHandler>(jbsv.getList(pbno,pgvo),HttpStatus.OK);
//   }
//   
   
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
		   flist = fh.uploadFiles(files,"job");
	   }
	   
//	   post에 pbvo,flist값을 DTO로 보냄
	   int isUp = jbsv.post(new JobBoardDTO(pbvo,flist));
	   re.addFlashAttribute("isUp", isUp);
	   return "redirect:/job/list";
   }
   
	@GetMapping({ "/detail", "/modify" })
	public void detail(Model m, @RequestParam("proBno")long proBno) {
//		String으로 지정하지 않고 void로 설정 시 알아서 detail이나 modify중 진입 경로대로 감
		log.info(">>>>> job get detail or modify page >> ");
		log.info("proBno >> " + proBno);
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
			   flist = fh.uploadFiles(files,"job");
		   }
		
		int isOk = jbsv.modify(new JobBoardDTO(pbvo,flist));
		
		re.addAttribute("proBno", pbvo.getProBno());
		re.addFlashAttribute("isMod", isOk);
		return "redirect:/job/detail";
	}
	
	
	
	@GetMapping({ "/like" })
	public String jobLike(@RequestParam("proBno")long proBno) {
		log.info(">>>>> job get like page >> ");
		log.info("proBno>>"+proBno);
		
		ProductBoardVO pbvo = jbsv.jobLike(proBno);
		
		return "redirect:/job/detail/{proBno}";
		
	}
   
   

}