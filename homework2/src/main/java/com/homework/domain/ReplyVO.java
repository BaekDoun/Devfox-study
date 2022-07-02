package com.homework.domain;

import lombok.Data;

@Data
public class ReplyVO {
	int replyidx;
	int boardidx;
	int useridx;
	String nicname;
	String replypassword;
	String replyregdate;
	int parent;
	
}
