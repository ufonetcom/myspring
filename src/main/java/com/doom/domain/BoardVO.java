package com.doom.domain;

import lombok.Data;

import java.time.LocalDateTime;
import java.util.Date;

@Data
public class BoardVO {

    private Long board_no;
    private String title;
    private String content;
    private String writer;
    private Date regdate;
    private LocalDateTime updatedate;
    private LocalDateTime deletedate;
    private int viewcnt;
    private String delete_yn;
}
