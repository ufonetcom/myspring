package com.doom.mapper;

import com.doom.common.Criteria;
import com.doom.domain.BoardVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.doom.config.RootConfig.class})
@Log4j2
public class BoardMapperTests {

    @Setter(onMethod_ = @Autowired)
    private BoardMapper mapper;

    @Test
    public void testGetList() {
        Criteria criteria = new Criteria();
        mapper.getList(criteria).forEach(boardVO -> log.info(boardVO));
    }

    @Test
    public void testInsertBoard() {
        BoardVO boardVO = new BoardVO();
        boardVO.setTitle("mapper test");
        boardVO.setContent("새로 작성하는 글");
        boardVO.setWriter("doompoknew");

        mapper.insertBoard(boardVO);

        log.info(boardVO);
    }

    //insert하려는 board_no(PK)값을 mapper.xml에 selectkey 쿼리에 boardvo객체로 바인딩 된다.
    //insert문이 실행되고 나서 추가된 해당 키값을 boardvo객체에 매핑해준다.
    @Test
    public void testInsertBoardSelectKey() {
        BoardVO boardVO = new BoardVO();
        boardVO.setTitle("mapper test sk");
        boardVO.setContent("새로 작성하는 글 sk");
        boardVO.setWriter("selectkey board insert");

        mapper.insertBoardSelectKey(boardVO);

        log.info(boardVO);
    }

    @Test
    public void testReadBoard() {
        //board테이블에서의 board_no값으로 테스트 한다.
        BoardVO boardVO = mapper.readBoard(21L);

        log.info(boardVO);
    }

    @Test
    public void testReadBoardTotalCount() {
        Criteria criteria = new Criteria();
        int count = mapper.readBoardTotalCount(criteria);
        log.info("삭제되지 않은 게시글의 총 갯수 = {}",count);
    }

    @Test
    public void testDeleteBoard() {
        log.info("Delete =>>>> {}", mapper.deleteBoard(21L));
        log.info(mapper.readBoard(21L));
    }



    @Test
    public void testUpdateBoard() {
        BoardVO boardVO = new BoardVO();
        boardVO.setBoard_no(20L);
        boardVO.setTitle("업데이트 테스트");
        boardVO.setContent("업데이트 테스트 내용");
        boardVO.setWriter("doomupdate");

        int count = mapper.updateBoard(boardVO);
        log.info("Update Count : {}",count);
    }


}