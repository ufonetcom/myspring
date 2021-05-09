package com.doom.service;

import com.doom.domain.BoardVO;
import com.doom.mapper.BoardMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Log4j2
@Service
@AllArgsConstructor //모든인자로 만들어진 생성자 (생성자 주입 방식에 쓰인다.) 생성자 필드가 하나일 경우 @AutoWired생략 가능
public class BoardServiceImpl implements BoardService{

    private BoardMapper boardMapper;

    @Override
    public void register(BoardVO boardVO) {
        log.info("register......{}",boardVO);

        boardMapper.insertBoardSelectKey(boardVO);
    }

    @Override
    public BoardVO getDetailByBoardNo(Long board_no) {

        log.info("getDetailByBoardNO......");

        BoardVO boardVO = boardMapper.readBoard(board_no);
        return boardVO;
    }

    @Override
    public boolean modify(BoardVO boardVO) {

        log.info("modify........{}",boardVO);
        int successCnt = boardMapper.updateBoard(boardVO);

        if(successCnt==1) {
            return true;
        }
        return false;
    }

    @Override
    public boolean remove(Long board_no) {

        log.info("remove......> board_no : {}",board_no);

        int successCnt = boardMapper.deleteBoard(board_no);
        if (successCnt == 1) {
            return true;
        }
        return false;
    }

    @Override
    public List<BoardVO> getList() {

        log.info("getList.........");
        List<BoardVO> boardList = boardMapper.getList();
        return boardList;
    }
}
