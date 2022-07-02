package com.homework.domain;

import lombok.Data;

@Data
public class BoardVO {
	private int boardidx;
	private int useridx;
	private String title;
	private String contents;
	private String boardregdate;
	private String nicname;
	private String boardpassword;
	private String readcnt;
}
