package com.doom.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AttachVO extends CommonVO{

    /** 파일번호 (PK)*/
    private Long file_no;

    /** 게시글 번호(FK)*/
    private Long board_no;

    /** 원본 파일 이름*/
    private String original_name;

    /** 저장 파일 이름*/
    private String save_name;

    /** 파일 크기*/
    private long size;
}
