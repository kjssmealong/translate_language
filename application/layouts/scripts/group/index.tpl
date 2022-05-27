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
</style>

<section>
    {$stt=1}
    <header class="panel-heading">
        <div class="col-sm-3">
            <ul style="display: flex; list-style: none;" class="crumb">
                <li><a href="/">Trang chủ</a></li>
                <li>Quản lý nhóm tài sản</li>
            </ul>
        </div>
        <div class="col-sm-6">
            {$title}
        </div>
        <div class="col-sm-1">
        </div>
        <div class="col-sm-2">
            <div class="add-data">
                <a href="" class="btn btn-success" style="" class="card-title" data-toggle="modal" data-target="#exampleModal" ><i class="fa fa-plus" aria-hidden="true"></i> Thêm</a>
                <a style="margin-left: 10px;"><button class="btn btn-danger disabled-btn" data-toggle="modal" data-target="#multi-delete-data" disabled><i class="fas fa-times"></i> Xóa</button></a>
            </div>
        </div>
    </header>
    <div class="table-agile-info">
        <div class="table-responsive">
            <table id="example" class="table table-striped table-bordered" style="width:100%">
                <thead>
                <tr>
                    <th style="width:60px;" class="no-sort">
                        <input type="checkbox" class="check-control" id="all-checked">
                    </th>
                    <th style="color:black">Tên</th>
                    <th style="color:black">Trạng thái</th>
                    <th style="color:black" class="no-sort">Thao tác</th>
                </tr>
                </thead>
                <div id="message">
                    {if isset($message)}
                        <div class="alert alert-success">{$message}</div>
                    {/if}
                </div>
                <tbody>

                {foreach $menu_list  as $key=>$value}
                    <tr id="row{$value.group_id}">
                        <td><label class="i-checks m-b-none"><input type="checkbox" class="delete_item_check" value="{$value.group_id}" data-assetcount="{$value.asset_count}"><i></i></label></td>
                        <td style="color:black; text-align: left " id="row-description{$value.group_id}"><a href="asset?group_id={$value.group_id}" class="group-href">{$value.description}</a><span class="badge badge-light" style="margin-left: 7px;" >{$value.asset_count}</span></td>
                        <td style="color:black" id="row-status{$value.group_id}" >{($value.active==1)?"<span class='badge badge-success'>Kích hoạt</span>":"<span class='badge badge-danger'>Không kích hoạt</span>"}</td>
                        <td>
                            <button class="update-button" type="submit" data-toggle="modal" data-target="#update-data" data-id="{$value.group_id}" data-desription="{$value.description}" data-active="{$value.active}" title="Sửa nhóm tài sản"><i class="fas fa-pen"></i></button>
                            <button class="delete-button" data-toggle="modal" data-target="#delete-data" data-id="{$value.group_id}" data-assetcount="{$value.asset_count}" title="Xóa nhóm tài sản"><i class="fas fa-trash-alt"></i></button>
                        </td>
                    </tr>
                {/foreach}
                </tbody>
                {*form add*}
                <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="margin-top: 100px">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel" style="text-align: center">Thêm dữ liệu</h5>
                            </div>
                            <form action="" method="post" >
                                <div class="modal-body" style="margin: 10px 10px 60px 10px">
                                    <div class="form-group" style="margin-bottom: 60px">
                                        <label class="col-sm-3 add-name required-label" style="font-size: 13px; margin-top: 10px; text-align: right"><b>Tên:</b></label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control required" name="description" id="add_description">
                                            <p id="alert" style="color: red; font-size: 13px; margin: 10px"></p>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3" style="font-size: 13px; margin-top: 10px; text-align: right"><b>Hoạt động:</b></label>
                                        <div class="col-sm-8">
                                            <select class="form-control" name="active" id="add_active">
                                                <option value="1" selected="selected">Kích hoạt</option>
                                                <option value="0">Không kích hoạt</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                                    <a type="submit" id="add" class="btn btn-primary" disabled="disabled">Tiếp tục</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                {*form multi delete*}
                <div class="modal fade xoa-modal" id="multi-delete-data" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="margin-top: 100px">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <b style="font-size: 17px">Xác nhận</b>
                            </div>
                            <div class="modal-body" style="font-size: 17px; margin-top: 15px; margin-bottom: 30px; text-align: center">
                                <div style="margin-bottom: 10px"><i class="fas fa-exclamation-triangle" ></i> Bạn có chắc chắn muốn xóa nhóm tài sản này?</div>
                            </div>
                            <div class="modal-footer">
                                <button class="btn btn-secondary" type="button" data-dismiss="modal">Hủy</button>
                                <a class="btn btn-primary" id="btn_multi_delete"">Xóa</a>
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
                                <div style="margin-bottom: 10px"><i class="fas fa-exclamation-triangle" ></i> Bạn có chắc chắn muốn xóa nhóm tài sản này?</div>
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

                {*form update*}

                <div class="modal fade" id="update-data" tabindex="-1" role="dialog" aria-labelledby="edit-data" aria-hidden="true" style="margin-top: 100px">
                    <div class="modal-dialog" role="document">
                        <form method="POST">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="edit-data" style="text-align: center"><b>Chỉnh sửa dữ liệu</b></h5>
                                </div>
                                <div class="modal-body" style="margin: 10px 10px 60px 10px">
                                    <div class="form-group" style="margin-bottom: 60px">
                                        <label class="col-sm-3 required-label" style="margin-top:5px; text-align: right"><b>Tên:</b></label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" id="update_description" name="description" required>
                                            <div class="update-alert" style="color: #ff0000; font-size: 13px; margin:10px; text-align: left"></div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3" style="margin-top:5px; text-align: right"><b>Trạng thái:</b></label>
                                        <div class="col-sm-8">
                                            <select class="form-control" id="update_active" name="active">
                                                <option value="1">Kích hoạt</option>
                                                <option value="0">Không kích hoạt</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                                    <a class="btn btn-primary update">Cập nhật</a>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </table>
        </div>
    </div>
