package com.doom.service;

import com.doom.domain.ReplyVO;
import com.doom.mapper.BoardMapper;
import com.doom.mapper.ReplyMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collections;
import java.util.List;

@Log4j2
@Service
public class ReplyServiceImpl implements ReplyService{

    private final ReplyMapper replyMapper;
    private final BoardMapper boardMapper;

    @Autowired
    public ReplyServiceImpl(ReplyMapper replyMapper, BoardMapper boardMapper) {
        this.replyMapper = replyMapper;
        this.boardMapper = boardMapper;
    }

    @Transactional
    @Override
    public boolean register(ReplyVO replyVO) {

        int queryResult = 0;

        queryResult = replyMapper.insertReply(replyVO);
        boardMapper.updateReplyCnt(replyVO.getBoard_no(),1);

        return (queryResult == 1) ? true : false;
    }


    @Transactional
    @Override
    public boolean remove(Long reply_no) {

        int queryResult = 0;
        ReplyVO replyVO = replyMapper.readReply(reply_no);

        if(reply_no != null && "N".equals(replyVO.getDelete_yn())){
            queryResult = replyMapper.deleteReply(reply_no);
            boardMapper.updateReplyCnt(replyVO.getBoard_no(),-1);
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
