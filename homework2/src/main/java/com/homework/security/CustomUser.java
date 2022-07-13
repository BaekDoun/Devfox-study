package com.homework.security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.homework.domain.UserVO;

import lombok.Getter;

@Getter
public class CustomUser extends User{
	
	private static final  long serialVersionUID = 1L;
	
	private UserVO user;
	
	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> autorities) {
		super(username, password, autorities);
		//user 클래스를 상속하기 때문에 부모 클래스 생성자를 호출해야 한다.
	}
	public static List<String> AuthListMake(UserVO vo){
		// 스프링 시큐리티는 한번에 여러가지 권한을 줄 수 있기 때문에 권한들을 리스트에 담아 리턴하기 위한 메소드 07/12 
		List<String> authlist = new ArrayList<String>();
		authlist.add(vo.getAuth());
		//권한 콘솔 테스트 07/12
		System.out.println(authlist);
		return authlist;
	}
	
	
	public CustomUser(UserVO vo) {
		super(vo.getUsername(), vo.getPassword(), AuthListMake(vo).stream().map(auth-> 
		new SimpleGrantedAuthority(auth)).collect(Collectors.toList()));
		this.user = vo;
	}
	
}
