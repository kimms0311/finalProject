package com.avo.www.handler;

import java.util.List;

import com.avo.www.domain.FileVO;
import com.avo.www.domain.PagingVO;
import com.avo.www.domain.ProductBoardVO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class PagingHandler {

   private int startPage;
   private int endPage;
   private int realEndPage;
   
   private int totalCount;
   private PagingVO pgvo;
   
   private List<ProductBoardVO> prodList;
   
   //1123 하연 추가
   private List<FileVO> prodFileList;
   
   public PagingHandler(PagingVO pgvo, int totalCount) {
      
      this.pgvo = pgvo;
      this.totalCount = totalCount;
      
      this.endPage = 
				(int)Math.ceil(pgvo.getPageNo() / (double)pgvo.getQty())*pgvo.getQty();
		
		this.startPage = endPage - 9;		
		this.realEndPage = 
				(int)Math.ceil(totalCount/(double)pgvo.getQty());
		
		if(realEndPage < endPage) {
			this.endPage = realEndPage;
		}
   }
   
   public PagingHandler(PagingVO pgvo, int totalCount, List<ProductBoardVO> prodList) {
      this(pgvo, totalCount);
      this.prodList = prodList;
   }
   
   //1123 하연 추가
   public PagingHandler(PagingVO pgvo, int totalCount, List<ProductBoardVO> prodList, List<FileVO> prodFileList) {
	      this(pgvo, totalCount);
	      this.prodList = prodList;
	      this.prodFileList =  prodFileList;
	   }
   
}