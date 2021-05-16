package com.doom.service;

import com.doom.common.Criteria;
import com.doom.domain.BoardVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.doom.config.RootConfig.class})
@Log4j2
public class BoardServiceTests {

    @Setter(onMethod_ = {@Autowired})
    private BoardService boardService;


    @Test
    public void testExist() {
        log.info(boardService);
        Assert.assertNotNull(boardService);
    }

    @Test
    public void testRegister() {
        BoardVO boardVO = new BoardVO();
        boardVO.setTitle("service, 새로 작성하는 글");
        boardVO.setContent("service, 새로 작성하는 내용");
        boardVO.setWriter("serviced");

        boardService.register(boardVO);

        log.info("생성된 게시물의 번호 : {}", boardVO.getBoard_no());
    }

    @Test
    public void testGetList() {
        Criteria criteria = new Criteria();
        boardService.getList(criteria).forEach(boardVO -> log.info(boardVO));
    }

    @Test
    public void testGetDetailByBoardNo() {
        log.info(boardService.getDetailByBoardNo(30L));
        BoardVO boardVO = boardService.getDetailByBoardNo(29L);
        log.info("regidate 값 확인 ==========> {}",boardVO.getRegdate());
    }

    @Test
    public void testDelete() {
        //게시물의 삭제여부를 확인하고 테스트
        boolean resultRemove = boardService.remove(25L);
        log.info("Remove Result: {}", resultRemove);
        Assert.assertEquals(true,resultRemove);

    }

    @Test
    public void testUpdate() {

        BoardVO boardVO = boardService.getDetailByBoardNo(1L);

        if (boardVO == null) {
            return;
        }

        boardVO.setTitle("제목을 수정합니다. serviceTest");
        log.info("Modify Result: {}", boardService.modify(boardVO));
    }
}
