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
<script src="${APP_PATH}/static/js/jquery-3.3.1.min.js"></script>
<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.js"></script>

<!--web路径：
不以/开始的相对路径，找资源，以当前资源路径为基准
以/开始的路径，找资源，以服务器的路径为标准

-->
<head>
    <title>员工列表</title>
</head>
<body>
<!-员工修改的模态框-->
<!-- 员工添加 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" >修改员工</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" class="form-control" name="email" id="email_update_input"
                                   placeholder="email">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">部门</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_update_select">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>
<!-- 员工添加 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">添加员工</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="empName" id="empName_add_input"
                                   placeholder="username">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" class="form-control" name="email" id="email_add_input"
                                   placeholder="email">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">部门</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_add_select">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_sav_btn">保存</button>
            </div>
        </div>
    </div>
</div>

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
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
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
        <div class="col-md-6" id="page_info_area">
        </div>
        <!--分页条信息-->
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>
</div>
<script type="text/javascript">
    var totalRecord;
    //页面加载完成后，发送ajax请求，要到分页数据
    $(function () {
        to_page(1);

    });

    function to_page(pn) {

        $.ajax({
            url: "${APP_PATH}/emps",
            data: "pn=" + pn,
            type: "GET",
            success: function (result) {
                //console.log(result);
                //1.在页面解析json,并显示员工信息
                build_emp_table(result);
                //2.显示分页信息
                bulid_page_info(result);
                //3.解析显示分页条数据
                bulid_page_nav(result);
            }
        })

    }

    //显示表格信息
    function build_emp_table(result) {
        //清空表格
        $("#emps_table tbody").empty();
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
                .addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>")
                    .addClass("glyphicon glyphicon-pencil"))
                .append("编辑");
            //为编辑按钮添加一个自定义的属性，来表示当前员工的id
            editBtn.attr("edit-id",item.empId);

            var delBtn = $("<button></button>")
                .addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>")
                    .addClass("glyphicon glyphicon-trash"))
                .append("删除");
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            //append方法执行完成以后，还是返回原来的元素
            $("<tr></tr>").append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");
        })
    };

    //解析显示分页信息。
    function bulid_page_info(result) {
        $("#page_info_area").empty();
        $("#page_info_area").append(" 当前第" + result.extend.pageInfo.pageNum + " 页," +
            "总共" + result.extend.pageInfo.pages + "页,总共" + result.extend.pageInfo.total + "记录")
        totalRecord = result.extend.pageInfo.total;

    }


    //显示分页信息,点击下一页要能去下一页
    function bulid_page_nav(result) {
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");
        //构建
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if (result.extend.pageInfo.hasPreviousPage == false) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        } else {
            //为元素添加点击翻页的事件
            firstPageLi.click(function () {
                to_page(1);
            });
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1);
            });
        }


        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
        if (result.extend.pageInfo.hasNextPage == false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        } else {
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1);
            });
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages)
            });
        }

        //构造首页和前一页
        ul.append(firstPageLi).append(prePageLi);
        //给每一页添加
        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (result.extend.pageInfo.pageNum == item) {
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item);
            })

            ul.append(numLi);
        });
        //添加下一页和末页
        ul.append(nextPageLi).append(lastPageLi);
        //将ul加入到nav中
        var navEle = $("<nav></nav>").append(ul);

        navEle.appendTo("#page_nav_area");
    }

    //清空表单样式及内容
    function reset_form(ele) {
        $(ele)[0].reset();
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");

    }
    
    $("#emp_add_modal_btn").click(function () {
        //清除表单数据
        reset_form("#empAddModal form");
        //$("#empAddModal form")[0].reset();
        //弹出模态框，发送ajax请求，显示在下拉列表中
        getDepts("#empAddModal select");
        $("#empAddModal").modal({
            backdrop: "static"
        });

    });
    

    function getDepts(ele) {
        //清空之前下拉列表得知
        $(ele).empty();
        $.ajax({
            url: "${APP_PATH}/depts",
            type: "GET",
            success: function (result) {
                //console.log(result);
                //显示部门信息，在下拉列表中
                //$("#empAddModal select").append()
                $.each(result.extend.depts, function () {
                    var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                    optionEle.appendTo(ele);
                })
            }
        });
    }

    //校验
    function validate_add_form() {
        //拿到要校验的数据，使用正则表达式
        var empName = $("#empName_add_input").val();
        var regName = /(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        //alert(regName.test(empName));
        if (!regName.test(empName)) {
            //alert("用户名可以是2-5位汉字，或者6-16位字母的组合");
            show_validate_msg("#empName_add_input", "error", "用户名可以是2-5位汉字，或者6-16位字母的组合")
            /*$("#empName_add_input").parent().addClass("has-error");
            $("#empName_add_input").next("span").text("用户名可以是2-5位汉字，或者6-16位字母的组合");*/
            return false;

        } else {
            show_validate_msg("#empName_add_input", "success", "")
            /*  $("#empName_add_input").parent().addClass("has-success");
              $("#empName_add_input").next("span").text("");*/
        }
        var email = $("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            //alert("邮箱格式不正确");
            //应该清空之前的样式
            show_validate_msg("#email_add_input", "error", "邮箱格式不正确")
            /*$("#email_add_input").parent().addClass("has-error");
            $("#email_add_input").next("span").text("邮箱格式不正确");*/
            return false;

        } else {
            show_validate_msg("#email_add_input", "success", "")
            /* $("#email_add_input").parent().addClass("has-success");
             $("#email_add_input").next("span").text("");*/
        }
        return true;
    }

    function show_validate_msg(ele, status, msg) {
        //清除当前元素的校验状态
        $(ele).parent().removeClass("has-error has-success");
        if (status == "success") {
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);


        } else if (status == "error") {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);

        }
    }

    //校验用户名是否可用
    $("#empName_add_input").change(function () {
        var empName = this.value;
        $.ajax({
            url: "${APP_PATH}/checkuser",
            data: "empName=" + empName,
            type: "POST",
            success: function (result) {
                if (result.code == 100) {
                    show_validate_msg("#empName_add_input", "success", "用户名可用");
                    $("#emp_sav_btn").attr("ajax-va", "success");
                } else {
                    show_validate_msg("#empName_add_input", "error", result.extend.va_msg);
                    $("#emp_sav_btn").attr("ajax-va", "error");
                }
            }
        })
    });
    //点击保存
    //模态框中的数据发送请求，保存到服务器
    $("#emp_sav_btn").click(function () {
        //对要发送给服务器的数据进行校验
          if (!validate_add_form()) {
            return false;
        }
        //判断之前的ajax用户名请求校验是否成功。如果成功
        if ($(this).attr("ajax-va") == "error") {
            return false;
        }
        //alert($("#empAddModal form").serialize());
        //发送ajax请求,保存员工
        $.ajax({
            url: "${APP_PATH}/emp",
            type: "POST",
            data: $("#empAddModal form").serialize(),
            success: function (result) {

                if(result.code==100){
                    //保存成功,关闭模态框,来到最后一页
                    $("#empAddModal").modal('hide');
                    //发送ajax请求,到最后一页
                    //将总记录数,
                    to_page(totalRecord);
                }else{
                    //显示失败信息
                    console.log(result);
                    if (undefined==result.extend.errorFields.empName){
                        show_validate_msg("#email_add_input", "error", result.extend.errorFields.email);
                    }
                    if (undefined==result.extend.errorFields.email){
                        show_validate_msg("#empName_add_input", "error", result.extend.errorFields.empName);
                    }
                }


            }
        })
        //alert($("#empAddModal form").serialize());
    });
    //按钮创建之前，就绑定了
    //1）可以在创建按钮时，绑定事件 2）live方法，可以为后来的元素绑定，使用on方法进行替代。
    $(document).on("click",".edit_btn",function () {
        //alert("edit");
        //0.查出员工信息，显示员工信息

        //1.查出部门信息，并显示部门列表
        getDepts("#empUpdateModal select");
        getEmp($(this).attr("edit-id"));
        $("#empUpdateModal").modal({
            backdrop: "static"
        });
    })
    function getEmp(id){
        $.ajax({
            url:"${APP_PATH}/emp/"+id,
            type:"GET",
            success:function (result) {
                //console.log(result);
                var empData=result.extend.emp;
                $("#empName_update_static").text(empData.empName);
                $("#email_add_input").val(empData.email);
                $("#empUpdateModal input[name=gender]").val([empData.gender]);
                $("#empUpdateModal select").val(empData.dId);
            }
        })
    }

</script>
</body>
</html>
