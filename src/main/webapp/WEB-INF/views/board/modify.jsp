<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="../includes/header.jsp"%>
<!-- Begin Page Content -->
<div class="container-fluid">

    <!-- Page Heading -->
    <h1 class="h3 mb-2 text-gray-800">Modify</h1>
    <p class="mb-4">게시글 수정</p>

    <!-- DataTales Example -->
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">자유게시판 글 수정</h6>
        </div>
        <div class="card-body">
            <form role="form" action="/board/modify" method="post">
<%--                hidden값에 나머지 recordsPerPage와 pageSize 값은 현재로써는 동적이지 않으므로 view단에서는 crrentPageNo만 넘긴다.--%>
                <input type="hidden" id="currentPageNo" name="currentPageNo" value='<c:out value="${params.currentPageNo}"/>'>
                <input type="hidden" id="searchType" name="searchType" value='<c:out value="${params.searchType}"/>'>
                <input type="hidden" id="searchKeyword" name="searchKeyword" value='<c:out value="${params.searchKeyword}"/>'>
                <div class="form-group">
                    <div class="col-sm-8 mb-5">
                        <label>글 번호</label>
                        <input class="form-control" name="board_no" value='<c:out value="${board.board_no}"/>' readonly="readonly">
                    </div>
                    <div class="col-sm-8 mb-5">
                        <label>작성자</label>
                        <input class="form-control" name="writer" value='<c:out value="${board.writer}"/>' readonly="readonly">
                    </div>
                    <div class="col-sm-8 mb-5">
                        <label>제목</label>
                        <input class="form-control" name="title" value='<c:out value="${board.title}"/>'>
                    </div>
                    <div class="col-sm-8 mb-5">
                        <label>글 내용</label>
                        <textarea class="form-control" name="content" rows="5"><c:out value="${board.content}"/></textarea>
                    </div>
                    <div class="col-sm-8 mb-5">
                        <label>등록 날짜</label>
                        <input class="form-control" name="regdate"
                               value = '<fmt:formatDate pattern="yyyy/MM/dd HH:mm" value="${board.regdate}"/>' readonly="readonly">
                    </div>
                    <%--<div class="col-sm-8 mb-5">
                        <label>수정 날짜</label>
                        <input class="form-control" name="updatedate"
                               value = '<fmt:formatDate pattern="yyyy/MM/dd HH:mm" value="${board.updatedate}"/>' readonly="readonly">
                    </div>--%>

                    <div>
                        <button type="submit" data-oper='modify' class="btn btn-success btn-icon-split">
                            <span class="icon text-white-50">
                                <i class="fas fa-check"></i>
                            </span>
                            <span class="text">글수정</span>
                        </button>
                        <button type="submit" data-oper='remove' class="btn btn-danger btn-icon-split">
                            <span class="icon text-white-50">
                                <i class="fas fa-trash"></i>
                            </span>
                            <span class="text">글삭제</span>
                        </button>
<%--                        목록으로 가기는 바로 밑에 button을 사용해 script로 사용할수도 있지만 a태그를 script없이 사용하는 모습을 보여주기 위해 a태그로 사용--%>
                        <a href="/board/list${params.makeQueryString(params.currentPageNo)}" class="btn btn-info btn-icon-split">
                            <span class="icon text-white-50">
                                <i class="fas fa-arrow-right"></i>
                            </span>
                            <span class="text">목록</span>
                        </a>
                        <%--<button type="submit" data-oper='list' class="btn btn-info btn-icon-split">
                            <span class="icon text-white-50">
                                <i class="fas fa-arrow-right"></i>
                            </span>
                            <span class="text">목록</span>
                        </button>--%>
                    </div>
                </div>

            </form>
        </div>
    </div>

</div>
<!-- /.container-fluid -->
<script type="text/javascript">
    $(document).ready(function () {
        let formObj = $("form");

        $('button').on("click", function(e){
            e.preventDefault(); //form태그의 모든 버튼은 기본적으로 submit으로 처리하기때문에 기본동작을 막고 연산 처리.

            let operation = $(this).data("oper");

            console.log(operation);

            if (operation === 'remove') {
                formObj.attr("action", "/board/remove");
            }else if (operation === 'list') {
                //move to list 현재는 a태그를 사용하여 데이터를 전송하기 때문에 실제로 이 else if list는 호출되지 않는다.
                //currentPageNoTag는 list를 클릭하였을때 필요한 정보인 currentPageNo 이외에 다른 폼정보가 넘어가는걸 방지하기 위해서 clone()에 보내고싶은 정보만 저장한다.
                formObj.attr("action","/board/list").attr("method","get");
                let currentPageNoTag = $("input[name='currentPageNo']").clone();
                let currentPageNoTag = $("input[name='currentPageNo']").clone();
                let currentPageNoTag = $("input[name='currentPageNo']").clone();
                formObj.empty();
                formObj.append(currentPageNoTag);
            }
            formObj.submit();
        });
    });
</script>

<%@include file="../includes/footer.jsp"%>
