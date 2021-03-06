<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+
            request.getServerPort()+request.getContextPath();
%>
<%
    String Path = request.getScheme()+"://"+"www.nginx.com";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="<%=Path%>/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<link href="<%=Path%>/jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="<%=Path%>/jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="<%=Path%>/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=Path%>/jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="<%=Path%>/jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=Path%>/jquery/bs_pagination/en.js"></script>
<script type="text/javascript" src="<%=Path%>/jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
<script type="text/javascript" src="<%=Path%>/jquery/layui/layui.js"></script>
    <style>
        .a-upload{
            padding: 4px 10px;
            /*height: 34px;*/
            line-height: 28px;
            position: relative;
            cursor: pointer;
            color: #fff;
            background-color: #286090;
            border-color: #204d74;
            border-radius: 4px;
            overflow: hidden;
            display: inline-block;
            *display: inline;
            *zoom: 1;
        }
        .a-upload input{
            position: absolute;
            font-size: 100px;
            right: 0;
            top: 0;
            opacity: 0;
            filter: alpha(opacity=0);
            cursor: pointer
        }
        .a-upload:hover{
            color: #FFFFFF;
            background: #337ab7;
            border-color: #204d74;
            text-decoration: none;
        }
    </style>
</head>
<body>


    <!-- ???????????? -->
    <div class="modal fade" id="myInformation" role="dialog">
        <div class="modal-dialog" role="document" style="width: 30%;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">??</span>
                    </button>
                    <h4 class="modal-title">????????????</h4>
                </div>
                <div class="modal-body">
                    <div style="position: relative; left: 40px;">
                        ?????????<b id="b1"></b><br><br>
                        ???????????????<b id="b2"></b><br><br>
                        ???????????????<b id="b3"></b><br><br>
                        ?????????<b id="b4"></b><br><br>
                        ???????????????<b id="b5"></b><br><br>
                        ????????????IP???<b id="b6"></b>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">??????</button>
                </div>
            </div>
        </div>
    </div>

    <!-- ??????????????????????????? -->
    <div class="modal fade" id="editPwdModal" role="dialog">
        <div class="modal-dialog" role="document" style="width: 70%;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">??</span>
                    </button>
                    <h4 class="modal-title">????????????</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" role="form">
                        <img id="photo" type="hidden"/>
                        <div class="form-group">
                            <label for="oldPwd" class="col-sm-2 control-label">?????????</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="password" class="form-control" id="oldPwd" style="width: 200%;">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="newPwd" class="col-sm-2 control-label">?????????</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="password" class="form-control" id="newPwd" style="width: 200%;">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="confirmPwd" class="col-sm-2 control-label">????????????</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="password" class="form-control" id="confirmPwd" style="width: 200%;">
                            </div>
                        </div>
                        <%--????????????--%>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">????????????</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <a href="javascript:;" class="a-upload mr10"><input type="file" name="img" id="img">????????????????????????</a>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">??????</button>
                    <button type="button" class="btn btn-primary" data-dismiss="modal" id="button" >??????</button>
                </div>
            </div>
        </div>
    </div>

    <!-- ??????????????????????????? -->
    <div class="modal fade" id="exitModal" role="dialog">
        <div class="modal-dialog" role="document" style="width: 30%;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">??</span>
                    </button>
                    <h4 class="modal-title">??????</h4>
                </div>
                <div class="modal-body">
                    <p>??????????????????????????????</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">??????</button>
                    <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="window.location.href='<%=basePath%>/settings/user/logOut';">??????</button>
                </div>
            </div>
        </div>
    </div>

    <!-- ?????? -->
    <div id="top" style="height: 50px; background-color: #3C3C3C; width: 100%;">
        <div style="position: absolute; top: 5px; left: 0px; font-size: 30px; font-weight: 400; color: white; font-family: 'times new roman'">CRM &nbsp;<span style="font-size: 12px;">&copy;2021&nbsp;????????????</span></div>
        <div style="position: absolute; top: 15px; right: 15px;">
            <ul>
                <li class="dropdown user-dropdown">
                    <a href="javascript:void(0)" style="text-decoration: none; color: white;" class="dropdown-toggle" data-toggle="dropdown">
                        <img id="userPhoto1"  style="display:none;border-radius: 100%;width: 30px;height: 30px" />
                    </a>
                    <c:choose>
                        <c:when test="${not empty sessionScope.user.img}">
                            <a href="javascript:void(0)" style="text-decoration: none; color: white;" class="dropdown-toggle" data-toggle="dropdown">
                                <img id="userPhoto" src="${sessionScope.user.img}" style="border-radius: 100%;width: 30px;height: 30px" /> ${sessionScope.user.name} <span class="caret"></span>
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="javascript:void(0)" style="text-decoration: none; color: white;" class="dropdown-toggle" data-toggle="dropdown">
                                <span class="glyphicon glyphicon-user" id="span"></span> ${sessionScope.user.name} <span class="caret"></span>
                            </a>
                        </c:otherwise>
                    </c:choose>

                    <ul class="dropdown-menu">
                        <li><a href="<%=basePath%>/toView/workbench/index"><span class="glyphicon glyphicon-home"></span> ?????????</a></li>
                        <li><a href="<%=basePath%>/toView/settings/index"><span class="glyphicon glyphicon-wrench"></span> ????????????</a></li>
                        <li><a href="javascript:void(0)" data-toggle="modal" data-target="#myInformation"><span class="glyphicon glyphicon-file" id="mydata"></span> ????????????</a></li>
                        <li><a href="javascript:void(0)" data-toggle="modal" data-target="#editPwdModal"><span class="glyphicon glyphicon-edit"></span> ????????????</a></li>
                        <li><a href="javascript:void(0);" data-toggle="modal" data-target="#exitModal"><span class="glyphicon glyphicon-off"></span> ??????</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
	
	<!-- ??????????????????????????? -->
	<div class="modal fade" id="createDeptModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 80%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">??</span>
					</button>
					<h4 class="modal-title" id="myModalLabel"><span class="glyphicon glyphicon-plus"></span> ????????????</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" id="deptForm" role="form">
						<div class="form-group">
							<label for="create-code" class="col-sm-2 control-label">??????<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-code" style="width: 200%;" placeholder="????????????????????????????????????">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-name" class="col-sm-2 control-label">??????</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-name" style="width: 200%;">
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-sm-2 control-label">?????????</label>
							<div class="col-sm-10" style="width: 300px;">
                                <select class="form-control" name="owner" id="create-clueOwner">
                                    <c:forEach var="user" items="${applicationScope.users}">
                                        <option value="${user.id}">${user.name}</option>
                                    </c:forEach>
                                </select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-phone" class="col-sm-2 control-label">??????</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-phone" style="width: 200%;">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-describe" class="col-sm-2 control-label">??????</label>
							<div class="col-sm-10" style="width: 55%;">
								<textarea class="form-control" rows="3" id="create-describe"></textarea>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">??????</button>
					<button type="button" class="btn btn-primary" id="addDept" data-dismiss="modal">??????</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- ??????????????????????????? -->
	<div class="modal fade" id="editDeptModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 80%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">??</span>
					</button>
					<h4 class="modal-title" id="myModalLabel1"><span class="glyphicon glyphicon-edit"></span> ????????????</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" role="form">
					
						<div class="form-group">
							<label for="create-code" class="col-sm-2 control-label">??????<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-code" style="width: 200%;" placeholder="??????????????????????????????">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-name" class="col-sm-2 control-label">??????</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-name" style="width: 200%;" >
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-sm-2 control-label">?????????</label>
							<div class="col-sm-10" style="width: 300px;">
                                <select class="form-control" name="owner" id="edit-clueOwner">
                                    <c:forEach var="user" items="${applicationScope.users}">
                                        <option value="${user.id}">${user.name}</option>
                                    </c:forEach>
                                </select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-phone" class="col-sm-2 control-label">??????</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-phone" style="width: 200%;" >
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-describe" class="col-sm-2 control-label">??????</label>
							<div class="col-sm-10" style="width: 55%;">
								<textarea class="form-control" rows="3" id="edit-describe"></textarea>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">??????</button>
					<button type="button" class="btn btn-primary" onclick="updateDept()">??????</button>
				</div>
			</div>
		</div>
	</div>
	
	<div style="width: 95%">
		<div>
			<div style="position: relative; left: 30px; top: -10px;">
				<div class="page-header">
					<h3>????????????</h3>
				</div>
			</div>
		</div>
		<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;left: 30px; top:-30px;">
			<div class="btn-group" style="position: relative; top: 18%;">
			  <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#createDeptModal"><span class="glyphicon glyphicon-plus"></span> ??????</button>
			  <button type="button" class="btn btn-default" id="editDept"><span class="glyphicon glyphicon-edit"></span> ??????</button>
			  <button type="button" class="btn btn-danger" id="deleteDept"><span class="glyphicon glyphicon-minus"></span> ??????</button>
              <button type="button" class="btn btn-success" id="exportExcel"><span class="glyphicon glyphicon-circle-arrow-down"></span> ????????????</button>

            </div>
		</div>
		<div style="position: relative; left: 30px; top: -10px;">
			<table class="table table-hover">
				<thead>
					<tr style="color: #B3B3B3;">
						<td><input type="checkbox" id="father"/></td>
						<td>??????</td>
						<td>??????</td>
						<td>?????????</td>
						<td>??????</td>
						<td>??????</td>
					</tr>
				</thead>
				<tbody id="tbody">
					<%--<tr class="active">
						<td><input type="checkbox" class="sun" /></td>
						<td>1110</td>
						<td>?????????</td>
						<td>??????</td>
						<td>010-84846005</td>
						<td>description info</td>
					</tr>--%>
				</tbody>
			</table>
		</div>
		
		<div style="height: 50px; position: relative;top: 0px; left:30px;">
            <div id="DeptPage"></div>
		</div>
			
	</div>
	
