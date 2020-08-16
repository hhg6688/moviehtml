<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<script type="text/javascript"  src="./js/bootstrap-3.4.1-dist/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="./js/zTree/js/jquery.ztree.all.min.js"></script>
<link rel="stylesheet" type="text/css" href="./js/zTree/css/zTreeStyle/zTreeStyle.css">
<script type="text/javascript"  src="./js/bootstrap-3.4.1-dist/js/bootstrap.min.js"></script>
<link rel="stylesheet"  href="./js/bootstrap-3.4.1-dist/css/bootstrap.min.css">
<script type="text/javascript"  src="./js/bootstrap-datetimepicker/js/moment-with-locales.js"></script>
<script type="text/javascript"  src="./js/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
<link rel="stylesheet"  href="./js/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css">
<script type="text/javascript"  src="./js/bootstrap-fileinput/js/fileinput.min.js"></script>
<script type="text/javascript"  src="./js/bootstrap-fileinput/js/locales/zh.js"></script>
<link rel="stylesheet"  href="./js/bootstrap-fileinput/css/fileinput.min.css">
<script type="text/javascript"  src="./js/bootstrap-3.4.1-dist/js/bootbox.min.js"></script>
<script type="text/javascript"  src="./js/bootstrap-3.4.1-dist/js/bootbox.locales.min.js"></script>
<script type="text/javascript" src="./js/bootstrapValidator/js/bootstrapValidator.min.js"></script>
<link rel="stylesheet" href="./js/bootstrapValidator/css/bootstrapValidator.min.css">
<script type="text/javascript"  src="./js/DataTables/js/jquery.dataTables.js"></script>
<link rel="stylesheet"  href="./js/DataTables/css/jquery.dataTables.min.css">
<script type="text/javascript"  src="./js/date-format.js"></script>

<body>
<div class="panel panel-primary">
    <div class="panel-heading">
        <h3 class="panel-title">
            查询条件
        </h3>
    </div>
    <div class="panel-body">
        <form id = "queryForm" class="form-horizontal" role="form">
            <div class="container">
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="col-sm-3 control-label">电影名称</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" name = "mName" id="mName">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="col-sm-3 control-label">汽车</label>
                            <div class="col-sm-9">
                                <select id="queryHome" class="form-control">
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6" style="text-align:center">
                        <button type="button" class="btn btn-primary" onclick="search()">
                            <span class="glyphicon glyphicon-search"></span>&nbsp;查询
                        </button>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <button type="reset" class="btn btn-danger">
                            <span class="glyphicon glyphicon-refresh"></span>&nbsp;重置
                        </button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>


<%--展示面板--%>
<div class="panel panel-primary">
    <div class="panel-heading">
        <h3 class="panel-title">展示页面</h3>
    </div>
    <div class="panel-body">
        <div>
            <button class="btn btn-primary btn-sm" onclick="toAdd()">
                <span class="glyphicon glyphicon-plus"></span>新增
            </button>
        </div>
        <table id="carTable" class="table table-striped table-bordered table-hover table-condensed">
            <thead>
            <tr>
                <th>电影名称</th>
                <th>放映室</th>
                <th>放映时间</th>
                <th>余票数量</th>
                <th>票面价格</th>
                <th>电影海报</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
</div>
<!--新增DIV-->
<div id="addDiv" style="display: none">
    <!--新增表单-->
    <form id="addForm" class="form-horizontal">
        <div class="form-group">
            <label class="col-sm-2 control-label">电影名称</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" name="mName">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">放映室</label>
            <div class="col-sm-10">
                <select id="addHome" class="form-control">
                </select>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">放映时间</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="showTime">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">余票数量</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="mNum">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">票面价格</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="price" >
            </div>
        </div>
        <div class="row form-group">
            <label class="col-md-2 control-label">电影海报:</label>
            <div class="col-md-8" >
                <input id="avatarPath" type="hidden">
                <input type="file" multiple class="form-control" name="image" id="image">
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-offset-10 col-sm-10">
                <button id = "addButton" type="button" onclick="addData()" class="btn btn-success">提交</button>
            </div>
        </div>
    </form>
</div>
</body>


