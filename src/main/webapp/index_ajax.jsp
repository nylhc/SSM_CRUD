<%--
  Created by IntelliJ IDEA.
  User: zouwei
  Date: 2019/4/16
  Time: 19:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>员工列表页面</title>
    <%--引入标签库--%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%--${APP_PATH}本身以/开头--%>
    <%  pageContext.setAttribute("APP_PATH",request.getContextPath());%>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.3.1.min.js"></script>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script type="text/javascript" src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<%--构建员工添加的模态框--%>
<div class="modal fade" id="add_Modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <%--模态框头部--%>
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">新增员工</h4>
            </div>
            <%--模态框主体部分--%>
            <div class="modal-body">
                <form class="form-horizontal" id="form_save">
                <div class="form-group">
                    <label class="col-sm-4 control-label">ID：</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" id="inputId" placeholder="请输入id" name="id">
                        <%--校验失败后再用jquery给它添加值--%>
                        <span class="help-block"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 control-label">姓名：</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" id="inputName" placeholder="请输入姓名" name="name">
                        <%--校验失败后再用jquery给它添加值--%>
                        <span class="help-block"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 control-label">性别：</label>
                    <div class="col-sm-4">
                        <label class="radio-inline">
                            <input type="radio" name="sex"  value="男"> 男
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="sex" value="女"> 女
                        </label>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 control-label">年龄：</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="age">
                                <option>18</option>
                                <option>19</option>
                                <option>20</option>
                                <option>21</option>
                                <option>22</option>
                                <option>23</option>
                                <option>24</option>
                                <option>25</option>
                                <option>26</option>
                            </select>
                        </div>
                </div>
                </form>
            </div>
            <%--模态框尾部部分--%>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="modal_add_button" type="button" class="btn btn-primary">提交</button>
            </div>
        </div>
    </div>
</div>


<%--构建员工修改的模态框--%>
<div class="modal fade" id="update_Modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <%--模态框头部--%>
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">更新员工数据</h4>
            </div>
            <%--模态框主体部分--%>
            <div class="modal-body">
                <form class="form-horizontal" id="form_update">
                    <div class="form-group">
                        <label class="col-sm-4 control-label">ID：</label>
                        <div class="col-sm-6">
                            <p class="form-control-static" id="updateId"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">姓名：</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="updateName" placeholder="请输入姓名" name="name">
                            <%--校验失败后再用jquery给它添加值--%>
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">性别：</label>
                        <div class="col-sm-4">
                            <label class="radio-inline">
                                <input type="radio" name="sex"  value="男"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="sex"  value="女"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">年龄：</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="age">
                                <option>18</option>
                                <option>19</option>
                                <option>20</option>
                                <option>21</option>
                                <option>22</option>
                                <option>23</option>
                                <option>24</option>
                                <option>25</option>
                                <option>26</option>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <%--模态框尾部部分--%>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="modal_update_button" type="button" class="btn btn-primary">更新</button>
            </div>
        </div>
    </div>
</div>

<%--搭建显示页面--%>
<div class="container">
    <%--第一行--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <%--第二行--%>
    <div class="row">
        <div class="col-md-3 col-md-offset-7">
            <button type="button" id="add_button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#add_Modal">
                <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
            </button>
            <button type="button" class="btn btn-danger btn-lg" id="delete_all">
                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除
            </button>
        </div>
    </div>
    <%--第三行--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-striped" id="table_emps">
                <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="check_all"/>
                        </th>
                        <th>#ID</th>
                        <th>name</th>
                        <th>sex</th>
                        <th>age</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
    <%--第四行--%>
    <div class="row">
        <%--分页信息--%>
        <div class="col-md-5" id="page_info">

        </div>
        <%--===分页条===--%>
        <div class="col-md-7">
            <nav aria-label="Page navigation">
                <ul class="pagination" id="page_nav">

                </ul>
            </nav>
        </div>
    </div>
