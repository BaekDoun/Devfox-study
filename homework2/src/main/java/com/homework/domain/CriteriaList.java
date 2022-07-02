package com.homework.domain;

import lombok.Data;

@Data
public class CriteriaList {
	private int user_idx;
	
	private int pageNum;//페이지 번호
	private int amount;//한 페이지에 출력하고자하는 자료의 개수
	
	private String type; //검색어의 타입
	private String keyword; //검색어
	
	public CriteriaList() {
		this(1,4);
	}

	public CriteriaList(int pageNum, int amount) {//pageNum =1 ,amount=4
		this.pageNum =pageNum;
		this.amount = amount;
	}
}
