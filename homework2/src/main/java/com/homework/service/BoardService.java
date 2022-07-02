package com.homework.service;

import com.homework.domain.BoardVO;

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
}
