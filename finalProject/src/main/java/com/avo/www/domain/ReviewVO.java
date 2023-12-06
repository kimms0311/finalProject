package com.avo.www.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@ToString
@Setter
@Getter
public class ReviewVO {
	private long reRno;
	private long reBno;
	private String reUserId;
	private String reContent;
	private int reScore;
	private String regAt;

}
