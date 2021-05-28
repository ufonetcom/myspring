package com.doom.service;

import com.doom.domain.ReplyVO;
import com.doom.mapper.ReplyMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;

@Log4j2
@Service
@AllArgsConstructor
public class ReplyServiceImpl implements ReplyService{

    private ReplyMapper replyMapper;

    @Override
    public boolean register(ReplyVO replyVO) {

        int queryResult = 0;

        queryResult = replyMapper.insertReply(replyVO);

        return (queryResult == 1) ? true : false;
    }

    @Override
    public boolean remove(Long reply_no) {

        int queryResult = 0;
        ReplyVO replyVO = replyMapper.readReply(reply_no);

        if(reply_no != null && "N".equals(replyVO.getDelete_yn())){
            queryResult = replyMapper.deleteReply(reply_no);
        }
        return (queryResult == 1) ? true : false;
    }

    @Override
    public List<ReplyVO> getReplyList(ReplyVO replyVO) {

        List<ReplyVO> replyList = Collections.emptyList();

        int replyTotalCount = replyMapper.readReplyTotalCount(replyVO);
        if (replyTotalCount > 0) {
            replyList = replyMapper.getReplyList(replyVO);
        }

        return replyList;
    }
}
