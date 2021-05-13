package com.doom.domain;

import lombok.Data;

import java.time.LocalDateTime;
import java.util.Date;

@Data
public class BoardVO {

    /** 글 번호(PK)*/
    private Long board_no;

    /** 글 제목*/
    private String title;

    /** 글 내용*/
    private String content;

    /** 글 작성자*/
    private String writer;

    /** 등록 날짜와 시간*/
    private Date regdate;

    /** 수정 날짜와 시간*/
    private Date updatedate;

    /** 삭제 날짜와 시간*/
    private Date deletedate;

    /** 글 조회수*/
    private int viewcnt;

    /** 삭제여부(default = 'N')*/
    private String delete_yn;

    /** 공지여부(default = 'N')*/
    private String notice_yn;

    /** 비밀글 여부(default = 'N')*/
    private String secret_yn;

    //날짜 포멧팅 변수에 대해서 궁금핸던점
    //mysql date type : datetime
    //spring 에서는 date type : Date(java.util.Date) , LocalDateTime, String 이 세가지가 있다.

    //Date(java.util.Date)를 사용할 경우에는 log4jdbc에서 사용하는 콘솔창 로그화면에 yyyy-mm-dd hh-mm-ss 형태로 잘 나오며 jsp부분에서도 format을 사용하면 제대로 나온다.
    //다만 jsp에서 format을 사용하지 않으면 yyyy-mm-dd T hh-mm-ss처럼 사이에 T(Time)이라는 문구가 같이 나오게 되며 이는 분리를 시켜주는 용도로 나오게된다.

    //Date(java.sql.Date)를 사용할 경우 jsp format을 사용하지 않으면 yyyy-mm-dd형식으로만 나오며(시,분,초가 안나옴) jsp format을 사용했을 경우는 시간 부분이 12:00:00으로
    //이상한 값이 나오게된다. (java.sql.Date와 jsp format에 대해서 더 알아봐야 할것!) 또한 log4jdbc 부분은 yyyy-mm-dd의 형식으로만 나오게 된다.

    //LocalDateTime을 사용했을경우 jsp format을 사용하지 않는다면 yyyy-mm-dd T hh-mm-ss형식으로 나오게 된다. 하지만 format을 사용할 경우 사용자화면에
    //날짜형식 시간형식이 아이에 나오지 않는다.. format이 잘 먹지 않는 문제가 있나보다. 또한 log4jdbc 에서도 unread로 값을 읽어 오지 못하는 부분이있다
    //그래서 대부분 LocalDateTime은 Mybatis가 아닌 jpa에서 활용도가 더 높은것 같다. jpa에서 자동으로 포맷을 해준다.

    //String을 사용했을 경우 jsp format과 상관없이 yyyy-mm-dd hh-mm-ss형식으로 잘 나오게 되며 log4jdbc값도 똑같이 잘 나오게된다.
    //db에서 datetime형식으로 날라오는 값을 그대로 String으로 받아 사용하기 때문이다. (애초에 mysql datetime type은 문자형! timestamp값은 정수형!)

    //본인은 사용자 view에서 T값이 들어가지 않는 yyyy-MM-dd hh-mm-ss형식을 원하므로 Date(java.util.Date)값을 사용할 것이다. 또한 log4jdbc값도 그대로 잘 들어간다..
    //설명을 읽어보면 String 타입도 사용 가능하지만 추 후에 자바에서 지원하는 Date기능에 대해서 다양하게 조작하기 위해서는 String타입 보다 Date타입이 유리하기 때문에 Date를 사용할 것이다.
    // 다만 Date(java.util.Date)타입은 jsp format을 사용하지 않게되면 GMT일시를 포함해서 포맷되기 때문에
    //Thu May 06 01:42:48 KST 2021 이러한 값이 나오게 된다!! 사용하기전에 기호에 맞게 사용하자! Date(java.util.Date는 jsp formatDate 사용하기!!

    //but,, 오늘 작성된 게시글은 시간만 나오고 오늘작성되지 않은 글은 날짜만 나오게 하고싶어 regdate(등록일)컬럼 타입을 String으로 바꿨다.
    //db에서 datetime값을 받아 쿼리에서 알맞은 형식으로 조건문을 주어 String형태로 뿌린다. 이때 원래 타입이 Date여서 String 형태의 날짜형식을 못받게 돼어 바꿨다.
    //Date타입을 유지하고 이 문제를 풀수 있는 방법을 찾아봐야겠다..
}
