<section class="panel">
    <header class="panel-heading">
        Thêm học sinh
    </header>
    <div class="panel-body">
        <form class="form-horizontal bucket-form" method="post" action="" enctype="multipart/form-data">
            <div class="form-group">
                <label class="col-sm-3 control-label">Tên học sinh</label>
                <div class="col-sm-6">
                    <input type="text" class="form-control" name="name" value="{$item_student['name']}" required>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">Tuổi</label>
                <div class="col-sm-6">
                    <input type="text" class="form-control" name="age" value="{$item_student['age']}" required>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">Địa chỉ</label>
                <div class="col-sm-6">
                    <input type="text" class="form-control round-input" name="address" value="{$item_student['address']}" required>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">Trạng thái</label>
                <div><input type="radio" value="1" name="status" {($item_student['status']==1)?'checked':''}>Hoạt động</div>
                <div><input type="radio" value="0" name="status" {($item_student['status']==0)?'checked':''}>Không hoạt động</div>
            </div>
            <div class="form-group">
                <div style="margin-left: 47%">
                    <button class="btn btn-primary" type="submit">Xác nhận</button>
                </div>
            </div>
        </form>
    </div>

</section>