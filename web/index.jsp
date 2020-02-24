<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% pageContext.setAttribute("PATH",request.getContextPath());%>
<html>
  <head>
      <script src="${PATH}/static/js/jquery-1.11.0.min.js"  type="text/javascript"></script>
      <link href="${PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
      <script src="${PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
      <title>员工列表</title>
      <script type="text/javascript">

          var pageInfo_pageNum = 0;     //”新增“完成跳转页
          var update_toPage = 0;
<%--          入口函数--%>
          $(function(){
              to_page(1);                  //页面跳转
              emp_add();                  //员工添加
              save_emp();                //员工保存
              emp_update();
              save_emp_update();        //保存修改信息
              del_emp();
              check_all();
              check_items();
              del_emp_many();
          });


          //抽取成方法，分页信息点击时被调用
          function to_page(page) {
              //选中框默认不选中
              $("#check_all").prop("checked",false);
              //发送ajax请求分页数据
              $.ajax({
                  url:"${PATH}/emps",
                  data:"page="+page,
                  type:"GET",
                  success:function (result) {
                      pageInfo_pageNum = result.extend.pageInfo.pages;  //”新增“完成跳转页数
                      update_toPage = result.extend.pageInfo.pageNum;   //修改完跳转刷新当前页
                      emps_table(result);       //员工信息表格
                      emps_pageInfo(result);    //页码信息
                      emps_pageNav(result);     //分页
                  }
              })
          }

          //   表格数据
          function emps_table(result) {
              //由于发送的ajax请求，每次都会append数据，所以每次调用就清空一次
              $("#emps_tb").empty();
              var emps = result.extend.pageInfo.list;
              $.each(emps,function (index,items) {
                  var checkBox = $("<td><input type='checkbox' class='check_items'/></td>")
                  var empId = $("<td></td>").append(items.eId);
                  var empName = $("<td></td>").append(items.eName);
                  var empGender = $("<td></td>").append(items.eGender == "M"?"男":"女");
                  var empEmail = $("<td></td>").append(items.eEmail);
                  var empDeptName = $("<td></td>").append(items.deparment.dName);
                  var updateBtn = $("<button></button>").addClass("btn btn-primary btn-xs emp_update")
                      .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("修改");
                  //为修改按钮添加一个属性，获取点击按钮时的id值
                  updateBtn.attr("updateId",items.eId);
                  var delBtn = $("<button></button>").addClass("btn btn-danger btn-xs emp_del")
                      .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
                  delBtn.attr("delId",items.eId);
                  var Btn = $("<td></td>").append(updateBtn).append(" ").append(delBtn);
                  $("<tr></tr>").append(checkBox).append(empId).append(empName).append(empGender).append(empEmail).append(empDeptName).append(Btn).appendTo("#emps_table");
              })
          }

          //   页码数据
          function emps_pageInfo(result) {
              //由于发送的ajax请求，每次都会append数据，所以每次调用就清空一次
              $("#page_info").empty();
              var page_info = '当前第 <span class="label label-default">'+result.extend.pageInfo.pageNum+'</span> 页，\
							共 <span class="label label-default">'+result.extend.pageInfo.pages+'</span> 页，\
							共 <span class="label label-default">'+result.extend.pageInfo.total+'</span> 条记录'
              $("#page_info").append(page_info);
          }

          //   分页数据
          function emps_pageNav(result) {
              //由于发送的ajax请求，每次都会append数据，所以每次调用就清空一次
              $("#page_nav").empty();
              var nav = $("<nav></nav>");
              var ul = $("<ul><ul/>").addClass("pagination");

              var firstLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
              var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
              if(result.extend.pageInfo.hasPreviousPage != true){
                  //没有前一页，禁用
                  firstLi.addClass("disabled");
                  prePageLi.addClass("disabled");
              }else{
                  //没禁用就跳转
                  firstLi.click(function () {
                      to_page(1);
                  });
                  prePageLi.click(function () {
                      to_page(result.extend.pageInfo.pageNum-1);
                  });
              }
              var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
              var lastLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
              if(result.extend.pageInfo.hasNextPage != true){
                  //没有后一页，禁用
                  nextPageLi.addClass("disabled");
                  lastLi.addClass("disabled");
              }else{
                  //没禁用就跳转
                  nextPageLi.click(function () {
                      to_page(result.extend.pageInfo.pageNum+1);
                  });
                  lastLi.click(function () {
                      to_page(result.extend.pageInfo.pages);
                  });
              }
              ul.append(firstLi).append(prePageLi);
              $.each(result.extend.pageInfo.navigatepageNums,function (index,items) {
                  var li = $("<li></li>").append($("<a></a>").append(items));
                  ul.append(li);
                  li.click(function () {
                      to_page(items);
                  });
                  if(result.extend.pageInfo.pageNum == items){
                      li.addClass("active");
                  }
              });
              ul.append(nextPageLi).append(lastLi);
              nav.append(ul);
              nav.appendTo("#page_nav");
          }

        //    "新增"按钮的单击事件
                function emp_add(){
                      //弹出模态框
                    $("#emp_add").click(function () {
                        //调用模态框，模态框id.modal()
                $("#addModal").modal({
                    backdrop:"static"     //点击框之外的地方无法关闭
                })
            });
                    //添加按钮点击事件，查询所有部门显示在下拉框中
                    $("#emp_add").click(function () {
                        getDepts("#select_depts");
                    })
        }

        //查询部门信息插入指定下拉框
          function getDepts(select) {
                  $(".form-control").val("");     //第二次查询时清空表单
                  $(select).empty();   //多次查询时值重复出现，清空下拉框的值再查询
                  $.ajax({
                      url:"${PATH}/depts",
                      type:"GET",
                      success:function (result) {
                          //遍历结果集
                          $.each(result.extend.depts,function () {
                              var selectItem = $("<option></option>").append(this.dName).attr("value",this.dId);
                              selectItem.appendTo($(select))
                          })
                      }
                  });
          }

       
            //员工保存方法
          function save_emp() {
              $("#save_emp").click(function () {
                  //前段校验，校验失败无法提交
                  if(!vaildated()){
                      return false;
                  }
                  $.ajax({
                    url:"${PATH}/saveEmp",
                    type:"POST",
                      data:$("#addModal form").serialize(),
                    success:function (result) {
                        alert("添加成功");
                        //关闭模态框
                        $("#addModal").modal("hide");
                        //跳转到最后一页
                        to_page(pageInfo_pageNum+1);
                    }
                  });
              });
          }
          
      //    校验方法
          function vaildated() {
              //清空正确或错误格式
              $("#emp_name").parent().removeClass("has-success has-error");
              $("#emp_name").next("span").text("");
              $("#emp_email").parent().removeClass("has-success has-error");
              $("#emp_email").next("span").text("");
               var name = $("#emp_name").val();
                 var regName = /(^[a-z0-9_A-Z]{3,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
                 if(!regName.test(name)){
                     $("#emp_name").parent().addClass("has-error");
                     $("#emp_name").next("span").text("姓名格式错误，应由2-5位汉字或3-16英文字符组成");
                     return false;
                 }else{
                     $("#emp_name").parent().addClass("has-success");
                     $("#emp_name").next("span").text("");
                 }
                var email = $("#emp_email").val();
                var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
                if(!regEmail.test(email)){
                    $("#emp_email").parent().addClass("has-error");
                    $("#emp_email").next("span").text("邮箱格式错误，应由xxx@XX.xx组成");
                    return false;
                }else{
                    $("#emp_email").parent().addClass("has-success");
                    $("#emp_email").next("span").text("");
                }
                return true;
          }

                //员工修改
          function emp_update() {
              $(document).on("click",".emp_update",function () {
                  //防止保存员工出错时，框提示样式错误(save_emp_update())
                  $("#emp_email_update").parent().removeClass("has-success has-error");
                  $("#emp_email_update").next("span").text("");
                  //调用模态框，模态框id.modal()
                  $("#updateModal").modal({
                      backdrop:"static"     //点击框之外的地方无法关闭
                  });
                  getDepts("#select_depts_update");
                  //查出员工信息
                  getEmp($(this).attr("updateId")); //传入当前按钮的自定义值（=id）
                  //把员工id的值传递给保存按钮的属性里
                  $("#save_emp_update").attr("updateId",$(this).attr("updateId"));
              })
          }
          
          //id查询单个员工
          function getEmp(id) {
              $.ajax({
                 url:"${PATH}/emp/"+id,
                  type:"GET",
                  success:function (result) {
                    var emp = result.extend.emp;
                    $("#emp_name_update").val(emp.eName);
                    $("#emp_email_update").val(emp.eEmail);
                    $("#updateModal input[name=eGender]").val([emp.eGender]);
                    $("#select_depts_update").val(emp.eDid);
                  }
              });
          }
          
          //保存员工修改
          function save_emp_update() {
              $("#save_emp_update").click(function () {
                  var email = $("#emp_email_update").val();
                  var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
                  if(!regEmail.test(email)){
                      $("#emp_email_update").parent().addClass("has-error");
                      $("#emp_email_update").next("span").text("邮箱格式错误，应由xxx@XX.xx组成");
                      return false;
                  }else{
                      $("#emp_email_update").parent().addClass("has-success");
                      $("#emp_email_update").next("span").text("");
                  }
                  $.ajax({
                     url:"${PATH}/emp/"+$(this).attr("updateId"),
                      type:"PUT",
                      data:$("#updateModal form").serialize(),  //将表单数据序列化后发送
                      success:function (result) {
                          alert("修改成功");
                          //关闭模态框
                          $("#updateModal").modal("hide");
                          //跳转到最后一页
                          to_page(update_toPage);
                      }
                  });
              });
          }

          //删除单个员工
          function del_emp() {
            $(document).on("click",".emp_del",function () {
                var name = $(this).parents("tr").find("td:eq(2)").text();
                var empId = $(this).attr("delId");
                if(confirm("确认删除 【"+name+"】 吗?")){
                    $.ajax({
                        url:"${PATH}/emp/"+empId,
                        type:"DELETE",
                        success:function (result) {
                            alert(result.msg);
                            to_page(update_toPage);
                        }
                    })
                }
            })
          }

          //全选全不选
          function check_all() {
              $("#check_all").click(function () {
                  //全部选择框的true，false和第一个一致
                  $(".check_items").prop("checked",$("#check_all").prop("checked"));
              })
          }
          
          //选择框填满时，第一个选择框被选中
          function check_items() {
              $(document).on("click",".check_items",function () {
                  //如果被选中的个数和选择框个数相等
                  var flag = $(".check_items:checked").length == $(".check_items").length;
                  $("#check_all").prop("checked",flag);
              })
          }
          
          //批量删除
          function del_emp_many() {
              $("#emp_del_all").click(function () {
                  //获取每个人的名字和id
                  var name = "";
                  var ids = "";
                  $.each($(".check_items:checked"),function () {
                      name += $(this).parents("tr").find("td:eq(2)").text()+",";
                      ids += $(this).parents("tr").find("td:eq(1)").text()+"-";
                  })
                  //去除最后一个符号
                    name = name.substring(0,name.length-1);
                    ids = ids.substring(0,ids.length-1);
                    //判断
                  if(confirm("确定删除 【"+name+"】 吗？")){
                      $.ajax({
                          url:"${PATH}/emp/"+ids,
                          type:"DELETE",
                          success:function (result) {
                              alert(result.msg)
                              to_page(update_toPage);
                          }
                      })
                  }
              })
          }


      </script>
  </head>
  <body>
  <%--  "修改"的模态弹出框--%>
  <div class="modal fade" id="updateModal" tabindex="-1" role="dialog">
      <div class="modal-dialog" role="document">
          <div class="modal-content">
              <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                  <h4 class="modal-title">员工修改</h4>
              </div>
              <div class="modal-body">
                  <%--                  表单--%>
                  <form class="form-horizontal">
                      <div class="form-group">
                          <label for="emp_name" class="col-sm-2 control-label">姓 名:</label>
                          <div class="col-sm-10">
                              <input class="form-control" type="text" placeholder="" id="emp_name_update" readonly>
                              <span class="help-block"></span>
                          </div>
                      </div>
                      <div class="form-group">
                          <label for="emp_email" class="col-sm-2 control-label">邮 箱:</label>
                          <div class="col-sm-10">
                              <input type="email" class="form-control" name="eEmail" id="emp_email_update" placeholder="请输入邮箱">
                              <span class="help-block"></span>
                          </div>
                      </div>
                      <div class="form-group">
                          <label class="col-sm-2 control-label">性 别:</label>
                          <div class="col-sm-10">
                              <label class="radio-inline">
                                  <input type="radio" name="eGender" id="genderm_update" value="M" checked="checked"> 男
                              </label>
                              <label class="radio-inline">
                                  <input type="radio" name="eGender" id="genderw_update" value="W"> 女
                              </label>
                          </div>
                      </div>
                      <div class="form-group">
                          <label class="col-sm-2 control-label">部 门:</label>
                          <div class="col-sm-3">
                              <select class="form-control" name="eDid" id="select_depts_update">
                              </select>
                          </div>
                      </div>
                  </form>
              </div>
              <div class="modal-footer">
                  <button type="button" class="btn btn-default" data-dismiss="modal">关 闭</button>
                  <button type="button" class="btn btn-primary" id="save_emp_update">保 存</button>
              </div>
          </div>
      </div>
  </div>

  <%--  "新增"的模态弹出框--%>
  <div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
      <div class="modal-dialog" role="document">
          <div class="modal-content">
              <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                  <h4 class="modal-title" id="myModalLabel">员工添加</h4>
              </div>
              <div class="modal-body">
<%--                  表单--%>
    <form class="form-horizontal">
        <div class="form-group">
            <label for="emp_name" class="col-sm-2 control-label">姓 名:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" name="eName" id="emp_name" placeholder="请输入姓名">
                <span class="help-block"></span>
            </div>
        </div>
        <div class="form-group">
            <label for="emp_email" class="col-sm-2 control-label">邮 箱:</label>
            <div class="col-sm-10">
                <input type="email" class="form-control" name="eEmail" id="emp_email" placeholder="请输入邮箱">
                <span class="help-block"></span>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">性 别:</label>
            <div class="col-sm-10">
                <label class="radio-inline">
                    <input type="radio" name="eGender" id="genderm" value="M" checked="checked"> 男
                </label>
                <label class="radio-inline">
                    <input type="radio" name="eGender" id="genderw" value="W"> 女
                </label>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">部 门:</label>
            <div class="col-sm-3">
                <select class="form-control" name="eDid" id="select_depts">
                </select>
            </div>
        </div>
    </form>
              </div>
              <div class="modal-footer">
                  <button type="button" class="btn btn-default" data-dismiss="modal">关 闭</button>
                  <button type="button" class="btn btn-primary" id="save_emp">提 交</button>
              </div>
          </div>
      </div>
  </div>

  <%--栅格系统--%>
  <div class="container">
      <%--        分四行--%>

      <%--        标题--%>
      <div class="row">
          <div class="col-md-12">
              <h2>员工操作</h2>
          </div>
      </div>
      <%--    操作按钮--%>
      <div class="row">
          <%--            设置按钮位置，偏移--%>
          <div class="col-md-4 col-md-offset-8">
              <button class="btn btn-primary btn-sm" id="emp_add">增添</button>
              <button class="btn btn-danger btn-sm" id="emp_del_all">删除</button>
          </div>
      </div>
      <%--    表格--%>
      <div class="row">
          <div class="col-md-12">
              <table class="table table-hover" id="emps_table">
                  <thead>
                      <th>
                          <input type="checkbox" id="check_all">
                      </th>
                      <th>编号</th>
                      <th>姓名</th>
                      <th>性别</th>
                      <th>邮箱</th>
                      <th>部门</th>
                      <th>操作</th>
                  </thead>
                  <tbody id="emps_tb">

                  </tbody>
              </table>
          </div>
      </div>
      <%--    分页信息--%>
      <div class="row">
          <%--            分页文字--%>
          <div class="col-md-6" id="page_info">

          </div>
          <%--            分页条--%>
          <div class="col-md-6" id="page_nav">

          </div>
      </div>

  </div>



  </body>
</html>
