package com.homework.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.homework.domain.BoardVO;
import com.homework.security.UserSHA256;
import com.homework.service.BoardService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/")
public class BoardController {
	@Autowired
	BoardService service;
	
	@GetMapping("boardwrite.do")
	public void goWrite() {
	}
	
	//글 등록하기 06/30
	@PostMapping("boardwritepro.do")
	public String writePro(BoardVO vo) {
		System.out.println("board 컨트롤러 들어옴");
		
		System.out.println("title : "+vo.getTitle());
		System.out.println("contents : "+vo.getContents());
		System.out.println("nicname : "+vo.getNicname());
		System.out.println("PW : "+vo.getBoardpassword());
		// 비회원이 등록한 경우 즉, 비밀번호가 null이 아니면 암호화 수행
		if(vo.getBoardpassword() != null) {
			System.out.println("비회원이 등록하여 비밀번호를 암호화 하여 등록합니다.");
			String securityPassword = UserSHA256.getSHA256(vo.getBoardpassword());
			vo.setBoardpassword(securityPassword);			
			service.insertBoard(vo);
		}else {
			System.out.println("회원이 등록한 글이므로 비밀번호는 필요없습니다.");
			service.loginInsertBoard(vo);
		}
		return "redirect:/";
	}
	
	//board view 로 이동 07/01
	@GetMapping("boardview.do")
	public void getBoardVo(Model model, BoardVO vo){
		System.out.println(vo.getBoardidx());
		BoardVO realvo = service.getBoardVo(vo);
		model.addAttribute("vo",realvo);
		
	}
	//board modify 로 이동 07/01
	@GetMapping("boardmodify.do")
	public void viewModify(Model model, BoardVO vo){
		System.out.println(vo.getBoardidx());
		BoardVO realvo = service.getBoardVo(vo);
		model.addAttribute("vo",realvo);
	}
	
	//modify 패스워드 체크
	@PostMapping("boardpasswordcheck.do")
	public @ResponseBody int checkModifyPassword(BoardVO vo) {
		System.out.println(vo.getBoardidx());
		System.out.println(vo.getBoardpassword());
		BoardVO checkvo = service.getBoardVo(vo);
		//전송받은 비밀번호 암호화 
		String securityPassword = UserSHA256.getSHA256(vo.getBoardpassword());
		if(checkvo.getBoardpassword().equals(securityPassword)) {
			return 1;
		}else {
			return 0;			
		}
	}
	//수정하기  07/01
	@PostMapping("boardmodifypro.do")
	public String modifyPro(BoardVO vo) {
		service.modifyPro(vo);
		System.out.println("수정완료");
		return "redirect:/";
	}
	
	//삭제하기 비번 체크 윈도우창 새로 열기 07/01
	@GetMapping("deletecheck.do")
	public void deleteCheck(BoardVO vo, Model model) {
		System.out.println("삭제하는 게시물 번호 : " + vo.getBoardidx());
		model.addAttribute("vo",vo);
	}
	//게시물 삭제하기
 	@PostMapping("boarddelete.do")
 	public String deletpro(BoardVO vo) {
 		service.deletepro(vo);
 		return "redirect:/";
 	}
 	//게시물 삭제하기
 	 @GetMapping("boardsessiondelete.do")
 	 public String deletpro1(BoardVO vo) {
 	 	service.deletepro(vo);
 	 	return "redirect:/";
 	 }
}
