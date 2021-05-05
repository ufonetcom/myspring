package com.doom.domain;

import lombok.Data;

import java.util.Date;

@Data
public class BoardVO {

    private Long board_no;
    private String title;
    private String content;
    private String writer;
    private Date regdate;
    private Date updatedate;
    private Date deletedate;
    private int viewcnt;
    private String delete_yn;
}