</div>
<script type="text/javascript">
    //全局变量
    var currentpage;
    //jQuery入口函数
    $(function(){
        to_page(1);
    });
    //根据页码发送ajax请求
    function to_page(pn) {
        //发送ajax请求，拿到服务器的响应数据
        $.ajax({
            url:"${APP_PATH}/emps",
            data:"pn="+pn,
            type:"GET",
            success:function (result) {
                //1.解析并显示员工数据
                build_emps_table(result);
                //2.解析并显示分页信息
                build_page_info(result);
                //3.解析显示分页条数据
                build_page_nav(result);
            }
        });
    }


    //构建分页数据
    function build_emps_table(result) {
        //清空####页面局部刷新，所以需要清空
        $("#table_emps tbody").empty();
        //list是一个对象数组，里面的每一个对象就是一个伪数组
        var emps=result.extend.pageInfo.list;
        $.each(emps,function (index,item) {
            // alert(item.id);
            var checkTD=$("<td><input type='checkbox' class='check_item'/></td>");
            var idTD = $("<td></td>").append(item.id);
            var nameTD = $("<td></td>").append(item.name);
            var sexTD = $("<td></td>").append(item.sex);
            var ageTD = $("<td></td>").append(item.age);
            //构建两个span
            var span1 = $("<span></span>").addClass("glyphicon glyphicon-pencil");
            var span2 = $("<span></span>").addClass("glyphicon glyphicon-trash");
            //构建两个button按钮,将span标签放入button当中
            var button1 = $("<button></button>").append(span1).addClass("btn btn-primary edit_btn").append(" 修改");
            //为button按钮添加一个自定义属性，属性值为其所在行的id值
            button1.attr("edit_id",item.id);
            var button2 = $("<button></button>").append(span2).addClass("btn btn-danger delete_btn").append(" 删除");
            button2.attr("delete_id",item.id);
            //将button按钮放入td中
            var buttonTD = $("<td></td>").append(button1).append(" ").append(button2);
            //将tr放入表中
            $("<tr></tr>").append(checkTD)
                .append(idTD)
                .append(nameTD)
                .append(sexTD)
                .append(ageTD)
                .append(buttonTD)
                .appendTo("#table_emps tbody");
        })
    }


    //构建分页信息
    function build_page_info(result) {
        //清空####页面局部刷新，所以需要清空
        $("#page_info").empty();

        $("#page_info").append("当前是第"+result.extend.pageInfo.pageNum+"页丶"
            +"总共" +result.extend.pageInfo.pages+"页丶"
            +"总共"+result.extend.pageInfo.total+"条记录");
        //给它当前页码
        currentpage=result.extend.pageInfo.pageNum;
    }



    // 构建分页条
    function build_page_nav(result) {
        //清空####页面局部刷新，所以需要清空
        $("#page_nav").empty();

        //page_nav
        var firstLi = $("<li></li>").append($("<a></a>").attr("href","#").append("首页"));
        var preLi=$("<li></li>").append($("<a></a>").attr("href","#").append("上一页"));
        //判断如果没有上一页，就不能点击这个li
        //否则就给他当定点击事件
        if(result.extend.pageInfo.hasPreviousPage == false){
            preLi.addClass("disabled");
        }
        else{
            preLi.click(function () {
                to_page(result.extend.pageInfo.pageNum-1);})
        }
        var nextLi=$("<li></li>").append($("<a></a>").attr("href","#").append("下一页"));
        var endLi = $("<li></li>").append($("<a></a>").attr("href","#").append("末页"));
        //判断如果没有下一页，就不能点击这个li
        //否则就给他当定点击事件
        if(result.extend.pageInfo.hasNextPage == false){
            nextLi.addClass("disabled");
        }
        else{
            nextLi.click(function () {
                to_page(result.extend.pageInfo.pageNum+1);
            })
        }
        //给首页,末页绑定点击事件
        firstLi.click(function () {
            to_page(1);
        })
        endLi.click(function () {
            to_page(result.extend.pageInfo.pages);
        })
        $("#page_nav").append(firstLi)
            .append(preLi);
        //遍历传进来几页
        var navigate=result.extend.pageInfo.navigatepageNums;
        $.each(navigate,function (index,item) {
            var li = $("<li></li>").append($("<a></a>").attr("href","#").append(item));
            //判断若是页码在当前页就让其高亮显示
            if(item === result.extend.pageInfo.pageNum){
                     li.addClass("active");
            }
            $("#page_nav").append(li);
            //给每个li绑定点击事件###调用to_page进行跳转
            li.click(function () {
                to_page(item);
            })
        })
        $("#page_nav").append(nextLi)
            .append(endLi);
    }



    //add_button给新增按钮绑定事件
    $("#add_button").click(function () {
        //重置表单数据
        //jquery没有reset方法，所以必须用dom元素来调用js
        $("#form_save")[0].reset();
        //清楚之前的校验状态
        $("#inputId").parent().removeClass("has-success has-error");
        $("#inputId").next("span").text("");
        $("#inputName").parent().removeClass("has-success has-error");
        $("#inputName").next("span").text("");
    })


    //提交表单数据之前先校验表单数据
    function validator_form(){
        //校验name
        var inputName = $("#inputName").val();
        var regName = 	/^[\u4E00-\u9FA5]{1,10}$/;
        if(!regName.test(inputName)){
            show_validator_msg("#inputName","error","姓名必须是字母或文字");
            return false;
        }else{
            show_validator_msg("#inputName","success");
        }
       return true;

    }
    //显示校验结果信息
    function show_validator_msg(obj,status,msg){
        //清除之前添加的状态
        $(obj).parent().removeClass("has-success has-error");
        $(obj).next("span").text("");
            if(status == "success"){
                $(obj).parent().addClass("has-success");
            }else if(status == "error"){
                $(obj).parent().addClass("has-error");
                $(obj).next("span").text(msg)
            }
    }


    //检查用户ID是否已被注册
    $("#inputId").change(function () {
        //发送ajax请求之前，先进行前端校验ID，提高效率
        var inputId = $("#inputId").val();
        //正则表达式
        var regId = /^[0-9]{1,8}$/;
        if(!regId.test(inputId)){
            show_validator_msg("#inputId","error","id必须是1-8位数字");
            return false;
        }else{
            show_validator_msg("#inputId","success");
        }
        //发送ajax请求检查用户名是否可用
        $.ajax({
            url:"${APP_PATH}/checkID",
            data:"id="+$("#inputId").val(),
            type:"GET",
            success:function (result) {
               // console.log(result);
                if(result.code == 200){
                    show_validator_msg("#inputId","error","id已存在，不可用");
                    //给保存按钮添加一个属性，当id不可用时禁用提交按钮
                    $("#modal_add_button").attr("ajax-va","error");
                }else if(result.code == 100){
                    show_validator_msg("#inputId","success","ID可用");
                    $("#modal_add_button").attr("ajax-va","success");
                }
            }
        })
    })


    //给模态框提交按钮绑定点击事件,提交表单数据
    $("#modal_add_button").click(function () {
        //前端校验|只需要校验name了
        if(!validator_form()){
            return false;
        }
        //校验id是否可用
        if($(this).attr("ajax-va")=="error"){
            show_validator_msg("#inputId","error","id已存在，不可用");
            return false;
        }
        //发送ajax请求，保存员工数据
        $.ajax({
            url:"${APP_PATH}/emps",
            type:"POST",
            data:$("#form_save").serialize(),
            success:function (result) {
                console.log(result);
                //如果后端校验成功
                if(result.code == 100){
                    // 数据校验成功+保存之后||需要做三件事
                    //1.关闭模态框
                    $("#add_Modal").modal('hide');
                    //2.重新发起to_Page的ajax请求，拿到添加后的表格数据
                    to_page(1);
                    //3.提示添加成功
                    alert("添加成功");
                }
                else{
                    //后端校验失败,显示错误信息
                    if(undefined != result.extend.errorFields.id){
                        show_validator_msg($("#inputId"),"error",result.extend.errorFields.id);
                    }
                    if(undefined != result.extend.errorFields.name){
                        show_validator_msg($("#inputName"),"error",result.extend.errorFields.name);
                    }

                }

            }
        })
    })



    /*
     $(".edit_btn").click(function () {
        alert("绑定事件了吗");
    })
    按钮还未被创建，这样绑定不上点击事件
    1.在添加按钮的时候绑定click事件
    2.用on来绑定事件+传入第二个参数
   */
    //给修改按钮绑定事件：
    $(document).on("click",".edit_btn",function () {
        //获取该按钮对应的id
        var edit_id=($(this).attr("edit_id"));
        /*
        * 1.查询员工信息，显示员工信息
        * 2.弹出模态框
        * */
        //ajax请求
        $.ajax({
            url:"${APP_PATH}/emp/"+edit_id,
            type:"GET",
            success:function (result) {
                // 成功之后显示：
                //给p段落赋值
                $("#updateId").text(result.extend.employee.id);
                //给input框赋值
                $("#updateName").val(result.extend.employee.name);
                //给radio赋值
                $("#form_update input[name=sex]").val([result.extend.employee.sex]);
                //给多选select赋值
                $("#form_update select[name=age]").val([result.extend.employee.age]);
            }
        })
        //弹出模态框
        //将id的值传入更新按钮
        $("#modal_update_button").attr("edit-id",edit_id);
        $("#update_Modal").modal({
            backdrop:"static"
        });
    })
    //点击更新按钮，更新数据
    $("#modal_update_button").click(function () {
        //1.前端校验name是否符合正则表达式
        var updateName = $("#updateName").val();
        var regName = 	/^[\u4E00-\u9FA5]{1,10}$/;
        if(!regName.test(updateName)){
            show_validator_msg("#updateName","error","姓名必须是字母或文字");
            return false;
        }else{
            show_validator_msg("#updateName","success","");
        }
        //2.发送ajax请求进行update
        $.ajax({
            url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
            type:"PUT",
            /*
            1.前端POST请求允许PUT请求接受+"&_method=PUT"
            type:"POST",
            data:$("#form_update").serialize()+"&_method=PUT",
            2.后端转化
            ajax可以直接发送PUT请求
            springMVC配置HttpPutFormContentFilter过滤器
            */
            data:$("#form_update").serialize(),
            success:function (result) {
                // alert(result.msg);
                //1.关闭模态框
                $("#update_Modal").modal('hide');
                //2.跳转之前点进来的页码，更新数据
                to_page(currentpage);
            }
        })
    })


    //单个删除delete_single
    $(document).on("click",".delete_btn",function () {
        //1.弹出是否删除确认对话框
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        if(confirm("确认删除【"+empName+"】吗？")){
            //2.点击确认之后===>发送ajax请求删除数据库数据
            $.ajax({
                url:"${APP_PATH}/emp/"+$(this).attr("delete_id"),
                type:"DELETE",
                success:function (result) {
                    //成功之后，我们需要删除这个DOM节点
                    alert("删除成功");
                    to_page(currentpage);
                }
            })
        }
    })

    //1.完成父check选中，子check全选/全不选功能
    $("#check_all").click(function () {
        /*
        * 1.必须用class去找，class允许重复，可以找到所有的节点
        * 2.不能用id去找，多个重名id，只会找到第一个
        * 3.当第一行的按钮选中时:设置当前页的下面的check都被选中
        * */
        $(".check_item").prop("checked",$(this).prop("checked"));
    })
    //2.当子check全部选中时，另父check被选中
    $(document).on("click",".check_item",function () {
        //选满的话，就使最上面的按钮点亮
        var flag=$(".check_item:checked").length==$(".check_item").length;
        $("#check_all").prop("checked",flag);
    })
    
    //delete点击批量删除选中的项目
    $("#delete_all").click(function () {
        var idsstr="";
        //找到所有被选中的check
        $.each($(".check_item:checked"),function () {
            //以-分割多个id，以实现批量删除
            idsstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
        })
        //去除最后一个id后面多余的-
        idsstr = idsstr.substring(0,idsstr.length-1);
        //弹出确定框
        if(confirm("是否删除所选记录？")){
            $.ajax({
                url:"${APP_PATH}/emps/"+idsstr,
                type:"DELETE",
                success:function (result) {
                    //删除成功
                    //跳到之前操作的页面
                    to_page(currentpage);
                }
            })
        }
    })

</script>
</body>
</html>
