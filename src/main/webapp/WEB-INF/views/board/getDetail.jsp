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

                    <div class="my-3 p-3 bg-white rounded shadow-sm" style="background-color: #f8f7fffa!important; padding-top: 30px">
                        <div class="row">
                            <div class="col-sm-10">
                                <textarea name="content" id="content" class="form-control" rows="3" placeholder="댓글을 입력해 주세요"></textarea>
                            </div>
                            <div class="writer-area col-sm-2">
                                <input style="margin-bottom: 10px" value="ufozx" name="writer" class="form-control" id="writer" readonly="readonly"></input>
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
    function deleteReply(replyNo) {
        let url = "/replies/" + replyNo;
        if (!confirm("정말로 삭제하시겠습니까?")) {
            return false;
        }
        $.ajax({
            type: 'delete',
            url: url,
            dataType: 'text',
            contentType: 'json',
            success: function (result) {
                if (result === "delSuccess") {
                    console.log("댓글 삭제 성공!");
                    printReplyList();
                }else if (result === "delFail") {
                    console.log("삭제 에러 발생(Database)");
                    alert("에러 발생");
                }
            }, error: function (error) {
                alert("script 에러 발생")
            }
        });
    }

    function printReplyList(){
        console.log("댓글리스트 호출");
        let dataObject = new Date();
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
                    htmls += '<div>';
                    htmls += '<p>등록된 댓글이 없습니다!!</p>';
                    htmls += '</div>';
                }else{
                    console.log(result);
                    $(result).each(function (){
                        console.log("list value")
                        htmls += '<div class="media text-muted pt-3" id="rid' + this.reply_no + '">';

                        htmls += '<p class="media-body pb-3 mb-0 small lh-125 border-bottom">';

                        htmls += '<span class="d-block">';

                        htmls += '<strong style="padding-right: 10px" class="text-gray-dark">' + this.writer + '</strong>';

                        htmls += displayTime(this.regdate);

                        htmls += '<span style="padding-left: 1060px; font-size: 9pt">';

                        htmls += '<a href="javascript:void(0)" class="btn btn-danger btn-circle btn-sm" onclick="deleteReply('+this.reply_no+')">';
                        htmls += '<i class="fas fa-trash">';
                        htmls += '</i>';
                        htmls += '</a>';

                        htmls += '</span>';

                        htmls += '</span>';

                        htmls += this.content;

                        htmls += '</p>';

                        htmls += '</div>';

                    });	//each end

                } //else end
                $("#replyList").html(htmls);

            }
        }); //ajax end
    } //pringReplyList end

    function displayTime(timeValue) {
        let today = new Date();
        let gap = today.getTime() - timeValue;
        let dateObj = new Date(timeValue);
        let str= "";

        if(gap < (1000*60*60*24)) {
            let hh = dateObj.getHours();
            let mi = dateObj.getMinutes();
            let ss = dateObj.getSeconds();
            return [(hh > 9 ? '' : '0') + hh, ':', (mi > 9 ? '' : '0') + mi, ':', (ss>9? '':'0') + ss].join('');
        } else {
            let yy = dateObj.getFullYear();
            let mm = dateObj.getMonth() + 1; //getMonth는 zero-based
            let dd = dateObj.getDate();
            return [yy, '/', (mm>9 ? '': '0') + mm, '/', (dd>9? '':'0') + dd].join('');
        }
    };


    $(document).ready(function () {
        let operForm = $("#operForm");

        printReplyList();

        $("button[data-oper='modify']").on("click", function (e) {
            operForm.attr("action", "/board/modify").submit();
        });

        $("button[data-oper='list']").on("click", function (e) {
            operForm.find("#board_no").remove();
            operForm.attr("action", "/board/list");
            operForm.submit();
        });


        $("#btnReplySave").on("click",function (){
            let replyContent = $("textarea#content").val();
            let replyWriter = $("#writer").val();
            let url = "/replies/new"
            let paramData = JSON.stringify({"content":replyContent,"writer":replyWriter,"board_no":"${board.board_no}"});

            if(replyContent === ''){
                alert("댓글 내용을 입력하지 않았습니다.");
                $("textarea#content").focus();
                return false;
            }
            $.ajax({
                type: 'post',
                url: url,
                contentType: 'application/json',
                dataType: 'text',
                data: paramData,
                success: function (result) {
                    if (result === "regSuccess") {
                        console.log("댓글 등록 성공!");

                        printReplyList();

                        $("textarea#content").val('');
                    }
                }
                ,error: function (error){
                    if(error === "regFail"){
                        console.log("댓글 에러....");
                        alert("ReplyC Error...");
                    }
                }

            }); //ajax End
        }); //댓글등록 함수 End

    }); //document ready End

</script>

<%@include file="../includes/footer.jsp"%>
