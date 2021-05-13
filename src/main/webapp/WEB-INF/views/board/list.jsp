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
        <div class="card shadow mb-4" >
            <div class="card-header py-3" style="display: flex; justify-content: space-between">
                <h6 style="padding-top: 10px;" class=" font-weight-bold text-primary">Board List Page</h6>
                <button  id='regBtn' type="button" class="btn btn-outline-info pull-right">Register</button>
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
                                <td><a href="/board/get?board_no=${board.board_no}"><c:out value="${board.title}"/></a></td>
                                <td><c:out value="${board.writer}"/></td>
                                <c:choose>
                                    <c:when test="${date eq regtoday}">
                                        <td><fmt:formatDate value="${board.regdate}" pattern="HH:mm:ss"/></td>
                                    </c:when>
                                    <c:otherwise>
                                        <td><c:out value="${regtoday}"/></td>
                                    </c:otherwise>
                                </c:choose>
                                <td><c:out value="${board.viewcnt}"/></td>
                            </tr>
                        </c:forEach>
                    </table>

                    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
                         aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="myModalLabel">Modal title</h5>
                                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">×</span>
                                    </button>
                                </div>
                                <div class="modal-body">처리가 완료되었습니다.</div>
                                <div class="modal-footer">
                                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                                    <%--<button class="btn btn-primary" type="button">Save changes</button>--%>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- /.container-fluid -->
    <script type="text/javascript">
        $(document).ready(function () {
            let result = '<c:out value="${result}"/>';

            checkModal(result);

            history.replaceState({},null,null);

            function checkModal(result) {
                if (result === '' || history.state) {
                    return;
                }

                if(parseInt(result) > 0){
                    $(".modal-body").html("게시글 " + parseInt(result) + " 번이 등록되었습니다.");
                }
                $("#myModal").modal("show");

            }

            $("#regBtn").on("click", function (){
                self.location = "/board/register";
            });
        });
    </script>

<%@include file="../includes/footer.jsp"%>
