package com.doom.domain;

import lombok.Data;

import java.time.LocalDateTime;
import java.util.Date;

@Data
public class BoardVO extends CommonVO{

    /** 글 번호(PK)*/
    private Long board_no;

    /** 글 제목*/
    private String title;

    /** 글 내용*/
    private String content;

    /** 글 작성자*/
    private String writer;

    /** 글 조회수*/
    private int viewcnt;

    /** 공지여부(default = 'N')*/
    private String notice_yn;

    /** 비밀글 여부(default = 'N')*/
    private String secret_yn;


}
