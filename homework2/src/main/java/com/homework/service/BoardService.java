package com.homework.service;

import java.util.List;

import com.homework.domain.BoardVO;
import com.homework.domain.ReplyVO;

public interface BoardService {
	//글등록하기 비회원
	public void insertBoard(BoardVO vo);
	//글등록하기 회원
	public void loginInsertBoard(BoardVO vo);
	//board VO 정보 가져오기
	public BoardVO getBoardVo(BoardVO vo);
	//board 수정하기
	public void modifyPro(BoardVO vo);
	//board 삭제하기
	public void deletepro(BoardVO vo);
	//reply 등록
	public void insertReply(ReplyVO vo);
	//회원 reply 등록
	public void logininsertReply(ReplyVO vo);
	//댓글 불러오기
	public List<ReplyVO> getBoardReply(int boardidx);
	//댓글 삭제하기
	public void replydeletepro(ReplyVO vo);
	//댓글 개수
	public int cntreply(int boardidx);
	//reply VO 정보 가져오기
	public ReplyVO getReplyVO(ReplyVO vo);
	//조회수 증가
	public void updateViewCnt(BoardVO vo);

}
