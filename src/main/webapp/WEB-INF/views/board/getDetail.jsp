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
                    <button data-oper="modify" class="btn btn-success"
                    onclick="location.href='/board/modify?board_no=<c:out value="${board.board_no}"/>'">Modify</button>

                    <button data-oper="list" class="btn btn-info"
                    onclick="location.href='/board/list'">List</button>
                </div>
            </div>


        </div>
    </div>

</div>
<!-- /.container-fluid -->

<%@include file="../includes/footer.jsp"%>
