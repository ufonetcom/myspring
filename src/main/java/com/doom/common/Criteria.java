package com.doom.common;

import lombok.Getter;
import lombok.Setter;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

@Getter
@Setter
public class Criteria {

    /** 현재 페이지 번호*/
    private int currentPageNo;

    /** 페이지당 출력할 데이터 갯수*/
    private int recordsPerPage;

    /** 화면 하단에 출력할 페이지 갯수*/
    private int pageSize;

    public Criteria() {
        this.currentPageNo = 1;
        this.recordsPerPage = 10;
        this.pageSize = 10;
    }

    public String makeQueryString(int pageNo) {
        System.out.println("nummmmmmmmm" + pageNo);
        UriComponents uriComponents = UriComponentsBuilder.newInstance()
                .queryParam("currentPageNo", pageNo)
                .queryParam("recordsPerPage", recordsPerPage)
                .queryParam("pageSize",pageSize)
                .build()
                .encode();

        return uriComponents.toUriString();
    }

}