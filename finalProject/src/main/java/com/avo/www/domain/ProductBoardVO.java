package com.avo.www.domain;

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
public class ProductBoardVO {

	private long proBno;
	private String proEmail;
	private String proNickName;
	private String proTitle;
	private String proContent;
	
	private int proPrice;
	private String proCategory;
	private String proMenu;
	
	private int proLikeCnt;
	private int proReadCnt;
	private int proChatCnt;
	
	private String proRegAt;
	private String proModAt;
	private String proReAt;
	
	private String proSido;
	private String proSigg;
	private String proEmd;
	
	private String proIsDel;
	
}
