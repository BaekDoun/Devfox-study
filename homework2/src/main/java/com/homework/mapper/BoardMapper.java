package com.homework.mapper;

import com.homework.domain.BoardVO;

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
}
