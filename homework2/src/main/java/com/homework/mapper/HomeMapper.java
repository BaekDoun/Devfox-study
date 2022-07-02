package com.homework.mapper;

import java.util.List;

import com.homework.domain.BoardVO;
import com.homework.domain.Criteria;

public interface HomeMapper {
	//총 글 수
	public int boardCount(Criteria cri);
	//리스트 페이지 처리
	public List<BoardVO> getListWithPaging(Criteria cri);
}
