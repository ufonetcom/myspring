package com.doom.service;

import com.doom.common.Pagination;
import com.doom.domain.AttachVO;
import com.doom.domain.BoardVO;
import com.doom.mapper.AttachMapper;
import com.doom.mapper.BoardMapper;
import com.doom.util.FileUtils;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import org.springframework.web.multipart.MultipartFile;

import java.util.Collections;
import java.util.List;

//@AllArgsConstructor //모든인자로 만들어진 생성자 (생성자 주입 방식에 쓰인다.) 생성자 필드가 하나일 경우 @AutoWired생략 가능
@Log4j2
@Service
public class BoardServiceImpl implements BoardService{

    private BoardMapper boardMapper;
    private AttachMapper attachMapper;
    private FileUtils fileUtils;

    @Autowired
    public BoardServiceImpl(BoardMapper boardMapper, AttachMapper attachMapper, FileUtils fileUtils) {
        this.boardMapper = boardMapper;
        this.attachMapper = attachMapper;
        this.fileUtils = fileUtils;
    }

    @Override
    public boolean register(BoardVO boardVO) {
        log.info("register......{}",boardVO);

        int queryResult = 0;

        queryResult = boardMapper.insertBoardSelectKey(boardVO);

        return (queryResult == 1) ? true : false;
    }

    @Override
    public boolean register(BoardVO boardVO, MultipartFile[] files) {
        int queryResult = 1;

        if (register(boardVO) == false) {
            return false;
        }
        List<AttachVO> fileList = fileUtils.uploadFiles(files, boardVO.getBoard_no());
        if (CollectionUtils.isEmpty(fileList) == false) {
            queryResult = attachMapper.insertAttach(fileList);
            if (queryResult < 1) {
                queryResult = 0;
            }
        }
        return (queryResult > 0);
    }

    @Override
    public BoardVO getDetailByBoardNo(Long board_no) {

        log.info("getDetailByBoardNO......");

        boardMapper.updateViewCnt(board_no);

        BoardVO boardVO = boardMapper.readBoard(board_no);
        return boardVO;
    }

    @Override
    public boolean modify(BoardVO boardVO, MultipartFile[] files) {

        log.info("modify........{}",boardVO);
        int queryResult = 1;
        int successCnt = boardMapper.updateBoard(boardVO);

        log.info("파일업로드 수정 변화값 >>> {}",boardVO.getChange_yn());

        //파일이 추가,삭제,변경된 경우
        if ("Y".equals(boardVO.getChange_yn())) {
            attachMapper.deleteAttach(boardVO.getBoard_no());

            log.info("파일업로드 수정 fileIdx값 >>> {}",boardVO.getFileIdx_no());

            //fileIdx 리스트에서 변경되지 않은 기존 파일의 change_yn컬럼 값을(y값) 다시 n으로 돌리는 작업(첨부파일삭제 취소 기능)
            if (CollectionUtils.isEmpty(boardVO.getFileIdx_no()) == false) {
                attachMapper.undeleteAttach(boardVO.getFileIdx_no());
            }
            //기존에 존재하는(변경되지않은) 파일을 제외하고 새롭게 변경,추가되는 파일이 거쳐가는 로직
            List<AttachVO> fileList = fileUtils.uploadFiles(files, boardVO.getBoard_no());
            if (CollectionUtils.isEmpty(fileList) == false) {
                queryResult = attachMapper.insertAttach(fileList);
            }
        }
        if(successCnt==1 || queryResult==1) {
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
    public List<BoardVO> getList(BoardVO boardVO) {

        log.info("getList.........");

        List<BoardVO> boardList = getBoardList(boardVO);

        return boardList;
    }

    private List<BoardVO> getBoardList(BoardVO boardVO) {
        List<BoardVO> boardList = Collections.emptyList(); //예상치못한 NPE를 방지하기 위해 비어있는 list를 선언

        int boardTotalCountNotDelete = boardMapper.readBoardTotalCount(boardVO); //delete_yn값이 'N'인 게시글의 갯수

        /** 게시글 전체 개수를 pagination클래스 totalRecordCount변수에 담아 객체를 set해준다.*/
        Pagination pagination = new Pagination(boardVO);
        pagination.setTotalRecordCount(boardTotalCountNotDelete);

        boardVO.setPagination(pagination);

        if (boardTotalCountNotDelete > 0) {
            boardList = boardMapper.getList(boardVO); //삭제되지 않은 개시글 갯수가 존재하면 호출한다.
        }

        return boardList;
    }


    @Override
    public List<AttachVO> getAttachFileList(Long board_no) {
        int fileTotalCount = attachMapper.selectAttachTotalCount(board_no);
        if (fileTotalCount < 1) {
            return Collections.emptyList();
        }
        return attachMapper.selectAttachList(board_no);
    }

    @Override
    public AttachVO getAttachDetail(Long file_no) {
        return attachMapper.selectAttachDetail(file_no);
    }
}
