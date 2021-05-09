package com.doom.service;

import com.doom.domain.BoardVO;
import com.doom.mapper.BoardMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collections;
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

        int resultDeleteCnt = getSuccessCntFromDeleteYN(board_no);

        return (resultDeleteCnt==1) ? true : false;
    }

    private int getSuccessCntFromDeleteYN(Long board_no) {
        int successCnt = 0;
        BoardVO boardVO = boardMapper.readBoard(board_no);

        if (boardVO != null && boardVO.getDelete_yn().equals("N")) {
            successCnt = boardMapper.deleteBoard(board_no);
        }
        return successCnt;
    }

    @Override
    public List<BoardVO> getList() {

        log.info("getList.........");

        List<BoardVO> boardList = getBoardList();

        return boardList;
    }

    private List<BoardVO> getBoardList() {
        List<BoardVO> boardList = Collections.emptyList(); //예상치못한 NPE를 방지하기 위해 비어있는 list를 선언

        int boardTotalCountNotDelete = boardMapper.readBoardTotalCount(); //delete_yn값이 'N'인 게시글의 갯수

        if (boardTotalCountNotDelete > 0) {
            boardList = boardMapper.getList(); //삭제되지 않은 개시글 갯수가 존재하면 호출한다.
        }
        return boardList;
    }
}
