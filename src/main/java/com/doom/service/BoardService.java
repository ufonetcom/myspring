package com.doom.service;

import com.doom.common.Criteria;
import com.doom.domain.AttachVO;
import com.doom.domain.BoardVO;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;


public interface BoardService {

    public boolean register(BoardVO boardVO);

    public boolean register(BoardVO boardVO, MultipartFile[] files);

    public BoardVO getDetailByBoardNo(Long board_no);

    public boolean modify(BoardVO boardVO, MultipartFile[] files);

    public boolean remove(Long board_no);

    public List<BoardVO> getList(BoardVO boardVO);

    public List<AttachVO> getAttachFileList(Long board_no);

    public AttachVO getAttachDetail(Long file_no);



}
