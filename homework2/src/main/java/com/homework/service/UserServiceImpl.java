package com.homework.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.homework.domain.UserVO;
import com.homework.mapper.UserMapper;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	UserMapper mapper;
	
	@Override
	public int UsernameCheckPro(UserVO vo) {
		System.out.println("service return :" + mapper.UsernameCheckPro(vo));
		return mapper.UsernameCheckPro(vo);
	}
	@Override
	public int EmailCheckPro(UserVO vo) {
		return mapper.EmailCheckPro(vo);
	}
	@Override
	public void UserInsert(UserVO vo) {
		mapper.UserInsert(vo);	
	}
	@Override
	public UserVO readUser(String username) {
		return mapper.readUser(username);
	}
	
}
