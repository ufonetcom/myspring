package com.doom.mapper;

import com.doom.common.Criteria;
import com.doom.domain.BoardVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface BoardMapper {

    //@Select("select * from tbl_board where board_no > 0")
    public List<BoardVO> getList(BoardVO boardVO);

    public void insertBoard(BoardVO boardVO);

    public void insertBoardSelectKey(BoardVO boardVO);

    public BoardVO readBoard(Long board_no);

    public int readBoardTotalCount(BoardVO boardVO);

    public int deleteBoard(Long board_no);

    public int updateBoard(BoardVO boardVO);

    public void updateViewCnt(Long board_no);

    public void updateReplyCnt(@Param("board_no") Long board_no, @Param("amount") int amount);


}
