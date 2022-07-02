package com.homework.domain;

import lombok.Data;

@Data
public class Criteria {
	private String email;
	
	private int pageNum;//페이지 번호
	private int amount;//한 페이지에 출력하고자하는 자료의 개수
	
	private String type; //검색어의 타입
	private String keyword; //검색어
	
	public Criteria() {
		this(1,10);
	}

	public Criteria(int pageNum, int amount) {//pageNum =1 ,amount=10
		this.pageNum =pageNum;
		this.amount = amount;
	}
}
