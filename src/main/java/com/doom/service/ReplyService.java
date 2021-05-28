package com.doom.service;

import com.doom.domain.ReplyVO;

import java.util.List;

public interface ReplyService {
    public boolean register(ReplyVO replyVO);

    public boolean remove(Long reply_no);

    public List<ReplyVO> getReplyList(ReplyVO replyVO);



}
