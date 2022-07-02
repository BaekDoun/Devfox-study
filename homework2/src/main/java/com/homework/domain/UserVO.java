package com.homework.domain;

import lombok.Data;
//06.27 lombok @Data로 인해 getter, setter 자동생성
@Data
public class UserVO {
	private int useridx;
	private String username;
	private String password;
	private String name;
	private String email;
	private String tel;
	private String auth;
	private String nicname;
	private String regdate;
}
