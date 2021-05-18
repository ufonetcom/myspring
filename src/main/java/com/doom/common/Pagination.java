package com.doom.common;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Pagination {

    /** 페이징 계산에 필요한 파라미터들이 담긴 클래스 */
    private Criteria criteria;

    /** 전체 데이터 개수 */
    private int totalRecordCount;

    /** 전체 페이지 개수 (endPage)*/
    private int totalPageCount;

    /** 페이지 리스트의 첫 페이지 번호 */
    private int firstPage;

    /** 페이지 리스트의 마지막 페이지 번호 */
    private int lastPage;

    /** SQL의 조건절에 사용되는 첫 RNUM */
    private int firstRecordIndex;

    /** SQL의 조건절에 사용되는 마지막 RNUM */
    private int lastRecordIndex;

    /** 이전 페이지 존재 여부 */
    private boolean hasPreviousPage;

    /** 다음 페이지 존재 여부 */
    private boolean hasNextPage;

    public Pagination(Criteria criteria) {
        if (criteria.getCurrentPageNo() < 1) {
            criteria.setCurrentPageNo(1);
        }
        if (criteria.getRecordsPerPage() < 1 || criteria.getRecordsPerPage() > 100) {
            criteria.setRecordsPerPage(10);
        }
        if (criteria.getPageSize() < 5 || criteria.getPageSize() > 20) {
            criteria.setRecordsPerPage(10);
        }
        this.criteria = criteria;
    }

    public void setTotalRecordCount(int totalRecordCount) {
        this.totalRecordCount = totalRecordCount;
        if (totalRecordCount > 0) {
            caculation();
        }
    }

    private void caculation() {
        /** 전체 페이지 수 = 만약 83개의 게시글 수가 있고 10개씩 게시글을 보여준다 한다. 그럼 83/10 = 8.3에 올림(math.ceil)이 되면 9가 되고 이것이 전체 페이지 수(끝페이지 수) 가된다.
         * 현재 페이지 번호가 전체 페이지 수(진짜 전체 페이지 수)보다 크면 현재 페이지에 전체 페이지 수를 집어넣는다.*/
        totalPageCount = (int)(Math.ceil((totalRecordCount*1.0) / criteria.getRecordsPerPage()));
        if (criteria.getCurrentPageNo() > totalPageCount) {
            criteria.setCurrentPageNo(totalPageCount);
        }

        /** 페이지 리스트에 첫 페이지 번호*/
        firstPage = ((criteria.getCurrentPageNo()-1) / criteria.getPageSize()) * criteria.getPageSize() + 1;
        /** 페이지 리스트에 마지막 페이지 번호 (마지막 페이지 번호가 전체 페이지 수(진짜 전체 페이지)보다 크면 마지막 페이지 번호가 전체 페이지 번호가 된다.
         *  만약 전체 페이지 개수는 35, 현재 페이지 번호는 33, 마지막 페이지 번호가 40이면 36~40페이지는 출력되면 안되므로 마지막페이지 번호는 35가 되야한다.*/
        lastPage = firstPage + criteria.getPageSize() - 1;
        if (lastPage > totalPageCount) {
            lastPage = totalPageCount;
        }

        /** SQL의 조건절에 사용되는 첫번째 RNUM(sql구문에 limit a, b 에 a값에 사용)*/
        firstRecordIndex = (criteria.getCurrentPageNo() - 1) * criteria.getRecordsPerPage();

        /* SQL의 조건절에 사용되는 마지막 RNUM */
        lastRecordIndex = criteria.getCurrentPageNo() * criteria.getRecordsPerPage();

        /** 이전 페이지 존재 여부 (첫 페이지 번호가 1이 아니면 존재한다)*/
        hasPreviousPage = (firstPage != 1);

        /** 다음 페이지 존재 여부 */
        hasNextPage = (lastPage * criteria.getRecordsPerPage()) < totalRecordCount;


    }
}
