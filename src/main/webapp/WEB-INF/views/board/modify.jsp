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
            <form role="form" action="/board/modify" method="post" ENCTYPE="multipart/form-data">
<%--                hidden값에 나머지 recordsPerPage와 pageSize 값은 현재로써는 동적이지 않으므로 view단에서는 crrentPageNo만 넘긴다.--%>
                <input type="hidden" id="currentPageNo" name="currentPageNo" value='<c:out value="${params.currentPageNo}"/>'>
                <input type="hidden" id="searchType" name="searchType" value='<c:out value="${params.searchType}"/>'>
                <input type="hidden" id="searchKeyword" name="searchKeyword" value='<c:out value="${params.searchKeyword}"/>'>
                <!--/* 파일이 변경된 경우, 해당 파라미터를 이용하여 파일 삭제 및 재등록 처리 */-->
                <input type="hidden" id="change_yn" name="change_yn" value="N" />

                <div class="form-group">
                    <div class="form-check">
                        <label>공지글
                            <input type="checkbox" name="notice_yn" id="notice_yn" value="${board.notice_yn}">
                        </label>
                    </div>
                    <div class="form-check">
                        <label>비밀글
                            <input type="checkbox" name="secret_yn" id="secret_yn" value="${board.secret_yn}">
                        </label>
                    </div>
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
                    
                    <c:if test="${empty fileList}">
                        <div data-name="fileDiv" class="form-group filebox bs3-primary">
                            <label for="file_0" id="filecnt" class="col-sm-2 control-label">파일 : 1/3</label>
                            <div class="col-sm-10">
                                <input type="text" class="upload-name" value="파일 찾기" readonly />
                                <label for="file_0" class="control-label">찾아보기</label>
                                <input type="file" name="files" id="file_0" class="upload-hidden" onchange="changeFilename(this)" />

                                <button type="button" onclick="addFile()" class="btn btn-bordered btn-xs visible-xs-inline visible-sm-inline visible-md-inline visible-lg-inline">
                                    <i class="fa fa-plus" aria-hidden="true"></i>
                                </button>
                                <button type="button" onclick="removeFile(this)" class="btn btn-bordered btn-xs visible-xs-inline visible-sm-inline visible-md-inline visible-lg-inline">
                                    <i class="fa fa-minus" aria-hidden="true"></i>
                                </button>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${not empty fileList}">
                        <c:forEach var="row" items="${fileList}" varStatus="status">
                            <div data-name="fileDiv" class="form-group filebox bs3-primary">
                                <label for="file_${status.index}" id="" class="col-sm-2 control-label">파일 : ${status.count}</label>
                                <div class="col-sm-10">
                                    <input type="hidden" name="fileIdx_no" value="${row.file_no}">
                                    <input type="text" class="upload-name" value="${row.original_name}" readonly />
                                    <label for="file_${status.index}" class="control-label">찾아보기</label>
                                    <input type="file" name="files" id="file_${status.index}" class="upload-hidden" onchange="changeFilename(this)" />
                                    <c:if test="${status.count eq 1}">
                                        <button type="button" onclick="addFile()" class="btn btn-bordered btn-xs visible-xs-inline visible-sm-inline visible-md-inline visible-lg-inline">
                                            <i class="fa fa-plus" aria-hidden="true"></i>
                                        </button>
                                    </c:if>
                                    <button type="button" onclick="removeFile(this)" class="btn btn-bordered btn-xs visible-xs-inline visible-sm-inline visible-md-inline visible-lg-inline">
                                        <i class="fa fa-minus" aria-hidden="true"></i>
                                    </button>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>

                    <div id="btnDiv">
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
    const fileDivs = $('div[data-name="fileDiv"]');
    let fileIdx = (!fileDivs) ? 0 : fileDivs.length; //파일 index처리용 전역변수

    function addFile() {
        console.log("fileDivs>>>>>"+fileDivs.length);
        console.log("fileIdx>>>>>"+fileIdx);
        if (fileIdx > 2) {
            alert("파일은 최대 3개까지 업로드 할 수 있습니다.");
            return false;
        }

        document.getElementById('change_yn').value = 'Y';
        fileIdx++;

        // $('label[id="filecnt"]').text("파일 : "+ (fileIdx+1) + "/3");

        let fileHtml = "";
        fileHtml += '<div data-name="fileDiv" class="form-group filebox bs3-primary">';
        fileHtml +=     '<label for="file_' + fileIdx + '" class="col-sm-2 control-label"></label>';
        fileHtml +=     '<div class="col-sm-10">';
        fileHtml +=         '<input type="text" class="upload-name" value="파일 찾기" readonly />';
        fileHtml +=         '<label for="file_' + fileIdx + '" class="control-label">찾아보기</label>';
        fileHtml +=         '<input type="file" name="files" id="file_' + fileIdx + '" class="upload-hidden" onchange="changeFilename(this)" />';
        fileHtml +=         '<button type="button" onclick="removeFile(this)" class="btn btn-bordered btn-xs visible-xs-inline visible-sm-inline visible-md-inline visible-lg-inline">';
        fileHtml +=             '<i class="fa fa-minus" aria-hidden="true"></i>';
        fileHtml +=         '</button>';
        fileHtml +=     '</div>';
        fileHtml += '</div>';

        $('#btnDiv').before(fileHtml);
    } //addFile end

    function removeFile(elem) {
        document.getElementById('change_yn').value = 'Y'; //추가

        const prevTag = $(elem).prev().prop('tagName');
        if (prevTag === 'BUTTON') {
            const file = $(elem).prevAll('input[type="file"]');
            const fileName = $(elem).prevAll('input[type="text"]');
            file.val('');
            fileName.val("파일 찾기");
            return false;
        }

        fileIdx--;

        const target = $(elem).parents('div[data-name="fileDiv"]');
        target.remove();
    } //removeFile() end

    function changeFilename(file) {
        document.getElementById('change_yn').value = 'Y'; //추가

        file = $(file);
        const filename = file[0].files[0].name;
        console.log("선택된 파일 이름 >>> " + filename);
        console.log("선택된 파일 사이즈 >>> " + file[0].files[0].size);
        // const target = file.prevAll('input[class="upload-name"]');  //변경
        const target = file.prevAll('.upload-name');  //변경

        console.log(">>>>>>>"+target.val());

        target.val(filename);

        console.log(">>>>>>>!!"+target.val());

        file.prevAll('input[name="fileIdx_no"]').remove(); //추가
    } //changeFilename() end

    $(document).ready(function () {
        console.log("fileIdx>>>"+fileIdx);

        let formObj = $("form");

        if(formObj.find("input[name='notice_yn']").val() === 'Y'){
            $("#notice_yn").prop("checked", true);
        }
        if (formObj.find("input[name='secret_yn']").val() === 'Y'){
            $("#secret_yn").prop("checked", true);
        }

        $('#btnDiv','button').on("click", function(e){
            e.preventDefault(); //form태그의 모든 버튼은 기본적으로 submit으로 처리하기때문에 기본동작을 막고 연산 처리.

            let operation = $(this).data("oper");

            if (operation === 'remove') {
                formObj.attr("action", "/board/remove");
            }else if (operation === 'list') {
                //move to list 현재는 a태그를 사용하여 데이터를 전송하기 때문에 실제로 이 else if list는 호출되지 않는다.
                //currentPageNoTag는 list를 클릭하였을때 필요한 정보인 currentPageNo 이외에 다른 폼정보가 넘어가는걸 방지하기 위해서 clone()에 보내고싶은 정보만 저장한다.
                formObj.attr("action","/board/list").attr("method","get");
                let currentPageNoTag = $("input[name='currentPageNo']").clone();
                let searchType = $("input[name='searchType']").clone();
                let searchKeyword = $("input[name='searchKeyword']").clone();
                formObj.empty();
                formObj.append(currentPageNoTag);
                formObj.append(searchType);
                formObj.append(searchKeyword);
            }
            formObj.submit();
        });
    });
</script>

<%@include file="../includes/footer.jsp"%>
