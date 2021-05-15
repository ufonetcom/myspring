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
                        <button type="submit" data-oper='list' class="btn btn-info btn-icon-split">
                            <span class="icon text-white-50">
                                <i class="fas fa-arrow-right"></i>
                            </span>
                            <span class="text">목록</span>
                        </button>
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
                //move to list
                formObj.attr("action","/board/list").attr("method","get");
                formObj.empty();
            }
            formObj.submit();
        });
    });
</script>

<%@include file="../includes/footer.jsp"%>
