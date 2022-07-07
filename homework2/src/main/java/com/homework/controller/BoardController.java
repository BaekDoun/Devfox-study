package com.homework.controller;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.homework.domain.BoardVO;
import com.homework.domain.HeartVO;
import com.homework.domain.ReplyVO;
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
	public String getBoardVo(Model model, BoardVO vo,
			@RequestParam int sessionUseridx,
			HttpServletRequest request, HttpServletResponse response){
		System.out.println(vo.getBoardidx());
			
		//cookie를 이용하여 조회수 중복 증가 불가로 만들기
		Cookie[] cookies = request.getCookies();
		//비교를 위한 쿠키
		Cookie viewCookie = null;
		//쿠키가 존재하는 경우
		if(cookies!=null && cookies.length > 0) {
			 for(int x=0; x<cookies.length; x++) {
		            //Cookie의 name이 cookie+co.getboardidx() 와 일치하는 쿠키를 viewCookie에 넣어준다
		            if(cookies[x].getName().equals("cookie"+vo.getBoardidx())) {
		               System.out.println("쿠키있음");
		               viewCookie = cookies[x];
		            }
		      }
		}
		if(vo != null) {
			if(viewCookie == null) {
				//view Cookie가 null일 경우 쿠키를 생성해서 조회수 증가처리
				service.updateViewCnt(vo);
				//쿠키생성(이름, 값)
				Cookie newCookie = new Cookie("cookie"+vo.getBoardidx(),"|" +vo.getBoardidx() +"|");
				//쿠키추가
				newCookie.setMaxAge(60*5);
				response.addCookie(newCookie);
			}
		}
		//쿠키 끝
		
		//좋아요 시작
		if(sessionUseridx != 0) {
			//useridx와 boardidx를 통해 로그인한 유저가 좋아요를 눌렀는지 체크
			HeartVO hvo = new HeartVO();
			hvo.setBoardidx(vo.getBoardidx());
			hvo.setUseridx(sessionUseridx);
			
			int heartLike = service.getHeartLike(hvo);
			System.out.println("heartLike test: " + heartLike );
			
			//게시물에 하트를 누른유저
			String heartSwich = "no";
			int user_idx = sessionUseridx;
			if(heartLike == 1) {
				heartSwich = "yes";
				model.addAttribute("heartSwich", heartSwich);
			}else {
				model.addAttribute("heartSwich", heartSwich);
			}
		}else if(sessionUseridx == 0){
			Cookie heartCookie = null;
			//비회원인 경우 쿠키를 이용하여 좋아요 판단
			if(cookies!=null && cookies.length > 0) {
				 for(int x=0; x<cookies.length; x++) {
			            //Cookie의 name이 cookie+co.getboardidx() 와 일치하는 쿠키를 viewCookie에 넣어준다
			            if(cookies[x].getName().equals("heartCookie"+vo.getBoardidx())) {
			               System.out.println("하트쿠키있음");
			               heartCookie = cookies[x];
			               String heartcookie = "heartCookie"+vo.getBoardidx();
			               model.addAttribute("heartcookie", heartcookie);
			            }
			      }
			}

			String heartSwich = "no";
			if(heartCookie == null) {
				/* 나중에 좋아요 누르면 추가할 쿠키
				Cookie newHeartCookie = new Cookie("heartCookie"+vo.getBoardidx(),"|heart" +vo.getBoardidx() +"|");
				//쿠키추가
				newHeartCookie.setMaxAge(60*72);
				response.addCookie(newHeartCookie);
				*/
				model.addAttribute("heartSwich", heartSwich);
			}else {
				heartSwich = "yes";
				model.addAttribute("heartSwich", heartSwich);
			}
			
		}
		 
		BoardVO realvo = service.getBoardVo(vo);
		System.out.println("vo가져오기 끝남");
		List<ReplyVO> list = service.getBoardReply(vo.getBoardidx());
		int replycnt = service.cntreply(vo.getBoardidx());
		model.addAttribute("vo",realvo);
		model.addAttribute("cnt",replycnt);
		model.addAttribute("replylist",list);
		
		//쿠키를 설정하면 return type void로 하면 에러가 난다. String으로 return을 다시한번 뷰페이지로 보내준다.07/05
		//해결하는데 시간이 오래걸렸으므로 기억하고 다음에 실수 하지 않도록 하자.
		return "/board/boardview";
	}
	//유저 좋아요 업데이트 인설트
	@PostMapping("heartup.do")
	public @ResponseBody int heartup(HeartVO vo) {
		System.out.println("유저idx : " + vo.getUseridx());
		System.out.println("게시판idx : " + vo.getBoardidx());
		service.upHeart(vo);
		service.updateHeartCnt(vo);
		int flag = 1;
		return flag;
	}
	//유저 좋아요 다운 업데이트 딜리트
	@PostMapping("heartdown.do")
	public @ResponseBody int heartdown(HeartVO vo) {
		System.out.println("유저idx : " + vo.getUseridx());
		System.out.println("게시판idx : " + vo.getBoardidx());
		service.downHeart(vo);
		service.updatedownHeartCnt(vo);
		int flag = 1;
		return flag;
	}
	//업데이트 후 likecnt 받아오기
	@PostMapping("getheartcnt.do")
	public @ResponseBody int getheartcnt(BoardVO vo) {
		System.out.println("likecnt 받기 boardidx : " + vo.getBoardidx());
		BoardVO bvo = service.getHeartCnt(vo.getBoardidx());
		System.out.println("likecnt : " + bvo.getLikecnt());
		return bvo.getLikecnt();
	}
	//비회원 좋아요 닉네임 패스원드 입력창으로 이동
	@GetMapping("likeinsertcheck.do")
	public void likeinsertcheck(BoardVO vo, Model model) {
		model.addAttribute("vo", vo);
	}
	
	//비회원 좋아요 추가
	@PostMapping("heartinsert.do")
	public String heartinsert(HeartVO vo, @RequestParam int boardidx,
			HttpServletRequest request, HttpServletResponse response) {
		System.out.println("boardidx 비회원 좋아요 추가 : " + boardidx);
		Cookie newHeartCookie = new Cookie("heartCookie"+vo.getBoardidx(),"|heart" +vo.getBoardidx() +"|");
		//쿠키추가
		newHeartCookie.setMaxAge(60*72);
		response.addCookie(newHeartCookie);
		//데이터베이스에 저장할 쿠키 String으로 저장
		String cookie1 = "heartCookie"+vo.getBoardidx();
		vo.setHeartcookie(cookie1);
		
		service.anoyheartinsert(vo);
		service.updateHeartCnt(vo);
		
		return "redirect:/board/boardview.do?boardidx="+boardidx+"&sessionUseridx=0";
	}
	//비회원 좋아요 취소 닉네임 패스원드 입력창으로 이동
	@GetMapping("likedeletepasswordcheck.do")
	public void likedeletecheck(BoardVO vo, Model model,
			@RequestParam String heartcookie) {
		System.out.println(vo);
		System.out.println(heartcookie);
		model.addAttribute("vo", vo);
		model.addAttribute("heartcookie", heartcookie);
	}
	//쿠키와 닉네임 비밀번호 체크
	@PostMapping("heartpasscheck.do")
	public @ResponseBody int likeDeletePasswordCheck(HeartVO vo) {
		int check = service.likeDeletePasswordCheck(vo);
		System.out.println(check);
		return check;
	}
	//비회원 좋아요 삭제 쿠키 삭제
	@PostMapping("heartdeletepro.do")
	public String heartdeletepro(HeartVO vo,
			HttpServletRequest request, HttpServletResponse response) {
		service.heartdeletepro(vo);
		service.updatedownHeartCnt(vo);
		//좋아요 쿠키 제거
		//모든 쿠키 불러오고
		Cookie[] cookies = request.getCookies();
		Cookie heartCookie = null;
		//비회원인 경우 쿠키를 이용하여 좋아요 판단
		if(cookies!=null && cookies.length > 0) {
			 for(int x=0; x<cookies.length; x++) {
		            //Cookie의 name이 cookie+co.getboardidx() 와 일치하는 쿠키를 viewCookie에 넣어준다
		            if(cookies[x].getName().equals("heartCookie"+vo.getBoardidx())) {
		               System.out.println("하트쿠키있음");
		               heartCookie = cookies[x];
		               //쿠키의 유효기간을 0으로 설정하고 제거한다.
		               heartCookie.setMaxAge(0);
		               response.addCookie(heartCookie);
		            }
		      }
		}
		
		return "redirect:/board/boardview.do?boardidx="+vo.getBoardidx()+"&sessionUseridx=0";
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
 	
 	//댓글 등록하기
 	@PostMapping("boardreplypro.do")
 	public String replyinsert(ReplyVO vo) {
 
 		if(vo.getReplypassword() != null) {
			System.out.println("비회원이 등록하여 비밀번호를 암호화 하여 등록합니다.");
			String securityPassword = UserSHA256.getSHA256(vo.getReplypassword());
			vo.setReplypassword(securityPassword);
			if(vo.getParent()==0) {
				service.insertReply(vo);								
			}else {
				//대댓글
				service.insertReply1(vo);
			}
			return "redirect:/board/boardview.do?boardidx="+vo.getBoardidx()+"&sessionUseridx=0";
		}else {
			System.out.println("회원이 등록한 댓글이므로 비밀번호는 필요없습니다.");
			if(vo.getParent()==0) {
				service.logininsertReply(vo);				
			}else {
				//대댓글
				service.logininsertReply1(vo);
			}
			return "redirect:/board/boardview.do?boardidx="+vo.getBoardidx()+"&sessionUseridx="+vo.getUseridx();
		}
 		
 	}
 	
 	@GetMapping("replysessiondelete.do")
 	public String replydelete1(ReplyVO vo) {
 		System.out.println("replyidx : " + vo.getReplyidx());
 		System.out.println("boardidx : " + vo.getBoardidx());
 		service.replydeletepro(vo);
 		
 		return "redirect:/board/boardview.do?boardidx="+vo.getBoardidx()+"&sessionUseridx=0";
 	}
 	
	//댓글 삭제하기 비번 체크 새로 열기 07/03
	@GetMapping("replydeletecheck.do")
	public void replydeleteCheck(ReplyVO vo, Model model) {
		System.out.println("삭제하는 댓글 번호 : " + vo.getReplyidx());
		model.addAttribute("vo",vo);
	}
	
	//비회원 댓글 비번 체크 07/03
	@PostMapping("replypasswordcheck.do")
	public @ResponseBody int checkDeletePassword(ReplyVO vo) {
		System.out.println(vo.getBoardidx());
		System.out.println(vo.getReplypassword());
		
		ReplyVO checkvo = service.getReplyVO(vo);
		//전송받은 비밀번호 암호화 
		String securityPassword = UserSHA256.getSHA256(vo.getReplypassword());
		if(checkvo.getReplypassword().equals(securityPassword)) {
			return 1;
		}else {
			return 0;			
		}
	}
 	 
}
