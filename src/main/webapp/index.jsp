<%--
  Created by IntelliJ IDEA.
  User: vinda
  Date: 2018/4/14
  Time: 16:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<%
    pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<meta>
<link rel="stylesheet" href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.css">
<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
<script src="${APP_PATH}/static/js/jquery-3.3.1.min.js"></script>
<!--web路径：
不以/开始的相对路径，找资源，以当前资源路径为基准
以/开始的路径，找资源，以服务器的路径为标准

-->
<head>
    <title>员工列表</title>
</head>
<body>
<!--搭建显示页面-->
<div class="container">
    <!--标题-->
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <!--按钮-->
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary">新增</button>
            <button class="btn btn-danger ">删除</button>
        </div>
    </div>
    <!--表格-->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>#</th>
                    <th>姓名</th>
                    <th>性别</th>
                    <th>email</th>
                    <th>部门</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>

            </table>
        </div>


    </div>
    <!--分页信息-->
    <div class="row">
        <div class="col-md-6">
            当前第 页,总共 页,总记录数为
        </div>
        <!--分页条信息-->
        <div class="col-md-6">

        </div>
    </div>
</div>
<script type="text/javascript">
    //页面加载完成后，发送ajax请求，要到分页数据
    $(function () {
        $.ajax({
            url: "${APP_PATH}/emps",
            data: "pn=1",
            type: "GET",
            success: function (result) {
                //console.log(result);
                //1.在页面解析json,并显示员工信息
                build_emp_table(result);
                //2.显示分页信息
            }
        })

    });

    //显示表格信息
    function build_emp_table(result) {
        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {
            //alert(item.empName);
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var gender = item.gender == "M" ? "男" : "女";
            var genderTd = $("<td></td>").append(gender);
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);

            /*
            *    <button class="btn btn-primary btn-sm"><span class="glyphicon glyphicon-pencil"></span> 编辑
                            </button>
                            <button class="btn btn-danger btn-sm"><span class="glyphicon glyphicon-trash"></span> 删除
                            </button>*/
            var editBtn = $("<button></button>")
                .addClass("btn btn-primary btn-sm")
                .append($("<span></span>")
                    .addClass("glyphicon glyphicon-pencil"))
                .append("编辑");
            var delBtn = $("<button></button>")
                .addClass("btn btn-danger btn-sm")
                .append($("<span></span>")
                    .addClass("glyphicon glyphicon-trash"))
                .append("删除");
            var btnTd=$("<td></td>").append(editBtn).append(" ").append(delBtn);
            //append方法执行完成以后，还是返回原来的元素
            $("<tr></tr>").append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");
        })
    }

    //显示分页信息
    function bulid_page_nav(result) {

    }


</script>
</body>
</html>
