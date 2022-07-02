package com.homework.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.homework.domain.BoardVO;
import com.homework.domain.Criteria;
import com.homework.domain.PageVO;
import com.homework.service.HomeService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@AllArgsConstructor
public class HomeController {
	@Autowired
	HomeService service;
	
	//리스트 페이지 검색 처리
	@GetMapping("/")
	public String home(Criteria cri, Model model) {
		int boardTotal = service.boardCount(cri);
		List<BoardVO> list = service.getListWithPaging(cri);
		model.addAttribute("list",list);
		PageVO vo = new PageVO(cri,boardTotal);
		model.addAttribute("page",vo);
		
		return "/index";
	}
	
	
}
