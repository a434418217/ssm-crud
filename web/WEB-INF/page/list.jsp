<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--项目路径--%>
<% pageContext.setAttribute("PATH",request.getContextPath());%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>

    <link href="${PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${PATH}/static/bootstrap-3.3.7-dist/js/jquery-3.2.1.min.js"></script>
    <script src="${PATH}/static/js/jquery-1.8.3.min.js" type="text/javascript"></script>
    <title>员工列表</title>
</head>
<body>

<%--栅格系统--%>
    <div class="container">
<%--        分四行--%>

<%--        标题--%>
        <div class="row">
            <div class="col-md-12">
                <h2>SSM-CRUD</h2>
            </div>
        </div>
<%--    操作按钮--%>
        <div class="row">
<%--            设置按钮位置，偏移--%>
            <div class="col-md-4 col-md-offset-8">
                <button class="btn btn-primary btn-sm">增添</button>
                <button class="btn btn-danger btn-sm">删除</button>
            </div>
        </div>
<%--    表格--%>
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover">
                    <tr>
                        <th>编号</th>
                        <th>姓名</th>
                        <th>性别</th>
                        <th>邮箱</th>
                        <th>部门</th>
                        <th>操作</th>
                    </tr>
                    <c:forEach items="${pageInfo.list}" var="emp">
                        <tr>
                            <td>${emp.eId}</td>
                            <td>${emp.eName}</td>
                            <td>${emp.eGender == "M"? "男":"女"}</td>
                            <td>${emp.eEmail}</td>
                            <td>${emp.deparment.dName}</td>
                            <td>
                                <button class="btn btn-primary btn-xs">
                                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                    修改
                                </button>
                                <button class="btn btn-danger btn-xs">
                                    <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                    删除
                                </button>
                            </td>
                        </tr>
                    </c:forEach>

                </table>
            </div>
        </div>
<%--    分页信息--%>
        <div class="row">
<%--            分页文字--%>
            <div class="col-md-6">
                <div>
                    当前页码：${pageInfo.pageNum}，
                    总页码：${pageInfo.pages}，
                    总${pageInfo.total}条记录
                </div>
            </div>
<%--            分页条--%>
            <div class="col-md-6">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <li><a href="${PATH}/emp?page=1">首页</a></li>
                        <c:if test="${pageInfo.hasPreviousPage}">
                            <li>
                                <a href="${PATH}/emp?page=${pageInfo.pageNum-1}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:if>

                        <c:forEach items="${pageInfo.navigatepageNums}" var="page_Num">
<%--                            为当前页码就激活调亮--%>
                            <c:if test="${pageInfo.pageNum == page_Num}">
                                <li class="active"><a href="#">${page_Num}</a></li>
                            </c:if>
                            <c:if test="${pageInfo.pageNum != page_Num}">
                                <li><a href="${PATH}/emp?page=${page_Num}">${page_Num}</a></li>
                            </c:if>
                        </c:forEach>

                        <c:if test="${pageInfo.hasNextPage}">
                            <li>
                                <a href="${PATH}/emp?page=${pageInfo.pageNum+1}" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <li><a href="${PATH}/emp?page=${pageInfo.pages}">末页</a></li>
                    </ul>
                </nav>
            </div>
        </div>

    </div>

</body>
</html>
