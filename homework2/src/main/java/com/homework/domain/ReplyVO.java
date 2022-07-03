package com.homework.domain;

import lombok.Data;

@Data
public class ReplyVO {
	private int replyidx;
	private int boardidx;
	private int useridx;
	private String nicname;
	private String replypassword;
	private String replyregdate;
	private int parent;
	private String replycontents;
	
}
