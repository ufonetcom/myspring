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
                        <input type="hidden" id="currentPageNo" name="currentPageNo" value='<c:out value="${params.currentPageNo}"/>'>
                        <input type="hidden" id="recordsPerPage" name="recordsPerPage" value='<c:out value="${params.recordsPerPage}"/>'>
                        <input type="hidden" id="pageSize" name="pageSize" value='<c:out value="${params.pageSize}"/>'>
                        <input type="hidden" id="searchType" name="searchType" value='<c:out value="${params.searchType}"/>'>
                        <input type="hidden" id="searchKeyword" name="searchKeyword" value='<c:out value="${params.searchKeyword}"/>'>
                    </form>

                    <!-- Reply Form {s} -->

                    <div class="my-3 p-3 bg-white rounded shadow-sm" style="padding-top: 30px">
                            <div class="row">
                                <div class="writer-area col-sm-2">
                                    <input value="ufozx" name="writer" class="form-control" id="reg_id" readonly="readonly"></input>
                                </div>
                                <div class="col-sm-10">
                                    <textarea name="content" id="content" class="form-control" rows="3" placeholder="댓글을 입력해 주세요"></textarea>
                                </div>

                                <div class="col-sm-2">
                                    <button type="button" class="btn btn-success btn-icon-split" id="btnReplySave">
                                        <span class="icon text-white-50">
                                            <i class="fas fa-check"></i>
                                        </span>
                                        <span class="text">등록</span>
                                    </button>
                                </div>
                            </div>

                    </div>

                    <!-- Reply Form {e} -->

                    <!-- Reply List {s}-->
                    <div class="my-3 p-3 bg-white rounded shadow-sm" style="padding-top: 10px">
                        <h6 class="border-bottom pb-2 mb-0">Reply list</h6>
                        <div id="replyList"></div>
                    </div>
                    <!-- Reply List {e}-->

                </div>
            </div>
        </div>
    </div>

</div>
<!-- /.container-fluid -->
<script type="text/javascript">
    $(document).ready(function () {
        let operForm = $("#operForm");
        let page = '${params.currentPageNo}';
        console.log("page >> "+page);

        printReplyList();

        $("button[data-oper='modify']").on("click", function (e) {
            operForm.attr("action", "/board/modify").submit();
        });

        $("button[data-oper='list']").on("click", function (e) {
            operForm.find("#board_no").remove();
            operForm.attr("action", "/board/list");
            operForm.submit();
        });

        function printReplyList(){

            let url = "/replies/" + ${board.board_no};
            let paramData = {"board_no" : "${board.board_no}"};
            $.ajax({
                type: 'get',
                url: url,
                data: paramData,
                dataType: 'json',
                success: function (result) {
                    console.log("조회 진입 성공!!");
                    let htmls = "";
                    if(result.length<1){
                        htmls.push("등록된 댓글이 없습니다!!");
                    }else{
                        $(result).each(function (){
                            htmls += '<div class="media text-muted pt-3" id="rid' + this.rid + '">';

                            htmls += '<svg class="bd-placeholder-img mr-2 rounded" width="32" height="32" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice" focusable="false" role="img" aria-label="Placeholder:32x32">';

                            htmls += '<title>Placeholder</title>';

                            htmls += '<rect width="100%" height="100%" fill="#007bff"></rect>';

                            htmls += '<text x="50%" fill="#007bff" dy=".3em">32x32</text>';

                            htmls += '</svg>';

                            htmls += '<p class="media-body pb-3 mb-0 small lh-125 border-bottom horder-gray">';

                            htmls += '<span class="d-block">';

                            htmls += '<strong class="text-gray-dark">' + this.reg_id + '</strong>';

                            htmls += '<span style="padding-left: 7px; font-size: 9pt">';

                            htmls += '<a href="javascript:void(0)" onclick="fn_editReply(' + ${params.reply_no} + ', \'' + this.reg_id + '\', \'' + this.content + '\' )" style="padding-right:5px">수정</a>';

                            htmls += '<a href="javascript:void(0)" onclick="fn_deleteReply(' + this.rid + ')" >삭제</a>';

                            htmls += '</span>';

                            htmls += '</span>';

                            htmls += this.content;

                            htmls += '</p>';

                            htmls += '</div>';



                        });	//each end

                    }
                    $("#replyList").html(htmls);

                }
            });

        }
    });
</script>

<%@include file="../includes/footer.jsp"%>
