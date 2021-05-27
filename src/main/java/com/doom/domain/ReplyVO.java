package com.doom.domain;

import lombok.Data;

@Data
public class ReplyVO extends CommonVO{

    private Long reply_no;

    private Long board_no;

    private String content;

    private String writer;

}
