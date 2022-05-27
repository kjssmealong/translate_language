<style>
    th {
        text-align: center;
    }
    td {
        text-align: center;
    }
</style>
<section>
    {$stt=1}
    <header class="panel-heading">
        <div class="col-sm-1">
            <a href="/training/add" class="btn btn-danger"><i class="fa fa-plus" aria-hidden="true"></i> Thêm</a>
        </div>
        <div class="col-sm-2"></div>
        <div class="col-sm-6">
            Danh sách học sinh
        </div>
        <div class="col-sm-3">
            <form action="" method="post">
                <div class="input-group">
                    <input type="text" class="input-sm form-control" name="key" style="margin-top:14px">
                    <span class="input-group-btn">
                        <button class="btn btn-sm btn-default" type="submit">Tìm</button>
                    </span>
                </div>
            </form>
        </div>
    </header>
    <?php $stt = 1; ?>
    <div class="table-agile-info">
        <div class="table-responsive">
            <table id="example" class="table table-striped table-bordered table-sm"  cellspacing="0">
                <thead>
                <tr>
                    <th style="color:black">STT</th>
                    <th style="color:black">Tên</th>
                    <th style="color:black">Tuổi</th>
                    <th style="color:black">Địa chỉ</th>
                    <th style="color:black">Trạng thái</th>
                    <th style="color:black">Cập nhật</th>
                    <th style="color:black">Xóa</th>
                </tr>
                </thead>
                <tbody>

                {foreach $list_student as $key=>$value}

                    <tr>
                        <td style="color:black">{$stt++}</td>
                        <td style="color:black">{$value.name}</td>
                        <td style="color:black">{$value.age}</td>
                        <td style="color:black">{$value.address}</td>
                        <td style="color:black">{$value.status}</td>
                        <td>
                            <a href="/training/update/id/{$value.student_id}"><i class="fas fa-pen"></i></a>
                        </td>
                        <td>
                            <a href="/training/delete/id/{$value.student_id}" onclick="return confirm('Bạn có muốn xóa không?')"><i class="fas fa-trash-alt"></i></a>
                        </td>
                    </tr>
                {/foreach}
                </tbody>

            </table>
        </div>
    </div>
</section>
