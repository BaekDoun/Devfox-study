package com.homework.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.homework.domain.BoardVO;
import com.homework.domain.ReplyVO;
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
	@Override
	public void insertReply(ReplyVO vo) {
		mapper.insertReply(vo);
	}
	@Override
	public void logininsertReply(ReplyVO vo) {
		mapper.logininsertReply(vo);
	}
	@Override
	public List<ReplyVO> getBoardReply(int boardidx) {
		return mapper.getBoardReply(boardidx);
	}
	@Override
	public void replydeletepro(ReplyVO vo) {
		mapper.replydeletepro(vo);	
	}
	@Override
	public int cntreply(int boardidx) {
		return mapper.cntreply(boardidx);
	}
	@Override
	public ReplyVO getReplyVO(ReplyVO vo) {
		return mapper.getReplyVO(vo);
	}
	@Override
	public void updateViewCnt(BoardVO vo) {
		mapper.updateViewCnt(vo);
	}
}