<script>

    $(function () {
        inItSelectHome();
        inItSelectMovie();
    })

    function search(){
        dataTable.ajax.reload();
    }
    var dataTable;
    function inItSelectMovie() {
        dataTable= $('#carTable').DataTable( {


           /* createdRow: function( row, data, dataIndex ) {
                if ( data.num == 0) {
                    $('td', row).css("background", "red");
                }
            },*/


            aLengthMenu:[3,5,10],
            serverSide: true,
            searching: false,
            ordering:  false,
            //async:false,
            "oLanguage": {
                "sLengthMenu": "每页显示 _MENU_ 条记录",
                "sZeroRecords": "抱歉， 没有找到",
                "sInfo": "从 _START_ 到 _END_ /共 _TOTAL_ 条数据",
                "sInfoEmpty": "没有数据",
                "sInfoFiltered": "(从 _MAX_ 条数据中检索)",
                "oPaginate": {
                    "sFirst": "首页",
                    "sPrevious": "前一页",
                    "sNext": "后一页",
                    "sLast": "尾页"
                }
            },
            "fnRowCallback": function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
                //改行满足的条件
                var state = aData.mNum;
//alert(state)
                if(state == 0){
                    //设置满足条件行的背景颜色
                    $(nRow).css("background", "red");
                    //设置满足条件行的字体颜色
                    $(nRow).css("color", "black");
                }
            },
            ajax:{
                data:function (m) {
                    m.mName = $("#queryForm [name=mName]").val();
                    m.showHome=$("#queryForm #queryHome").val();
                },
                url:"http://localhost:8080/MovieController/selectMovieAll",
                dataSrc: 'data',
            },
            columns: [
                { data: 'mName' },
                { data: 'showHome',"render":function (data) {
                        for (var i = 0; i < areaData.length; i++) {
                            if(data == areaData[i].hId){
                                return areaData[i].hName;
                            }
                        }
                    }
                },
                { data: 'showTime',render:function (data, type, row, meta) {
                        var date=new Date(data);
                        return date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate() ;
                    }
                },
                { data: 'mNum'},
                { data: 'price'},
                {
                    data: 'imgUrl',render:function (data) {
                        return '<img src="' + data + '" alt=""  width="50px",height="50px">'
                    }
                },
                {
                    data: "mId","render": function (data, type, row) {
                        if(row.mNum==0){
                            return"已售完"
                        }
                        return '<div class="btn-group btn-group-xs">' +
                            '<button type="button" class="btn btn-danger" onclick="updateMovie(' + data + ')"><span class="glyphicon glyphicon-plus"></span>&nbsp;购买</button>' +
                            '</div>';
                    }
                }
            ]
        } )
    }

    var areaData;
    function inItSelectHome() {
        $.post({
            url:"http://localhost:8080/HomeController/selectMovieHome",
            dataType:"json",
            async:false,
            success:function (result) {
                areaData = result.data;
                if (typeof(areaData) =='string') {
                    areaData =JSON.parse(areaData);
                }
                var optionsHTML = "<option value='-1'>请选择</option>";
                for(var i = 0 ; i < areaData.length ; i ++ ){
                    optionsHTML += "<option value='" + areaData[i].hId + "'>" + areaData[i].hName + "</option>";
                }
                $("#queryHome").append(optionsHTML);
                $("#addHome").append(optionsHTML);
            },
            error:function () {
                alert("下拉框数据请求失败");
            }
        });
    }
var addBox;
    function toAdd() {
        var addDiv = $("#addDiv").html();
        addBox = bootbox.dialog({
            title:"新增",
            message:addDiv,
        });
        initAddFileIput();
        //时间插件
        $("#showTime",addBox).datetimepicker({
            //设置日期格式
            format:"YYYY-MM-DD",
            locale:"zh-CN",
            showClear:true
        })
    }

    function initAddFileIput(){
        $("#addForm #image").fileinput({
            language:"zh",
            previewFileType:"text,image",//设置需要预览的文件类型
            uploadClass:"btn btn-danger",//上传按钮的样式
            allowedFileTypes:["image","text"],////允许上传文件的类型
            allowedFileExtensions:["jpg","gif","txt","pdf"],//允许上传文件的后缀名
            maxFileSize:1024*20, //单位为kb 如果为0则不限制文件大小
            maxFileCount:5, //最大上传文件的数量限制
            uploadUrl:"http://localhost:8080/MovieController/uploadImage",
        })

        $("#addForm #image").on("fileuploaded",function(event,data,previewId,index){
            var file = data.response;
            if(file.message==1){
                $("#addForm #avatarPath").val($("#addForm #avatarPath").val()+","+file.fileName);
            }
        });
    }

    function addData() {
        var mName=$("[name=mName]",addBox).val();
        var  showTime = $("#showTime",addBox).val();
        var showHome = $("#addHome",addBox).val();
        var mNum = $("#mNum",addBox).val();
        var price = $("#price",addBox).val();
        var imgUrl =$("#avatarPath",addBox).val().substring(1);
        $.post({
            url:"http://localhost:8080/MovieController/addMovie",
            dataType:"json",
            data:{
                "mName":mName,
                "showTime":showTime,
                "showHome":showHome,
                "mNum":mNum,
                "price":price,
                "imgUrl":imgUrl,
            },
            success:function(result){
                if(result.code==200){
                    alert("新增成功");
                    search();
                    addBox.modal("hide");
                }
            },
            error:function () {
                alert("新增失败");
            }
        });
    }
    
    
    
    function updateMovie(id) {
        $.post({
            url:"http://localhost:8080/MovieController/updateMovie",
            dataType:"json",
            data:{
                "id":id,
            },
            success:function(result){
                if(result.code==200){
                    alert("购买成功");
                    search();
                    addBox.modal("hide");
                }
            },
            error:function () {
                alert("购买失败");
            }
        });
    }
</script>



</html>