</body>
</html>

<script>
    //??????????????????????????????
    $("#oldPwd").blur(function () {
        if ($("#oldPwd").val()==""){
            layer.alert("????????????????????????", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        }

        $.ajax({
            url:"<%=basePath%>/settings/user/oldPassword",
            data:{
                'loginPwd': $("#oldPwd").val()
            },
            type: "post",
            dataType:"json",
            success: function (data) {

                if (!data.ok) {
                    layer.alert(data.message, {
                        icon: 5,
                        skin: 'layer-ext-demo'
                    });
                }
            }
        });
    });

    //????????????
    $("#button").click(function () {
        var confirmPwd = $("#confirmPwd").val();
        var newPwd = $("#newPwd").val();

        if (confirmPwd == "" || newPwd==""){

            layer.alert("??????????????????!", {
                icon: 4,
                skin: 'layer-ext-demo'});
            $.ajax({
                url:"<%=basePath%>/setting/user/update",
                data:{
                    'img' : $('#photo').val()
                },
                type: "post",
                dataType:"json",
                success: function (data) {
                    layer.alert(data.message, {
                        icon: 5,
                        skin: 'layer-ext-demo'});
                }
            });
            //    ?????????????????????????????????????????????
        } else if (confirmPwd != "" && newPwd !="" &&confirmPwd == newPwd){

            $.ajax({
                url:"<%=basePath%>/setting/user/update",
                data:{
                    'loginPwd': confirmPwd,
                    'img' : $('#photo').val(),
                    'id':'${sessionScope.user.id}'
                },
                type: "post",
                dataType:"json",
                success: function (data) {
                    if (!data.ok) {
                        layer.alert(data.message, {
                            icon: 5,
                            skin: 'layer-ext-demo'
                        });
                    }else {
                        layer.alert(data.message, {
                            icon: 5,
                            skin: 'layer-ext-demo'});

                        <%--window.location.href = "<%=basePath%>/toView/login";--%>
                        window.location.href = "<%=basePath%>/toView/login";
                    }
                }
            });
        }else {
            layer.alert("????????????????????????????????????????????????", {
                icon: 5,
                skin: 'layer-ext-demo'});
        }
    });

    //??????????????????
    $("#img").change(function () {
        $.ajaxFileUpload({
            url:"<%=basePath%>/setting/user/FileUpload",
            dataType:"json",
            fileElementId:"img",
            success:function (data) {
                //???????????????if
                if (!data.ok) {
                    layer.alert(data.message, {
                        icon: 5,
                        skin: 'layer-ext-demo'
                    });

                }else {
                    layer.alert(data.message, {
                        icon: 6,
                        skin: 'layer-ext-demo'
                    });
                    $("#photo").val(data.t);

                    $("#userPhoto").css('display','none');
                    $("#userPhoto1").css('display','inline').prop('src',data.t);
                    $("#span").css('display','none');
                }
            }
        });
        return false;
    });
    //??????????????????
    $(function() {
        $.ajax({
            url:"<%=basePath%>/setting/user/mydata",
            type:"get",
            dataType:"json",
            success:function (data) {
                $("#b1").html(data.name);
                $("#b2").html(data.loginAct);
                $("#b3").html(data.deptno);
                $("#b4").html(data.email);
                $("#b5").html(data.expireTime);
                $("#b6").html(data.allowIps);
            }
        });
    });

    var rsc_bs_pag = {
        go_to_page_title: 'Go to page',
        rows_per_page_title: 'Rows per page',
        current_page_label: 'Page',
        current_page_abbr_label: 'p.',
        total_pages_label: 'of',
        total_pages_abbr_label: '/',
        total_rows_label: 'of',
        rows_info_records: 'records',
        go_top_text: '??????',
        go_prev_text: '?????????',
        go_next_text: '?????????',
        go_last_text: '??????'};
    refresh(1,3);
    //??????????????????
    function refresh (page,pageSize){
        $.ajax({
            url:"<%=basePath%>/settings/dept/selectAll",
            type:"get",
            dataType:"json",
            data:{
                'page':page,
                'pageSize':pageSize
            },
            success:function (data) {
                //???????????????????????????????????????????????????
                $('#father').removeAttr('checked');
                $("#tbody").html("");
                var depts = data.list;
                for (var i = 0; i < depts.length; i++){
                    var dept = depts[i];
                    $("#tbody").append("<tr class=\"active\">\n" +
                        "\t\t\t\t\t\t<td><input type=\"checkbox\" onclick='checkedes()' class=\"sun\" value='"+dept.id+"' /></td>\n" +
                        "\t\t\t\t\t\t<td>"+dept.id+"</td>\n" +
                        "\t\t\t\t\t\t<td>"+dept.name+"</td>\n" +
                        "\t\t\t\t\t\t<td>"+dept.owner+"</td>\n" +
                        "\t\t\t\t\t\t<td>"+dept.phone+"</td>\n" +
                        "\t\t\t\t\t\t<td>"+dept.description+"</td>\n" +
                        "\t\t\t\t\t</tr>")
                }
                $("#DeptPage").bs_pagination({
                    currentPage: data.pageNum, // ??????
                    rowsPerPage: data.pageSize, // ???????????????????????????
                    maxRowsPerPage: 20, // ?????????????????????????????????
                    totalPages:data.pages, // ?????????
                    totalRows:data.total, // ???????????????
                    visiblePageLinks: 3, // ??????????????????
                    showGoToPage: true,
                    showRowsPerPage: true,
                    showRowsInfo: true,
                    showRowsDefaultInfo: true,
                    onChangePage: function (event, obj) {
                        //??????????????????
                        refresh(obj.currentPage,obj.rowsPerPage);
                    }
                });
            }
        });
    }


    //????????????????????????
    $("#father").click(function () {
        $(".sun").prop("checked",$(this).prop("checked"));

    });
    function checkedes() {
        //???????????????????????????
        var length = $(".sun").length;
        //?????????????????????
        var checkedLength = $(".sun:checked").length;

        if (length == checkedLength){
            $("#father").prop("checked",true);
        } else {
            $("#father").prop("checked",false);
        }
    }


    //??????
    $("#addDept").click(function () {
        if ($("#create-code").val() == ""){
            layer.alert("??????????????????!", {
                icon: 5});
        } else if ($("#create-name").val() == ""){
            layer.alert("????????????????????????!", {
                icon: 5});
        } else if ($("#create-manager").val() == ""){
            layer.alert("?????????????????????!", {
                icon: 5});
        } else if ($("#create-phone").val() == ""){
            layer.alert("?????????????????????!", {
                icon: 5});
        }else if ($("#create-describe").val() == ""){
            layer.alert("??????????????????!", {
                icon: 5});
        }else {
            $.ajax({
                url:"<%=basePath%>/settings/dept/addDept",
                data:{
                    'id':$("#create-code").val(),
                    'name':$("#create-name").val(),
                    'owner':$("#create-clueOwner").val(),
                    'phone':$("#create-phone").val(),
                    'description':$("#create-describe").val()
                },
                dataType:"json",
                type:"post",
                success:function (data) {
                    if (data.ok){
                        layer.alert(data.message, {
                            icon: 6});
                        //??????????????????
                        $("#deptForm")[0].reset();
                        refresh(1,3);
                    } else {
                        layer.alert(data.message, {
                            icon: 5});
                    }

                }
            })
        }
    });

    //??????
    $("#editDept").click(function () {
        var checkedLenth = $(".sun:checked").length;
        if (checkedLenth > 1){
            layer.alert("???????????????????????????????????????!", {
                icon: 5});
        } else if (checkedLenth < 1){
            layer.alert("???????????????????????????!", {
                icon: 5});
        } else {
            $("#editDeptModal").modal("show");
            var id = $(".sun:checked")[0].value;
           $.ajax({
               url:"<%=basePath%>/settings/dept/selectDept",
               data:{
                   'id':id
               },
               type:"post",
               dataType:"json",
               success:function (data) {
                   $("#edit-code").val(data.id);
                   $("#edit-name").val(data.name);
                   $("#edit-clueOwner").val(data.owner);
                   $("#edit-phone").val(data.phone);
                   $("#edit-describe").val(data.description);
               }
           });
       }
    });

    //???????????????id="updateDept"
   function updateDept() {
       if ($("#edit-code").val() == ""){
           layer.alert("??????????????????!", {
               icon: 5});
       } else if ($("#edit-name").val() == ""){
           layer.alert("????????????????????????!", {
               icon: 5});
       } else if ($("#edit-clueOwner").val() == ""){
           layer.alert("?????????????????????!", {
               icon: 5});
       } else if ($("#edit-phone").val() == ""){
           layer.alert("?????????????????????!", {
               icon: 5});
       }else if ($("#edit-describe").val() == ""){
           layer.alert("??????????????????!", {
               icon: 5});
       }else {
           $.ajax({
               url: "<%=basePath%>/settings/dept/updateDept",
               data: {
                   'id': $("#edit-code").val(),
                   'name': $("#edit-name").val(),
                   'owner': $("#edit-clueOwner").val(),
                   'phone': $("#edit-phone").val(),
                   'description': $("#edit-describe").val()
               },
               type: "post",
               dataType: "json",
               success: function (data) {
                   if (data.ok) {
                       layer.alert(data.message, {
                           icon: 6
                       });
                       $("#editDeptModal").modal("hide");
                       //????????????
                       refresh(1, 3);
                   } else {
                       layer.alert(data.message, {
                           icon: 5
                       });
                   }
               }
           });
       }
   }

   //???????????????????????????
    $("#deleteDept").click(function () {
       var checkedLength = $(".sun:checked").length;
        if (checkedLength == 0) {
            layer.alert("???????????????????????????????????????!", {
                icon: 5
            });
        }else {
            layer.confirm('???????????????' + checkedLength + '???????????????', {
                btn: ['??????', '??????']
                // ??????
            }, function () {
                var ids = [];
                $(".sun:checked").each(function () {
                    ids.push($(this).val());
                });
                $.ajax({
                  url:"<%=basePath%>/settings/dept/deleteDept",
                  data:{
                      'ids':ids.join()
                  },
                    type:"post",
                    dataType:"json",
                    success:function (data) {
                        if (data.ok) {
                            layer.alert(data.message, {
                                icon: 6,
                                skin: 'layer-ext-demo'
                            });
                            refresh(1, 3);
                        } else {
                            layer.alert(data.message, {
                                icon: 5,
                                skin: 'layer-ext-demo'
                            });
                        }
                    }
                })

            });

        }
    });


    //????????????
    $("#exportExcel").click(function () {

        window.location.href = "<%=basePath%>/workbench/Dept/exportExcel";
    });





</script>