package com.doom.mapper;

import com.doom.domain.BoardVO;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Component;

import java.util.List;

public interface BoardMapper {

    @Select("select * from tbl_board where board_no > 0")
    public List<BoardVO> getList();
}
