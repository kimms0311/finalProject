package com.avo.www.controller;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.avo.www.service.jobReviewService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/review/*")
@RestController
public class jobReviewController {
	
	@Inject
	private jobReviewService jrsv;
	
//	@PostMapping(value="/post", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
//	public ResponseEntity<String> post(@RequestBody CommentVO cvo){
//		log.info(">>>> cvo>> "+cvo);
//		return csv.post(cvo) > 0? new ResponseEntity<String>("1", HttpStatus.OK) :
//			new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
//	}
//	
//	@GetMapping(value = "/{bno}/{page}", produces = MediaType.APPLICATION_JSON_VALUE)
//	public ResponseEntity<PagingHandler> spread(@PathVariable("bno")long bno, 
//			@PathVariable("page")int page){
//		log.info(">>>> bno / page >> "+bno +"   "+page);
//		PagingVO pgvo = new PagingVO(page, 5);
//		return new ResponseEntity<PagingHandler>(
//				csv.getList(bno, pgvo), HttpStatus.OK);
//	}
//	
//	@DeleteMapping(value="/del/{cno}/{writer}", produces = MediaType.TEXT_PLAIN_VALUE)
//	public ResponseEntity<String> erase(@PathVariable("cno")long cno, @PathVariable("writer")String writer, 
//			Principal principal){
//		log.info(">>>>>> comment delete >> writer>  "+writer);
//		String username = principal.getName(); 
//		log.info(">>>>>> comment delete >> username>  "+username);
//		int isOk = 0;
//		if(writer.equals(username)) {
//			 isOk = csv.remove(cno);
//		}
//		return isOk > 0 ?  new ResponseEntity<String>("1", HttpStatus.OK) :
//			new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
//		
//	}
//	 
//	@PutMapping(value = "/{cno}", consumes = "application/json", 
//			produces = MediaType.TEXT_PLAIN_VALUE)
//	public ResponseEntity<String> edit(@PathVariable("cno")long cno,
//			@RequestBody CommentVO cvo){
//		return csv.modify(cvo) > 0? new ResponseEntity<String>("1", HttpStatus.OK) : 
//			new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
//	}
//	
//
}
