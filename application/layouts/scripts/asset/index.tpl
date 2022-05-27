<style>
    th {
        text-align: center;
    }
    td {
        text-align: center;
    }
    .delete-button{
        color: #337ab7;
        background: none;
        border: none;
    }
    .update-button{
        color: #337ab7;
        background: none;
        border: none;
    }
    table{
        table-layout: fixed;
    }
    td {
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }
</style>
<section>
    {$stt=1}
    <header class="panel-heading">
        <div class="col-sm-4">
            <ul style="display: flex; list-style: none;" class="crumb">
                <li><a href="/">Trang chủ</a></li>
                <li>Quản lý tài sản</li>
            </ul>
        </div>
        <div class="col-sm-4">
            Quản lý tài sản
        </div>
        <div class="col-sm-1">
        </div>
        {if $smarty.session.role_id==2 }
            <div class="col-sm-3">
                <div class="add-data" >
                    <span><button style="margin-left: 10px;" class="btn btn-success disabled-btn" class="card-title" data-toggle="modal" data-target="#multi-export-user" id="borrow-btn" disabled>CHO MƯỢN</button></span>
                    <span><form style="display: inline-block; margin-left: 10px;" method="post" action="/asset/inventory"><input type="hidden" name="asset_id" id="inventory_asset_id"><input type="submit" class="btn btn-primary disabled-btn" value="KIỂM KÊ" id="btn-inventory" disabled></form><span>
                    <a style="margin-left: 10px;" href="/asset/add" class="btn btn-success" class="card-title" data-toggle="modal"> Thêm</a>
                    <span style="margin-left: 10px;"><button class="btn btn-danger disabled-btn" data-toggle="modal" data-target="#multi-delete-data" id="delete-btn" disabled>XÓA</button></span>
                </div>
            </div>
        {/if}
    </header>
    <div class="modal fade xoa-modal" id="multi-export-user" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="margin-top: 100px">
        <div class="modal-dialog" role="document">
            <form class="form-horizontal bucket-form" method="POST">
                <div class="modal-content">
                    <div class="modal-header">
                        <b style="font-size: 17px">Chọn người dùng</b>
                    </div>
                    <div class="modal-body" style="font-size: 17px; margin-top: 15px; text-align: center">
                        <div style="margin-bottom: 10px">
                            <div class="form-group">
                                <label class="col-sm-3 control-label">Họ tên</label>
                                <div class="col-sm-7">
                                    <select class="form-control" name="borrow_user_id" id="borrow_user_id">
                                        <option disabled selected value>Nhập người dùng</option>
                                        {foreach $user_list as $key=>$value}
                                            <option value="{$value.user_id}">{$value.name}</option>
                                        {/foreach}
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">Ngày mượn</label>
                                <div class="col-sm-7">
                                    <input class="form-control" type="datetime-local" name="borrow_date" id="borrow_date" value="{date("Y-m-d")}T{date("H:i")}" max="{date("Y-m-d")}T{date("H:i")}">
                                    <div id="alert" style="color: #ff0000; font-size: 13px; margin:10px; text-align: left"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-secondary" type="button" data-dismiss="modal">Hủy</button>
                        <a class="btn btn-primary"  id="btn_multi_export_user">Chọn</a>
                    </div>
                </div>
            </form>
        </div>
        <div class="card bg-success text-white shadow" style="display: none; position: fixed; bottom: 10px; left: 10px; border: none" id="xoahs_thanhcong">
            <div class="card-body" style="align-items: center; display: flex; padding: 1rem">
                abc
                <i class="fas fa-check-circle fa-2x" style="color: white; margin-right: 5px"></i>
            </div>
        </div>
    </div>
    <div class="table-agile-info">
        <div class="table-responsive">
            <table id="example" class="table table-striped table-bordered" style="width:100%">
                <thead>
                <tr>
                    <th style="width:60px;" class="no-sort">
                        <input type="checkbox" class="check-control" id="all-checked">
                    </th>
                    <th style="color:black">Tên</th>
                    <th style="color:black; width: 180px">Mã</th>
                    <th style="color:black; width: 270px">Cấu hình</th>
                    <th style="color:black; width: 160px;">Tình trạng</th>
                    <th style="color:black; width: 160px;">Trạng thái</th>
                    <th style="color:black" class="no-sort">Thao tác</th>
                </tr>
                </thead>
                <tbody>
                <div id="message">
                    {if isset($flashmessage)}
                        {$alert = $flashmessage[0]["alert"]}
                    {/if}
                    {if isset($message)}
                        <div class="alert alert-success">{$message}</div>
                    {/if}
                    {if isset($alert)}
                        <div class="alert alert-danger">{$alert}
                        </div>
                    {/if}
                </div>
                {foreach $asset_list  as $key=>$value}
                    <tr id="row{$value.asset_id}">
                        <td><label class="i-checks m-b-none"><input type="checkbox" class="delete_item_check" value="{$value.asset_id}" data-id="{$value.asset_id}" data-state={$value.state_id} data-status={$value.status_id}><i></i></label></td>
                        <td style="color:black; text-align: left" >{$value.name}</td>
                        <td style="color:black; text-align: left" >{$value.code}</td>
                        <td style="color:black; text-align: left;" >{$value.configuration}</td>
                        <td style="color:black" >
                            <span class="badge badge-{($value.status_id==1)?'success':(($value.status_id==2)?'warning':'danger')}">{$value.status_name}</span>
                        </td>
                        <td style="color:black" >
                            <span class="badge badge-{($value.state_id==2)?'success':(($value.state_id==1)?'warning':'danger')}" id="state_asset{$value.asset_id}">{$value.state_name}</span>
                        </td>
                        <td>
                            <a href="/asset/detail/id/{$value.asset_id}" style="margin-right: 20px" title="Xem chi tiết"><i class="fas fa-eye"></i></a>
                            {if $smarty.session.role_id==2 }
                                <a href="/asset/update/id/{$value.asset_id}"  style="margin-right: 20px" title="Sửa tài sản"><i class="fas fa-pen"></i></a>
                                <a class="delete-button" data-toggle="modal" data-target="#delete-data" data-id="{$value.asset_id}"  title="Xóa tài sản"><i class="fas fa-trash-alt"></i></a>
                            {/if}
                        </td>
                    </tr>
                {/foreach}
                </tbody>

                {*form multi delete*}

                <div class="modal fade xoa-modal" id="multi-delete-data" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="margin-top: 100px">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <b style="font-size: 17px">Xác nhận</b>
                            </div>
                            <div class="modal-body" style="font-size: 17px; margin-top: 15px; margin-bottom: 30px; text-align: center">
                                <div>Bạn có chắc muốn xóa những tài sản này?</div>
                            </div>
                            <div class="modal-footer">
                                <button class="btn btn-secondary" type="button" data-dismiss="modal">Hủy</button>
                                <a class="btn btn-primary" id="btn_multi_delete">Xóa</a>
                            </div>
                        </div>
                    </div>
                    <div class="card bg-success text-white shadow" style="display: none; position: fixed; bottom: 10px; left: 10px; border: none" id="xoahs_thanhcong">
                        <div class="card-body" style="align-items: center; display: flex; padding: 1rem">
                            <i class="fas fa-check-circle fa-2x" style="color: white; margin-right: 5px"></i>
                        </div>
                    </div>
                </div>
                {*form delete*}
                <div class="modal fade xoa-modal" id="delete-data" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="margin-top: 100px">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <b style="font-size: 17px">Xác nhận</b>
                            </div>
                            <div class="modal-body" style="font-size: 17px; margin-top: 15px; margin-bottom: 30px; text-align: center">
                                <div style="margin-bottom: 10px"><i class="fas fa-exclamation-triangle" ></i> Bạn có chắc muốn xóa tài sản này?</div>
                            </div>
                            <div class="modal-footer">
                                <button class="btn btn-secondary" type="button" data-dismiss="modal">Hủy</button>
                                <a class="btn btn-primary delete">Xóa</a>
                            </div>
                        </div>
                    </div>
                    <div class="card bg-success text-white shadow" style="display: none; position: fixed; bottom: 10px; left: 10px; border: none" id="xoahs_thanhcong">
                        <div class="card-body" style="align-items: center; display: flex; padding: 1rem">
                            <i class="fas fa-check-circle fa-2x" style="color: white; margin-right: 5px"></i>
                        </div>
                    </div>
                </div>

            </table>
        </div>
    </div>
