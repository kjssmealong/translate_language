<style>
    th {
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
        <div class="col-sm-4">
            <ul style="display: flex; list-style: none;" class="crumb">
                <li><a href="/">Trang chủ</a></li>
                <li><a href="/inventory">Danh sách kiểm kê</a></li>
                <li>Chi tiết kiểm kê</li>
            </ul>
        </div>
        <div class="col-sm-4">
            Chi tiết kiểm kê
        </div>
        <div class="col-sm-3">

        </div>
        <div class="col-sm-1">
            <a href="/inventory/export-excel/inventory_id/{$inventory.inventory_id}" class="btn btn-success">Xuất excel</a>
        </div>
        {*        <div class="col-sm-2">*}
        {*            <div class="add-data">*}
        {*                <a href="/user/add" class="btn btn-success" style="" class="card-title" data-toggle="modal"><i class="fa fa-plus" aria-hidden="true"></i> Thêm</a>*}
        {*                <span style="margin-left: 10px;"><a class="btn btn-danger" data-toggle="modal" data-target="#multi-delete-data" ><i class="fas fa-times"></i> Xóa</a></span>*}
        {*            </div>*}
        {*        </div>*}
    </header>
    <div class="table-agile-info">
        <div class="form-horizontal bucket-form">
            <div class="form-group">
                <label class="col-sm-3 control-label">Mã kiểm kê</label>
                <div class="col-sm-6">
                    <div class="form-control">
                        {$inventory.inventory_code}
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">Người kiểm kê</label>
                <div class="col-sm-6">
                    <div class="form-control">
                        {$inventory.user_name}
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">Ngày kiểm kê</label>
                <div class="col-sm-6">
                    <div type="date" class="form-control">{$inventory.inventory_date}</div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">Ghi chú</label>
                <div class="col-sm-6">
                    <div class="form-control" name="inventory_note">{$inventory.note}</div>
                </div>
            </div>
        </div>
        <div class="table-responsive">
            <table class="table table-striped table-bordered" style="width:100%" id="example">
                <thead>
                    <tr>
                        <th rowspan="2" style="color:black; vertical-align: middle;">STT</th>
                        <th rowspan="2" style="color:black; vertical-align: middle;">Tên tài sản</th>
                        <th rowspan="2" style="color:black; vertical-align: middle;">Mã tài sản</th>
                        <th colspan="2" style="color:black">Tình trạng</th>
                        <th rowspan="2" style="color:black; vertical-align: middle;">Lưu ý</th>
                    </tr>
                    <tr>
                        <th style="color:black">Trước</th>
                        <th style="color:black">Sau</th>
                    </tr>
                </thead>
                <tbody>
                    <div id="message">
                        {if isset($message)}
                            <div class="alert alert-success">{$message}</div>
                        {/if}
                        {if isset($alert)}
                            <div class="alert alert-danger">{$alert}</div>
                        {/if}
                    </div>
                    {foreach $inventory_detail as $key=>$value}
                    <tr>
                        <td style="color:black">{$stt++}</td>
                        <td style="color:black">{$value.asset_name}</td>
                        <td style="color:black">{$value.asset_code}</td>
                        <td style="color:black; text-align: center;"><span class="badge badge-{($value.before_status==1)?'success':(($value.before_status==2)?'warning':'danger')}">{$value.before_status_name}</span></td>
                        <td style="color:black; text-align: center;"><span class="badge badge-{($value.inventory_status==1)?'success':(($value.inventory_status==2)?'warning':'danger')}">{$value.inventory_status_name}</span></td>
                        <td style="color:black">{$value.note}</td>
                    </tr>
                    {/foreach}
                </tbody>


            </table>
        </div>
    </div>
</section>
<script>

</script>
