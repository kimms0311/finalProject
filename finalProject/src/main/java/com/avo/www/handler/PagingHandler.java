package com.avo.www.handler;

import java.util.List;

import com.avo.www.domain.CommunityBoardVO;
import com.avo.www.domain.CommunityCmtVO;
import com.avo.www.domain.CommunityReCmtVO;
import com.avo.www.domain.FileVO;
import com.avo.www.domain.JobBoardDTO;
import com.avo.www.domain.PagingVO;
import com.avo.www.domain.ProductBoardVO;
import com.avo.www.domain.ReviewVO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PagingHandler {

   private int startPage;
   private int endPage;
   private int realEndPage;
   
   private int totalCount;
   private PagingVO pgvo;
   
   private List<ProductBoardVO> prodList;
   private List<CommunityCmtVO> cmtList;
   private List<CommunityReCmtVO> reCmtList;
   
   //1123 하연 추가
   private List<FileVO> prodFileList;
   
   private List<CommunityBoardVO> cmList;

   //23.12.06 미수 추가 리뷰 페이징용
   private List<ReviewVO> jobReList;
   
   public PagingHandler(PagingVO pgvo, int totalCount, int minus) {
      
      this.pgvo = pgvo;
      this.totalCount = totalCount;
      
      this.endPage = 
            (int)Math.ceil(pgvo.getPageNo() / (double)pgvo.getQty()) * pgvo.getQty();
     this.startPage = endPage - minus;
     
     this.realEndPage = (int)Math.ceil(totalCount / (double)pgvo.getQty());
     if(this.realEndPage < this.endPage) {
         this.endPage = this.realEndPage;
      }
     
     
   }
   
   // 게시글 페이징용
   public PagingHandler(PagingVO pgvo, int totalCount, List<ProductBoardVO> prodList) {
      this(pgvo, totalCount, 7);
      this.prodList = prodList;
   }
   
   //댓글 페이징용
   public PagingHandler(int totalCount, PagingVO pgvo, List<CommunityCmtVO> cmtList, List<CommunityReCmtVO> reCmtList) {
      this(pgvo, totalCount, 9);
      this.cmtList = cmtList;
      this.reCmtList = reCmtList;
   }
   
   //1123 하연 추가
   public PagingHandler(PagingVO pgvo, int totalCount, List<ProductBoardVO> prodList, List<FileVO> prodFileList) {
         this(pgvo, totalCount, 9);
         this.prodList = prodList;
         this.prodFileList =  prodFileList;
      }

   //커뮤니티 페이징용
   public PagingHandler(int totalCount, PagingVO pgvo, List<CommunityBoardVO> cmList) {
	      this(pgvo, totalCount, 9);
	      this.cmList = cmList;
	}

   // 23.12.06 미수 추가 리뷰 페이징용
   public PagingHandler(PagingVO pgvo, List<ReviewVO> jobReList, int totalCount) {
	    this(pgvo, totalCount, 5);
	    this.jobReList = jobReList;
	}

   // 23.12.12 미수 추가 jobList 페이징용
	public PagingHandler(List<JobBoardDTO> jbdtoList, PagingVO pgvo, int totalCount ) {
	}

}