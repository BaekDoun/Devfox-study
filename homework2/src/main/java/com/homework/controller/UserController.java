package com.homework.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.homework.domain.UserVO;
import com.homework.security.UserSHA256;
import com.homework.service.UserService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/user/*")
public class UserController {
	@Autowired
	private UserService service;
	
	
	//로그인창으로 이동
	@GetMapping("login.do")
	public void goLogin() {
	}
	
	//회원가입창으로 이동
	@GetMapping("join.do")
	public void goJoin() {
	}
	
	//아이디와 이메일은 중복사용이 불가능하도록 체크  06/29
	@GetMapping("usernamecheckpro.do")
	public 	@ResponseBody int UsernameCheckpro(UserVO vo){
		System.out.println(vo.getUsername());
		int result = service.UsernameCheckPro(vo);
		System.out.println("controller return : " + service.UsernameCheckPro(vo));
		return result;
	}
	//회원가입이메일 체크 06/29
	@GetMapping("emailcheckpro.do")
	public 	@ResponseBody int EmailCheckpro(UserVO vo){
		System.out.println(vo.getEmail());
		int result = service.EmailCheckPro(vo);
		return result;
	}
	//유저 회원가입 06/29
	@PostMapping("userjoinpro.do")
	public String UserInsertPro(UserVO vo) {
		//sha256을 이용한 비밀번호 암호화 --추후 시큐리티로 암호화 한다. 지금은 세션을 사용할것이기 때문  06/29
		String securityPassword = UserSHA256.getSHA256(vo.getPassword());
		//암호화된 비밀번호를 다시 vo에 담는다. 06/30
		vo.setPassword(securityPassword);
		service.UserInsert(vo);
		return "redirect:/user/login.do";
	}
	
	//로그인시 비밀번호 체크와 아이디 비밀번호가 일치하면 세션을 만들어 인덱스로 넘기기 06/30
	@PostMapping("PasswordCheck.do")
	public @ResponseBody int LoginPro(@RequestParam String username, 
			@RequestParam String password, HttpServletResponse response){
		System.out.println("아이디 : " + username);
		System.out.println("비밀번호 : " + password);
		UserVO vo = new UserVO();
		vo.setUsername(username);
		int usernameCheck = service.UsernameCheckPro(vo);
		//등록된 유저가 없으면 로그인창으로 보낸다. 06/30
		System.out.println("usernmaeCheck : "+usernameCheck);
		//존재하지 않는 아이디일경우 0을 반환한다. 06/30
		if(usernameCheck == 0) {
		    return 0;
		}
		
		UserVO realVo = service.readUser(username);
		String checkPassword = UserSHA256.getSHA256(password);
		System.out.println("등록비밀번호"+checkPassword);
		System.out.println("디비비밀번호"+realVo.getPassword());
		//아이디는 존재하나 입력한 비밀번호와 일치 하지 않으면 1을 반환한다. 06/30
		if(!checkPassword.equals(realVo.getPassword())) {
			return 1;
		}
		//아이디와 비밀번호가 전부 일치하면 2를 반환한다. 06/30
		return 2;
	}
	
	//아이디와 비밀번호가 일치할겅우 세션을 만들어 서버에 저장하여 로그인 상태로 관주한다. 06/30
	@PostMapping("loginpro.do")
	public String LoginPro(UserVO vo, HttpSession session, Model model) {
		UserVO loginVo = service.readUser(vo.getUsername());
		session.setAttribute("sessionUser", loginVo);
		
		return "redirect:/";
	}
	
	@GetMapping("logout.do")
	public String Logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();
		
		return "redirect:/";
	}
}
