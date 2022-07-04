package com.homework.mapper;

import java.util.List;

import com.homework.domain.BoardVO;
import com.homework.domain.ReplyVO;

public interface BoardMapper {
	//글 등록하기 비회원 06/30
	public void insertBoard(BoardVO vo);
	//글 등록하기 비회원 06/30
	public void loginInsertBoard(BoardVO vo);
	//board VO 정보 가져오기
	public BoardVO getBoardVo(BoardVO vo);
	//board 수정하기
	public void modifyPro(BoardVO vo);
	//board 삭제하기
	public void deletepro(BoardVO vo);
	//비회원 reply 등록
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
