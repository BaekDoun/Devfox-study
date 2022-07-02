package com.homework.service;

import com.homework.domain.UserVO;

public interface UserService {
	//유저 아이디 중복 체크
	public int UsernameCheckPro(UserVO vo);
	//유저 이메일 중복 체크
	public int EmailCheckPro(UserVO vo);
	//유저 등록
	public void UserInsert(UserVO vo);
	//로그인정보 가져오기
	public UserVO readUser(String username);
	
}
