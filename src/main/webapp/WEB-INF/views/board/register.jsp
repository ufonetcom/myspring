<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="../includes/header.jsp"%>
<!-- Begin Page Content -->
<div class="container-fluid">

    <!-- Page Heading -->
    <h1 class="h3 mb-2 text-gray-800">Register</h1>
    <p class="mb-4">게시글 등록</p>

    <!-- DataTales Example -->
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">자유게시판 글 등록</h6>
        </div>
        <div class="card-body">
            <form role="form" action="/board/register" method="post">
                <div class="form-group">
                    <div class="col-sm-8 mb-5">
                        <label>Title</label>
                        <input type="text" class="form-control" name="title" placeholder="제목을 입력하세요.">
                    </div>
                    <div class="col-sm-8 mb-5">
                        <label>Writer</label>
                        <input class="form-control" name="writer">
                    </div>
                    <div class="col-sm-8 mb-5">
                        <label>Text area</label>
                        <textarea class="form-control" name="content" placeholder="내용을 입력하세요." rows="5"></textarea>
                    </div>

                    <div>
                        <button type="submit" class="btn btn-success btn-icon-split">
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

<%@include file="../includes/footer.jsp"%>