</section>
<script>
    {*<tr id="row{$value.group_id}">*}
    {*    <td><label class="i-checks m-b-none"><input type="checkbox" class="delete_item_check" value="{$value.group_id}"><i></i></label></td>*}
    {*    <td style="color:black" id="row-description{$value.group_id}">{$value.description}</td>*}
    {*    <td style="color:black" id="row-status{$value.group_id}">{($value.active==1)?"Kích hoạt":"Không kích hoạt"}</td>*}
    {*    <td>*}
    {*        <button class="update-button" type="submit" data-toggle="modal" data-target="#update-data" data-id="{$value.group_id}" data-desription="{$value.description}" data-active="{$value.active}"><i class="fas fa-pen"></i></button>*}
    {*        <button class="delete-button" data-toggle="modal" data-target="#delete-data" data-id="{$value.group_id}"><i class="fas fa-trash-alt"></i></button>*}
    {*    </td>*}
    {*</tr>*}
    $('#all-checked,.delete_item_check').change(function(){
        if($(this).attr("id")=='all-checked'){
            if(this.checked) {
                $('.delete_item_check').prop('checked', true);
                $('.delete_item_check').change(function(){
                    $('#all-checked').prop('checked', false);
                })
            }
            else{
                $('.delete_item_check').prop('checked', false);
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
    //add dữ liệu
    $('#example').DataTable({
        "columnDefs": [ {
            "targets": 'no-sort',
            "orderable": false,
        } ],
        order: [[ 2, 'desc' ]],
        "bDestroy": true,
        "iDisplayLength": 25,
        "bLengthChange": false,
        language: {
            url: 'https://cdn.datatables.net/plug-ins/1.11.4/i18n/vi.json'
        }
    });
    $('.required').on('change', function() {
        let empty = false;

        $('.required').each(function() {
            console.log($(this).val());
            empty = $(this).val().length == 0;
        });

        if (empty)
            $('#add').attr('disabled', 'disabled');
        else
            $('#add').attr('disabled', false);
    });
    $("#add").click(function(){
        var description = $("#add_description").val();
        var active = $("#add_active").val();
        $.ajax({
            method: "POST",
            url: "/group/add",
            data:{
                'description':description,
                'active': active,
            },
            success:function(data) {
                if (typeof(data.error_input) != "undefined" && data.error_input !== null)
                {
                    $("#alert").html(data.error_input);
                }
                else{
                    $(".alert").remove();
                    $("#message").append('<div class="alert alert-success">Thêm nhóm tài sản thành công!</div>');
                    $("#exampleModal").modal('hide');
                    var group_id = data.id_insert;
                    console.log(active);
                    $('tbody').prepend('<tr id="row'+group_id+'">'+'<td><label class="i-checks m-b-none"><input type="checkbox" class="delete_item_check" value="'+group_id+'"><i></i></label></td>'+'<td style="color:black" id="row-description'+group_id+'">'+description+'</td>'+'<td style="color:black" id="row-status'+group_id+'">'+'Kích hoạt'+'</td>'+'<td>'+'<button class="update-button" type="submit" data-toggle="modal" data-target="#update-data" data-id="'+group_id+'" data-desription="'+description+'" data-active="'+active+'"><i class="fas fa-pen"></i></button>'+'<button class="delete-button" data-toggle="modal" data-target="#delete-data" data-id="'+group_id+'"><i class="fas fa-trash-alt"></i></button>'+'</td>'+'</tr>');
                    location.reload();
                }

            }
        });
    });

    //xóa dữ liệu
    let delete_select_id;
    let delete_select_assetcount;
    $(".delete-button").click(function(){
        delete_select_id = $(this).data("id");
        delete_select_assetcount = $(this).attr("data-assetcount");
    });
    $(".delete").click(function(){
        var delete_id = delete_select_id;
        var delete_assetcount = delete_select_assetcount;
        console.log(delete_id);
        $.ajax({
            method: "POST",
            url: "/group/delete",
            data:{
                "id":delete_id,
                "asset_count":delete_assetcount,
            },
            success:function(data) {
                if (typeof(data.error_input) != "undefined" && data.error_input_export !== null)
                {
                    $(".xoa-modal").modal('hide');
                    $(".alert").remove();
                    $("#message").append('<div class="alert alert-danger">Xóa nhóm tài sản không thành công!</div>');
                }
                else {
                    $(".xoa-modal").modal('hide');
                    $("#row" + delete_id).remove();
                    $(".alert").remove();
                    $("#message").append('<div class="alert alert-success">Xóa nhóm tài sản thành công!</div>');
                }
            }
        });
    });
    //xóa nhiều dữ liệu
    $("#btn_multi_delete").click(function(){
        var id =[];
        var asset_count=[];
        $('.delete_item_check:checkbox:checked').each(function(i){
            id[i] = $(this).val();
            asset_count[i] = $(this).attr("data-assetcount");
        });
        if(id.length === 0)
        {
            $(".alert").remove();
            $("#message").append('<div class="alert alert-danger">Chọn tối thiểu một dòng!</div>');
            $("#multi-delete-data").modal('hide');
        }
        else {
            $.ajax({
                method: "POST",
                url: "/group/multidelete",
                data: {
                    "id": id,
                    "asset_count": asset_count,
                },
                success: function (data) {
                    if (typeof(data.error_input) != "undefined" && data.error_input_export !== null)
                    {
                        $(".xoa-modal").modal('hide');
                        $(".alert").remove();
                        $("#message").append('<div class="alert alert-danger">Xóa nhóm tài sản không thành công! Chỉ xóa những nhóm tài sản không có tài sản</div>');
                    }
                    else {
                        for (var i = 0; i < id.length; i++) {
                            $("#row" + id[i]).remove();
                        }
                        $(".alert").remove();
                        $("#message").append('<div class="alert alert-success">Xóa nhóm tài sản thành công!</div>');
                        $("#multi-delete-data").modal('hide');
                    }
                }
            });
        }

    });
    //cập nhật dữ liệu
    let update_select_id;
    let update_select_description;
    let update_select_active;
    $(".update-button").click(function(){

        update_select_id = $(this).data("id");
        update_select_description = $(this).data("desription");
        update_select_active = $(this).data("active");
        // console.log( update_select_id + update_select_description + update_select_active);
        $("#update_description").val(update_select_description);
        $("#update_active").val(update_select_active);
    });
    $(".update").click(function(){
        var update_id = update_select_id;
        var description = $("#update_description").val();
        var active = $("#update_active").val();

        $.ajax({
            method: "POST",
            url: "/group/update",
            data:{
                'id':update_id,
                'description':description,
                'active': active,
            },
            success:function(data) {
                if (typeof(data.error_input) != "undefined" && data.error_input !== null)
                {
                    $(".update-alert").html(data.error_input);
                }
                else{
                    $("#update-data").modal('hide');
                    $("#row-description"+update_id+" .group-href").html(description);
                    if(active == 1) {
                        $("#row-status" + update_id + " .badge").remove();
                        $("#row-status" + update_id).append("<span class='badge badge-success'>Kích hoạt</span>");
                    }
                    else{
                        $("#row-status" + update_id + " .badge").remove();
                        $("#row-status" + update_id).append("<span class='badge badge-danger'>Không kích hoạt</span>");
                    }
                    $(".alert").remove();
                    $("#message").append('<div class="alert alert-success">Cập nhật nhóm tài sản thành công!</div>');
                }

            }
        });
    });

</script>
