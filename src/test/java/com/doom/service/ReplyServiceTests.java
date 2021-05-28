package com.doom.service;

import com.doom.domain.ReplyVO;
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
public class ReplyServiceTests {

    @Setter(onMethod_ = @Autowired)
    private ReplyService replyService;

    @Test
    public void testRegister() {
        int num = 10;

        for (int i = 1; i < num; i++) {
            ReplyVO replyVO = new ReplyVO();
            replyVO.setBoard_no((long) 386);
            replyVO.setContent(i + "번 댓글을 추가합니다..");
            replyVO.setWriter(i + "번 회원");

            replyService.register(replyVO);
        }

        log.info("댓글 {}개가 등록되었습니다.", num);
    }

    @Test
    public void testDelete() {

    }
}
