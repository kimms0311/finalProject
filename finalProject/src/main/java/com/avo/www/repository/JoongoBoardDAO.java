package com.avo.www.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.avo.www.domain.LikeItemVO;
import com.avo.www.domain.PagingVO;
import com.avo.www.domain.ProductBoardVO;

public interface JoongoBoardDAO {

   int insert(ProductBoardVO pbvo);

//   List<ProductBoardVO> getList();

   ProductBoardVO getDetail(long bno);

   int update(ProductBoardVO pbvo);

   int delete(long bno);

   List<ProductBoardVO> getListMore(PagingVO pgvo);

   int selectJoongoTotal(PagingVO pgvo);

   void setReadCnt(@Param("bno") long bno, @Param("i") int i);

   void setLikeCnt();

   void updateLikeCnt(@Param("livo") LikeItemVO livo, @Param("i") int i);

   long selectOneBno();

   void setFileCnt();
   
   List<ProductBoardVO> searchProBoard(PagingVO pgvo);

}