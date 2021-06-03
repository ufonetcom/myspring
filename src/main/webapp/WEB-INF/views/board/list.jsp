<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="../includes/header.jsp"%>
    <!-- Begin Page Content -->
    <div class="container-fluid">

        <!-- Page Heading -->
        <h1 class="h3 mb-2 text-gray-800">Board</h1>

        <!-- DataTales Example -->
        <div class="card shadow mb-4" >
            <div class="card-header py-3" style="display: flex; justify-content: space-between">
                <div class="input-group" style="width: 490px">
                <h6 style="padding-top: 10px;" class=" font-weight-bold text-primary">Board List Page</h6>
                </div>
                <div class="input-group" id="adv-search">
                    <input style="width: 400px" type="search" id="mainSearchKeyword" class="form-control" value="${board.searchKeyword}" placeholder="키워드를 입력해주세요.">
                    <div class="input-group-btn">
                        <div class="btn-group" role="group">
                            <div class="dropdown dropdown-lg">
                                <button style="background-color:#ccd1f1 " type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><span class="caret"></span></button>
                                <div class="dropdown-menu dropdown-menu-right" role="menu">
                                    <!--/* 검색 form */-->
                                    <form id="searchForm" action="/board/list" method="get" class="form-horizontal" role="form">
                                        <!-- /* 현재 페이지 번호, 페이지당 출력할 데이터 개수, 페이지 하단에 출력할 페이지 개수 Hidden 파라미터 */ -->
                                        <input type="hidden" name="currentPageNo" value="1" />
                                        <input type="hidden" name="recordsPerPage" value="${board.recordsPerPage}" />
                                        <input type="hidden" name="pageSize" value="${board.pageSize}" />

                                        <div class="form-group">
                                            <label>검색 유형</label>
                                            <select name="searchType" class="form-control">
                                                <option value="TCW"<c:out value="${board.searchType eq 'TCW' ? 'selected':''}"/>>전체</option>
                                                <option value="T"<c:out value="${board.searchType eq 'T' ? 'selected':''}"/>>제목</option>
                                                <option value="C"<c:out value="${board.searchType eq 'C' ? 'selected':''}"/>>내용</option>
                                                <option value="W"<c:out value="${board.searchType eq 'W' ? 'selected':''}"/>>작성자</option>
                                            </select>
                                        </div>
                                        <div style="width: 500px" class="form-group">
                                            <label>키워드</label>
                                            <input type="search" name="searchKeyword" class="form-control" id="dropSearchInput" value="${board.searchKeyword}" placeholder="키워드를 입력해주세요."/>
                                        </div>
                                        <button style="background-color: #1c294e" type="button" class="btn btn-primary" id="dropSearchButton"><span class="fas fa-search fa-sm" aria-hidden="true"></span></button>
                                    </form>
                                </div>
                            </div>
                            <button style="width: 40px; border-color: #1c294e; background-color: #1c294e" type="button" class="btn btn-primary" id="mainSearchButton"><span class="fas fa-search fa-sm" aria-hidden="true"></span></button>
                        </div>
                    </div>
                </div>
                <div>
                    <button  id='regBtn' type="button" class="btn btn-outline-info pull-right">Register</button>
                </div>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered" width="100%" cellspacing="0">
                        <thead>
                        <tr>
                            <th>말머리</th>
                            <th style="text-align: center">제목</th>
                            <th>작성자</th>
                            <th style="text-align: center">작성일</th>
                            <th style="text-align: center">조회</th>
                        </tr>
                        </thead>
                        <c:set var="today" value="<%=new java.util.Date()%>"/>
                        <c:set var="date"><fmt:formatDate value="${today}" pattern="yyyy-MM-dd"/></c:set>

                        <c:forEach items="${boardList}" var="list">
                            <c:set var="regtoday"><fmt:formatDate value="${list.regdate}" pattern="yyyy-MM-dd"/></c:set>
                            <tr>
                                <c:if test="${list.notice_yn eq 'Y'}">
                                    <td style="color: #be2617; width: 90px;"><c:out value="공지글"/></td>
                                </c:if>
                                <c:if test="${list.notice_yn eq 'N'}">
                                    <td><c:out value="${list.board_no}"/></td>
                                </c:if>
                                <td>
                                    <a href="/board/getDetail${board.makeQueryString(board.currentPageNo)}&board_no=${list.board_no}"><c:out value="${list.title}"/>
                                        <c:if test="${list.replycnt > 0}">
                                            <span style="color: #2d2e33; font-size: small">[<c:out value="${list.replycnt}"/>]</span>
                                        </c:if>
                                    </a>
                                </td>
                                <td style="width: 170px;"><c:out value="${list.writer}"/></td>
                                <c:choose>
                                    <c:when test="${date eq regtoday}">
                                        <td style="text-align: center"><fmt:formatDate value="${list.regdate}" pattern="HH:mm"/></td>
                                    </c:when>
                                    <c:otherwise>
                                        <td style="width: 140px; text-align: center"><c:out value="${regtoday}"/></td>
                                    </c:otherwise>
                                </c:choose>
                                <td style="width: 80px; text-align: center"><c:out value="${list.viewcnt}"/></td>
                            </tr>
                        </c:forEach>
                    </table>

                    <!-- Paging[s] -->
                    <div class="col-sm-12 col-md-7" style="margin: 0 auto; width: 500px;" >
                        <div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate">
                            <ul class="pagination">
                                <c:if test="${board.pagination.hasPreviousPage}">
                                    <li class="paginate_button page-item previous" id="dataTable_previous">
                                        <a href="/board/list${board.makeQueryString(1)}"
                                           aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">&laquo;</a>
                                    </li>
                                </c:if>

                                <c:if test="${board.pagination.hasPreviousPage}">
                                    <li class="paginate_button page-item previous" id="dataTable_previous">
                                        <a href="/board/list${board.makeQueryString(board.pagination.firstPage-1)}"
                                           aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">&lsaquo;</a>
                                    </li>
                                </c:if>

                                <c:forEach var="num" begin="${board.pagination.firstPage}" end="${board.pagination.lastPage}">
                                    <li class="paginate_button page-item ${board.currentPageNo == num ? 'active' : ''}">
                                        <a href="/board/list${board.makeQueryString(num)}"
                                           aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">${num}</a>
                                    </li>
                                </c:forEach>

                                <c:if test="${board.pagination.hasNextPage}">
                                    <li class="paginate_button page-item next" id="dataTable_next">
                                        <a href="/board/list${board.makeQueryString(board.pagination.lastPage+1)}"
                                           aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">&rsaquo;</a>
                                    </li>
                                </c:if>
                                <c:if test="${board.pagination.hasNextPage}">
                                    <li class="paginate_button page-item previous" id="dataTable_previous">
                                        <a href="/board/list${board.makeQueryString(board.pagination.totalPageCount)}"
                                           aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">&raquo;</a>
                                    </li>
                                </c:if>
                            </ul>
                        </div>
                    </div>
                    <!-- Paging[e] -->

                    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
                         aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="myModalLabel">Modal title</h5>
                                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">×</span>
                                    </button>
                                </div>
                                <div class="modal-body">처리가 완료되었습니다.</div>
                                <div class="modal-footer">
                                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                                    <%--<button class="btn btn-primary" type="button">Save changes</button>--%>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- /.container-fluid -->
    <script type="text/javascript">

        $(document).ready(function () {
            let result = '<c:out value="${result}"/>';
            console.log(result);

            checkModal(result);

            history.replaceState({},null,null);

            function checkModal(result) {
                if (result === '' || history.state) {
                    return;
                }

                if(parseInt(result) > 0) {
                    $(".modal-body").html("게시글 " + parseInt(result) + " 번이 등록되었습니다.");
                }else if(result === "modify-success"){
                    $(".modal-body").html("게시글이 수정되었습니다.");
                }else if(result === "delete-success"){
                    $(".modal-body").html("게시글이 삭제되었습니다.");
                }
                $("#myModal").modal("show");
            }


            let dropSearchKeyword = $("#searchForm");

            /** 드롭다운이 아닌 메인검색 키워드로 검색했을 때*/
            $("#mainSearchButton").on("click", function (){
                let searchKeyword = $("#mainSearchKeyword");
                console.log(searchKeyword.val());

                if(searchKeyword.val() === ''){
                    alert("키워드를 입력해주세요.");
                    searchKeyword.focus();
                    return false;
                }
                dropSearchKeyword.find("input[name='searchKeyword']").val(searchKeyword.val());
                dropSearchKeyword.submit();
            });

            /** 드롭다운으로 검색 했을 때*/
            $("#dropSearchButton").on("click", function (e){
                console.log(dropSearchKeyword.find("input[name='searchKeyword']").val());
                if(!dropSearchKeyword.find("input[name='searchKeyword']").val()){
                    alert("키워드를 입력해주세요.");
                    $("#dropSearchInput").focus();
                    return false;
                }
                // e.preventDefault();
                dropSearchKeyword.submit();
            });

            /** 드롭다운이 아닌 메인검색 enter키로 검색*/
            $("#mainSearchKeyword").keydown(function (key){
                if (key.keyCode == 13) {
                    $("#mainSearchButton").click();
                }
            })
            $("#dropSearchInput").keydown(function (key){
                if (key.keyCode == 13) {
                    $("#dropSearchButton").click();
                }
            })


            $("#regBtn").on("click", function (){
                self.location = "/board/register";
            });
        });
    </script>

<%@include file="../includes/footer.jsp"%>
