package com.homework.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.homework.domain.BoardVO;
import com.homework.domain.Criteria;
import com.homework.domain.UserVO;
import com.homework.mapper.HomeMapper;

@Service
public class HomeServiceImpl implements HomeService {
	@Autowired
	HomeMapper mapper;
	
	@Override
	public int boardCount(Criteria cri) {
		return mapper.boardCount(cri);
	}
	@Override
	public List<BoardVO> getListWithPaging(Criteria cri) {
		return mapper.getListWithPaging(cri);
	}
}
