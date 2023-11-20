package com.avo.www.controller;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.avo.www.domain.PagingVO;
import com.avo.www.domain.ProductBoardVO;
import com.avo.www.handler.PagingHandler;
import com.avo.www.service.JobBoardService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Configuration
@RequestMapping("/job/*")
public class JobBoardController {
   @Inject
   private JobBoardService jbsv;
   
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
   public String postRegister(ProductBoardVO pbvo, RedirectAttributes re) {
	   log.info(">>>>> job postRegister page >> ");
	   
	   int isOk = jbsv.post(pbvo);
	   log.info(">>>>> board register >>" + (isOk > 0 ? "OK" : "FAIL"));
	   return "redirect:/job/list";
   }
   
	@GetMapping({ "/detail", "/modify" })
	public void detail(Model model, @RequestParam("proBno")long proBno) {
		log.info("pbno >> " + proBno);
//		String으로 지정하지 않고 void로 설정 시 알아서 detail이나 modify중 진입 경로대로 감
		log.info(">>>>> job get detail or modify page >> ");
		// 파일 내용도 포함해서 같이 가져가야 함
		ProductBoardVO pbvo = jbsv.getDetail(proBno);
		model.addAttribute("pbvo", pbvo);
		
		
	}
	@GetMapping({ "/like" })
	public String jobLike(@RequestParam("proBno")long proBno) {
		log.info("proBno>>"+proBno);
		
		ProductBoardVO pbvo = jbsv.jobLike(proBno);
		
		return "redirect:/job/detail?pbno=${pbvo.proBno}";
		
	}
   
   

}