package com.doom.service;

import com.doom.common.Criteria;
import com.doom.domain.BoardVO;

import java.util.List;


public interface BoardService {

    public void register(BoardVO boardVO);

    public BoardVO getDetailByBoardNo(Long board_no);

    public boolean modify(BoardVO boardVO);

    public boolean remove(Long board_no);

    public List<BoardVO> getList(Criteria criteria);



}
