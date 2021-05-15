<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="../includes/header.jsp"%>
<!-- Begin Page Content -->
<div class="container-fluid">

    <!-- Page Heading -->
    <h1 class="h3 mb-2 text-gray-800">BoardDetail Page</h1>
    <p class="mb-4">게시글</p>

    <!-- DataTales Example -->
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">게시판 상세정보</h6>
        </div>
        <div class="card-body">

            <div class="form-group">
                <div class="col-sm-8 mb-5">
                    <label>글 번호</label>
                    <input class="form-control" name="board_no"
                           value='<c:out value="${board.board_no}"/>' readonly="readonly">
                </div>
                <div class="col-sm-8 mb-5">
                    <label>등록일</label>
                    <input class="form-control" name="board_no"
                           value='<fmt:formatDate value="${board.regdate}" pattern="yyyy-MM-dd HH:ss"/>' readonly="readonly">
                </div>
                <div class="col-sm-8 mb-5">
                    <label>제목</label>
                    <input type="text" class="form-control" name="title"
                           value='<c:out value="${board.title}"/>' readonly="readonly">
                </div>
                <div class="col-sm-8 mb-5">
                    <label>글 내용</label>
                    <textarea class="form-control" name="content" readonly="readonly"><c:out value="${board.content}"/></textarea>
                </div>
                <div class="col-sm-8 mb-5">
                    <label>작성자</label>
                    <input class="form-control" name="writer"
                    value='<c:out value="${board.writer}"/>' readonly="readonly">
                </div>

                <div>
                    <button data-oper="modify" class="btn btn-success btn-icon-split">
                        <span class="icon text-white-50">
                                <i class="fas fa-check"></i>
                        </span>
                        <span class="text">수정</span>
                    </button>

                    <button data-oper="list" class="btn btn-info btn-icon-split">
                        <span class="icon text-white-50">
                            <i class="fas fa-arrow-right"></i>
                            </span>
                        <span class="text">목록</span>
                    </button>

                    <form id="operForm" action="/board/modify" method="get">
                        <input type="hidden" id="board_no" name="board_no" value='<c:out value="${board.board_no}"/>'>
                    </form>
                </div>
            </div>
        </div>
    </div>

</div>
<!-- /.container-fluid -->
<script type="text/javascript">
    $(document).ready(function () {
        let operForm = $("#operForm");

        $("button[data-oper='modify']").on("click", function (e) {
            operForm.attr("action", "/board/modify").submit();
        });

        $("button[data-oper='list']").on("click", function (e) {
            operForm.find("#board_no").remove();
            operForm.attr("action", "/board/list");
            operForm.submit();
        });
    });
</script>

<%@include file="../includes/footer.jsp"%>
