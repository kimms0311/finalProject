package com.avo.www.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PagingVO {

   private int pageNo; // 페이지 번호
   private int qty; // 한 페이지에 보여줄 글 개수
   private String keyword; // 검색어
   
   public PagingVO() {
      this(1,8); // 한 페이지당 글 8개씩 출력
   }
   
   public PagingVO(int pageNo, int qty) {
      this.pageNo = pageNo;
      this.qty = qty;
   }
   
   // limit getPageStart, qty
   public int getPageStart() {
      return (this.pageNo-1)*qty;
   }
   
}
