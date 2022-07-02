package com.homework.service;

import java.util.List;

import com.homework.domain.BoardVO;
import com.homework.domain.Criteria;

public interface HomeService {
	//총  글수
	public int boardCount(Criteria cri);
	//리스트 페이지
	public List<BoardVO> getListWithPaging(Criteria cri);
}
