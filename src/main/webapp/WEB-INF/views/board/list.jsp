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
                    <table class="table table-bordered" width="100%" cellspacing="0">
                        <thead>
                        <tr>
                            <th>번호</th>
                            <th>제목</th>
                            <th>작성자</th>
                            <th>작성일</th>
                            <th>조회수</th>
                        </tr>
                        </thead>
                        <c:set var="today" value="<%=new java.util.Date()%>"/>
                        <c:set var="date"><fmt:formatDate value="${today}" pattern="yyyy-MM-dd"/></c:set>

                        <c:forEach items="${list}" var="board">
                            <c:set var="regtoday"><fmt:formatDate value="${board.regdate}" pattern="yyyy-MM-dd"/></c:set>
                            <tr>
                                <td><c:out value="${board.board_no}"/></td>
                                <td><c:out value="${board.title}"/></td>
                                <td><c:out value="${board.writer}"/></td>
                                <c:choose>
                                    <c:when test="${date eq regtoday}">
                                        <td><fmt:formatDate value="${board.regdate}" pattern="hh:mm:ss"/></td>
                                    </c:when>
                                    <c:otherwise>
                                        <td><c:out value="${regtoday}"/></td>
                                    </c:otherwise>
                                </c:choose>
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
