package com.doom.mapper;

import com.doom.domain.AttachVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface AttachMapper {

    public int insertAttach(List<AttachVO> attachVOList);

    public AttachVO selectAttachDetail(Long file_no);

    public int deleteAttach(Long board_no);

    public List<AttachVO> selectAttachList(Long board_no);

    public int selectAttachTotalCount(Long board_no);
}
