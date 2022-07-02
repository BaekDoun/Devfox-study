package com.homework.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.homework.domain.BoardVO;
import com.homework.mapper.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService {
	@Autowired
	BoardMapper mapper;	
	
	@Override
	public void insertBoard(BoardVO vo) {
		mapper.insertBoard(vo);
	}
	@Override
	public void loginInsertBoard(BoardVO vo) {
		mapper.loginInsertBoard(vo);
	}
	@Override
	public BoardVO getBoardVo(BoardVO vo) {
		return mapper.getBoardVo(vo);
	}
	@Override
	public void modifyPro(BoardVO vo) {
		mapper.modifyPro(vo);
	}
	@Override
	public void deletepro(BoardVO vo) {
		mapper.deletepro(vo);
	}
}