</section>
<script>
    //xóa dữ liệu
    $('document').ready(function(){
        if($('#all-checked').is(':checked')){
            console.log('abc');
            $('#all-checked').change(function(){
                console.log('abc');
                // location.reload();
            });
        }
    });

    let myTable = $('#example').DataTable({
        "columnDefs": [ {
            "targets": 'no-sort',
            "orderable": false,
        } ],
        order: [[ 4, 'asc' ]],
        "bDestroy": true,
        "iDisplayLength": 10,
        select: {
            style:    'multi',
            selector: 'td:first-child'
        },
        language: {
            url: 'https://cdn.datatables.net/plug-ins/1.11.4/i18n/vi.json'
        }
    });
    $(".header").click(function(){
        getAssetID();
    });
    function getAssetID(){
        if($('#all-checked').is(':checked')){
            {foreach $asset_list  as $key=>$value}
            checkbox_asset_id.push("{$value.asset_id}");
            {/foreach}
            $('#all-checked').change(function(){
                console.log('abc');
                checkbox_asset_id=[];
            })

        }
        else {
            $('.delete_item_check:checkbox:checked').each(function (i) {
                checkbox_asset_id.push($(this).val());
            });
        }
        $("#inventory_asset_id").val(checkbox_asset_id);
        checkbox_asset_id = jQuery.unique(checkbox_asset_id)
        console.log(checkbox_asset_id);
        return checkbox_asset_id;
    }

    let checkbox_asset_id=[];

    $('document').ready(function(){
        if ($('#all-checked').is(':checked') || $('.delete_item_check').is(':checked'))
        {
            $(".disabled-btn").removeAttr("disabled");
        }
        $('#all-checked').prop('checked', false);
        $('.delete_item_check').prop('checked', false);
    });

    $('#all-checked,.delete_item_check').change(function(){

        if($(this).attr("id")=='all-checked'){
            if(this.checked) {
                myTable.rows().every(function () {
                    var data = this.node();
                    $(data).find('input').each(function () {
                        $(this).prop('checked', true);
                        checkbox_asset_id.push($(this).val());
                    });
                });
                $('.delete_item_check').prop('checked', true);
                $('.delete_item_check').change(function(){
                    var delete_item_val = $(this).val();
                    checkbox_asset_id = $.grep(checkbox_asset_id, function (value) {
                        return value != delete_item_val;
                    });
                    $('#all-checked').prop('checked', false);
                })
            }
            $('#all-checked').click(function() {
                if(!this.checked)
                {
                    myTable.rows().every(function () {
                        var data = this.node();
                        $(data).find('input').each(function () {
                            $(this).prop('checked', false);
                        });
                    });
                    checkbox_asset_id = [];
                }
            });
        }
        else{
            if(!$(this).is(':checked')) {
                console.log(uncheck_asset_id = $(this).val());
                checkbox_asset_id = $.grep(checkbox_asset_id, function (value) {
                    return value != uncheck_asset_id;
                });
            }
        }
        if ($('#all-checked').is(':checked') || $('.delete_item_check').is(':checked'))
        {
            $(".disabled-btn").removeAttr("disabled");
        }
        else
        {
            $(".disabled-btn").attr( "disabled", "disabled" );
        }
    });

    $(document).on('draw.dt', function () {

        var table = $('#example').DataTable();
        var page = table.page.info().page;

        if (page!=0){
            $('#all-checked').hide();
        }
        else{
            $('#all-checked').show();
        }

        $("#inventory_asset_id").val(checkbox_asset_id);

        $('#all-checked,.delete_item_check').change(function() {

            $('.delete_item_check:checkbox:checked').each(function (i) {
                checkbox_asset_id.push($(this).val());
            });
        })

        if($('#all-checked').is(':checked')){
            $('.delete_item_check').prop('checked', true);
            $('.delete_item_check').change(function(){
                $('#all-checked').prop('checked', false);
            })
            console.log(checkbox_asset_id);
        }
    });


    let delete_select_id;
    $(".delete-button").click(function(){
        delete_select_id = $(this).data("id");
        console.log(delete_select_id);
    });
    $(".delete").click(function(){
        var delete_id = delete_select_id;
        console.log(delete_id);
        $.ajax({
            method: "POST",
            url: "/asset/delete",
            data:{
                "id":delete_id
            },
            success:function(data) {
                if (typeof(data.error_input) != "undefined" && data.error_input_export !== null)
                {
                    $(".xoa-modal").modal('hide');
                    $(".alert").remove();
                    $("#message").append('<div class="alert alert-danger">'+data.error_input+'</div>');
                }
                else {
                    $(".xoa-modal").modal('hide');
                    $("#row" + delete_id).remove();
                    $(".alert").remove();
                    $("#message").append('<div class="alert alert-success">Xóa tài sản thành công!</div>');
                }
            }
        });
    });
    //xóa nhiều dữ liệu
    $("#btn_multi_delete").click(function(){
        var id = [];
        var state=[];
        i=0;
        $.each(getAssetID(), function(index, value ) {
            id[i] = value;
            i++;
        });
        $('.delete_item_check:checkbox:checked').each(function(i){
            state[i] = $(this).attr("data-state");
        });
        //
        if(jQuery.inArray("1", state)!== -1){
            $(".alert").remove();
            $("#fail-alert").remove();
            $("#export-user").modal('hide');
            $("#message").append('<div class="alert alert-danger" id="fail-alert">Xóa tài sản không thành công vì tài sản này đang sử dụng!</div>');
            $("#multi-delete-data").modal('hide');
        }
        else {
            if (id.length === 0) {
                $(".alert").remove();
                $("#message").append('<div class="alert alert-danger">Chọn tối thiểu một dòng!</div>');
                $("#multi-delete-data").modal('hide');
            } else {
                $.ajax({
                    method: "POST",
                    url: "/asset/multidelete",
                    data: {
                        "id": id
                    },
                    success: function (data) {
                        if (typeof(data.error_input) != "undefined" && data.error_input_export !== null)
                        {
                            $("#multi-delete-data").modal('hide');
                            $(".alert").remove();
                            $("#fail-alert").remove();
                            $("#message").append('<div class="alert alert-danger">'+data.error_input+'</div>');
                        }
                        else {
                            for (var i = 0; i < id.length; i++) {
                                $("#row" + id[i]).remove();
                            }
                            $(".alert").remove();
                            $("#message").append('<div class="alert alert-success">Xóa tài sản thành công!</div>');
                            $("#multi-delete-data").modal('hide');
                        }
                    }
                });
            }
        }
    });

    $("#btn_multi_export_user").click(function(){

        var id = [];
        i=0;
        $.each(getAssetID(), function(index, value ) {
            id[i] = value;
            i++;
        });

        var borrow_user_id = $("#borrow_user_id").val();
        var borrow_date = $("#borrow_date").val();
        var state=[];
        var status=[];
        $('.delete_item_check:checkbox:checked').each(function(i){
            state[i] = $(this).attr("data-state");
            status[i] = $(this).attr("data-status");
            console.log(state[i])
        });
        if(jQuery.inArray("1", state)!== -1 || jQuery.inArray("5", state)!== -1 || jQuery.inArray("2", status)!== -1 || jQuery.inArray("3", status)!== -1){
            $("#fail-alert").remove();
            $("#export-user").modal('hide');
            $(".alert").remove();
            $("#message").append('<div class="alert alert-danger" id="fail-alert">Tài sản này không thể xuất cho người dùng! Chỉ xuất được tài sản có tình trạng nguyên vẹn và trạng thái rảnh cho người dùng</div>');
            $("#multi-export-user").modal('hide');
        }
        else {
            if(id.length === 0)
            {
                $(".alert").remove();
                $("#message").append('<div class="alert alert-danger">Chọn tối thiểu một dòng!</div>');
                $("#multi-export-user").modal('hide');
            }
            else{
                $.ajax({
                    method: "POST",
                    url: "/asset/borrow",
                    data:{
                        "id":id,
                        'borrow_user_id':borrow_user_id,
                        'borrow_date': borrow_date,
                    },
                    success:function(data) {
                        console.log(data.error_input);
                        if (typeof(data.error_input) != "undefined" && data.error_input_export !== null)
                        {
                            console.log(data.error_input);
                            $("#alert").html(data.error_input);
                        }
                        else {
                            $(".alert").remove();
                            // $("#message").append('<div class="alert alert-success">Xuất tài sản cho người dùng thành công!</div>');
                            // for(var i=0; i<id.length; i++) {
                            //     console.log("#state_asset"+id);
                            //     $("#state_asset"+id[i]).attr('class', 'badge badge-warning');
                            //     $("#state_asset"+id[i]).html('Đang sử dụng');
                            //     $(".delete_item_check[data-id='" + id[i] + "']").attr('data-state', 1);
                            //
                            // }
                            $("#multi-export-user").modal('hide');
                            location.reload();
                        }
                    }
                });
            }
        }

    });


    $("#btn-inventory").click(function() {
        getAssetID();
    });

</script>
