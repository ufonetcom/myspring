<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="../includes/header.jsp"%>
    <!-- Begin Page Content -->
    <div class="container-fluid">

        <!-- Page Heading -->
        <h1 class="h3 mb-2 text-gray-800">Tables</h1>
        <p class="mb-4">게시판 테이블</p>

        <!-- DataTales Example -->
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">DataTables Example</h6>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                        <thead>
                        <tr>
                            <th>번호</th>
                            <th>제목</th>
                            <th>작성자</th>
                            <th>작성일</th>
                            <th>수정일</th>
                            <th>조회수</th>
                        </tr>
                        </thead>
                        <c:forEach items="${list}" var="board">
                            <tr>
                                <td><c:out value="${board.board_no}"/></td>
                                <td><c:out value="${board.title}"/></td>
                                <td><c:out value="${board.writer}"/></td>
                                <td><fmt:formatDate pattern="yyyy-MM-dd hh:mm:ss" value="${board.regdate}"/>
                                <td><fmt:formatDate pattern="yyyy-MM-dd hh:mm:ss" value="${board.updatedate}"/>
                                <td><c:out value="${board.viewcnt}"/></td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </div>
        </div>

    </div>
    <!-- /.container-fluid -->

<%@include file="../includes/footer.jsp"%>
