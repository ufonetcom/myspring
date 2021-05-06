package com.doom.mapper;

import com.doom.domain.BoardVO;

import java.util.List;

public interface BoardMapper {

    //@Select("select * from tbl_board where board_no > 0")
    public List<BoardVO> getList();

    public void insertBoard(BoardVO boardVO);

    public void insertBoardSelectKey(BoardVO boardVO);

    public BoardVO readBoard(Long board_no);

    public int readBoardTotalCount();

    public int deleteBoard(Long board_no);

}
