package com.doom.mapper;

import com.doom.domain.ReplyVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ReplyMapper {

    public int insertReply(ReplyVO replyVO);

    public ReplyVO readReply(Long reply_no);

    public int updateReply(ReplyVO replyVO);

    public int deleteReply(Long reply_no);

    public List<ReplyVO> getReplyList(ReplyVO replyVO);

    public int readReplyTotalCount(ReplyVO replyVO);
}
