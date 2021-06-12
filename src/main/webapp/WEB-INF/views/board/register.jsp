<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="../includes/header.jsp"%>
<!-- Begin Page Content -->
<div class="container-fluid">

    <!-- Page Heading -->
    <h1 class="h3 mb-2 text-gray-800">Register</h1>

    <!-- DataTales Example -->
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">자유게시판 글 등록</h6>
        </div>
        <div class="card-body">
            <form role="form" action="/board/register" method="post" ENCTYPE="multipart/form-data">
                <div class="form-check">
                    <label>공지글
                    <input type="checkbox" name="notice_yn" id="notice_yn" value="Y">
                    </label>
                </div>
                <div class="form-check">
                    <label>비밀글
                    <input type="checkbox" name="secret_yn" id="secret_yn" value="Y">
                    </label>
                </div>
                <div class="form-group">
                    <div class="col-sm-8 mb-5">
                        <label>Title</label>
                        <input type="text" class="form-control" id="title" name="title" placeholder="제목을 입력하세요." required>
                    </div>
                    <div class="col-sm-8 mb-5">
                        <label>Writer</label>
                        <input class="form-control" name="writer">
                    </div>
                    <div class="col-sm-8 mb-5">
                        <label>Text area</label>
                        <textarea class="form-control" name="content" id="content" placeholder="내용을 입력하세요." rows="5" required></textarea>
                    </div>

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

                    <div id="btnDiv">
                        <button type="submit" class="btn btn-success btn-icon-split" id="regSubmit">
                            <span class="icon text-white-50">
                                <i class="fas fa-check"></i>
                            </span>
                            <span class="text">Submit Button</span>
                        </button>
                        <button type="reset" class="btn btn-secondary btn-icon-split">
                            <span class="icon text-white-50">
                                <i class="fas fa-arrow-right"></i>
                            </span>
                            <span class="text">Reset</span>
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>

</div>
<!-- /.container-fluid -->
<script type="text/javascript">
    let fileIdx = 0; //파일 index처리용 전역변수

    function changeFilename(file) {
        file = $(file);
        const filename = file[0].files[0].name;
        console.log("선택된 파일 이름 >>> " + filename);
        console.log("선택된 파일 사이즈 >>> " + file[0].files[0].size);
        const target = file.prevAll('input');

        target.val(filename);
    }

    function removeFile(elem) {
        const prevTag = $(elem).prev().prop('tagName');
        if (prevTag === 'BUTTON') {
            const file = $(elem).prevAll('input[type="file"]');
            const fileName = $(elem).prevAll('input[type="text"]');
            file.val('');
            fileName.val("파일 찾기");
            return false;
        }

        $('label[id="filecnt"]').text("파일 : "+ (fileIdx) + "/3");
        fileIdx--;

        const target = $(elem).parents('div[data-name="fileDiv"]');
        target.remove();
    }

    function addFile() {
        const fileDivs = $('div[data-name="fileDiv"]');
        console.log("fileDivs>>>>>"+fileDivs.length);
        if (fileDivs.length > 2) {
            alert("파일은 최대 3개까지 업로드 할 수 있습니다.");
            return false;
        }

        fileIdx++;

        $('label[id="filecnt"]').text("파일 : "+ (fileIdx+1) + "/3");

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
    }

    $(document).ready(function (){
        let formObj = $("form");

    });
</script>
<%@include file="../includes/footer.jsp"%>
