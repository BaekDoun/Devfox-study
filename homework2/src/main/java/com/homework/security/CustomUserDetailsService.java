package com.homework.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.homework.domain.UserVO;
import com.homework.mapper.UserMapper;

import lombok.extern.log4j.Log4j;
@Log4j
public class CustomUserDetailsService implements UserDetailsService {
	
	@Autowired
	private UserMapper mapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		UserVO vo = mapper.readUser(username);
		log.warn("User mapper : " + vo);
		//vo가 null이면 null을 리턴하고 null이 아니면 vo(User)를 리턴한다. 07/12
		return vo == null ? null:new CustomUser(vo);
	}

}
