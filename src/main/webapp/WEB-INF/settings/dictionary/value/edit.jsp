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
    <script type="text/javascript" src="<%=Path%>/jquery/layui/layui.js"></script>
</head>
<body>

	<div style="position:  relative; left: 30px;">
		<h3>修改字典值</h3>
	  	<div style="position: relative; top: -40px; left: 70%;">
			<button type="button" id="updateDicValue" class="btn btn-primary">更新</button>
			<button type="button" class="btn btn-default" onclick="window.history.back();">取消</button>
		</div>
		<hr style="position: relative; top: -40px;">
	</div>
	<form class="form-horizontal" role="form">
					
		<div class="form-group">
			<label for="edit-dicTypeCode" class="col-sm-2 control-label">字典类型编码</label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="edit-dicTypeCode" style="width: 200%;" readonly>
			</div>
		</div>
		
		<div class="form-group">
			<label for="edit-dicValue" class="col-sm-2 control-label">字典值<span style="font-size: 15px; color: red;">*</span></label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="edit-dicValue" style="width: 200%;" >
			</div>
		</div>
		
		<div class="form-group">
			<label for="edit-text" class="col-sm-2 control-label">文本</label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="edit-text" style="width: 200%;" >
			</div>
		</div>
		
		<div class="form-group">
			<label for="edit-orderNo" class="col-sm-2 control-label">排序号</label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="edit-orderNo" style="width: 200%;">
			</div>
		</div>
	</form>
	
	<div style="height: 200px;"></div>
</body>
</html>

<script>

    //修改的查询的方法
    $.ajax({
        url:"<%=basePath%>/settings/DicValue/selectValue",
        data:{
           'id':'${requestScope.id}'
        },
        type:"post",
        dataType:"json",
        success:function (data) {
            $("#edit-dicTypeCode").val(data.typeCode);
            $("#edit-dicValue").val(data.value);
            $("#edit-text").val(data.text);
            $("#edit-orderNo").val(data.orderNo);

        }
    });


    $("#updateDicValue").click(function () {
        if ($("#edit-dicValue").val() == ""){
            layer.alert("字典值不能为空", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        }else if ($("#edit-text").val() == ""){
            layer.alert("文本不能为空", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        }else if ($("#edit-orderNo").val() == ""){
            layer.alert("排序号不能为空", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        } else {
        $.ajax({
            url:"<%=basePath%>/settings/dicValue/updateDicValue",
            data:{
            'value':$("#edit-dicValue").val(),
             'text':$("#edit-text").val(),
             'orderNo':$("#edit-orderNo").val(),
                'id':'${requestScope.id}'
            },
            type:"post",
            dataType:"json",
            success:function (data) {
                if (data.ok){
                    layer.alert(data.message, {
                        icon: 6,
                        skin: 'layer-ext-demo'
                    });
                    //延迟跳转页面
                    window.setTimeout("window.location='<%=basePath%>/toView/settings/dictionary/value/index'",2000);

                    //刷新上页面
                    // window.opener.location.reload();
                } else {
                    layer.alert(data.message, {
                        icon: 5,
                        skin: 'layer-ext-demo'
                    });
                }
            }
        });
        }
    })




</script>