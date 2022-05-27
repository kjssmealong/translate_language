<style>

</style>
<section>
    <form class="form-horizontal bucket-form" method="POST" action="/user/add" enctype="multipart/form-data">
        <header class="panel-heading">
            <div class="col-sm-4">
                <ul style="display: flex; list-style: none;" class="crumb">
                    <li><a href="/">Trang chủ</a></li>
                    <li><a href="/asset">Quản lý người dùng</a></li>
                    <li>Thêm người dùng</li>
                </ul>
            </div>
            <div class="col-sm-4">
                Thêm người dùng
            </div>
            <div class="col-sm-3">

            </div>
            <div class="col-sm-1">
                <button type="submit" class="btn btn-success" style="margin-left: 48%" disabled="disabled" id="btn-add">Thêm</button>
            </div>
        </header>
        <div class="table-agile-info">
            <div class="form-group">
                <label class="col-sm-3 control-label required-label">Họ tên</label>
                <div class="col-sm-6">
                    <input type="text" class="form-control required" name="name" value="{(isset($name))? {$name} : ''}">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label required-label">Số điện thoại</label>
                <div class="col-sm-6">
                    <input type="text" class="form-control required" name="phone" value="{(isset($phone))? {$phone} : ''}">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label required-label">Email</label>
                <div class="col-sm-6">
                    <input type="text" class="form-control required" name="email" value="{(isset($email))? {$email} : ''}">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label required-label">Mật khẩu</label>
                <div class="col-sm-6">
                    <input type="password" class="form-control required" name="password" value="{(isset($password))? {$password} : ''}">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label required-label" >Vai trò</label>
                <div class="col-sm-6">
                    <select class="form-control m-bot15 required" name="role">
                        {foreach $role_list as $key=>$value}
                            <option value="{$value.role_id}" {(isset($role))?(($value.role_id==$role)?'selected="selected"':'') : 'abc'}>{$value.name}</option>
                        {/foreach}
                    </select>
                </div>
            </div>
            <div class="form-group">
                <div class="row">
                    <label class="col-sm-3 control-label required-label">Hình ảnh</label>
                    <div class="col-sm-6">
                        <input type="file" class="form-control required" id="imgInp" name="image" accept="image/png, image/gif, image/jpeg">
                    </div>
                </div>
                <div class="row">
                    <span id="image-area"></span
                </div>
            </div>
        </div>
    </form>
</section>

<script>
    $(document).ready(function() {

        $('.required').on('change', function() {
            let empty = false;

            $('.required').each(function() {
                console.log($(this).val());
                if ($(this).val().length === 0)
                {
                    empty = true;
                }
            });

            if (empty)
                $('#btn-add').attr('disabled', 'disabled');
            else
                $('#btn-add').attr('disabled', false);
        });

        $('#imgInp').change(function(){
            $('.err_input').remove();
            if (this.files && this.files[0]) {
                var reader = new FileReader();

                reader.onload = function (e) {
                    $('#image-area img').remove();
                    $('#remove-image-btn').remove();
                    $('#image-area').append('<img src="' + e.target.result +'" id="blah" height="120px">' + '<div href="" id="remove-image-btn"><i class="fas fa-times"></i></div>');
                    $('#remove-image-btn').click(function() {
                        $('#image-area img').remove();
                        $('#remove-image-btn').remove();
                        $('#imgInp').val('');
                    });
                }

                reader.readAsDataURL(this.files[0]);

            }
        });

        {if isset($error_input)}
            var err_input = {$error_input|json_encode};
            console.log(err_input);
            $.each( err_input, function(key, value) {
                $('.form-control').each(function () {
                    if ($(this).prop('name') == key) {
                        $(this).parent().append('<div class="err_input">'+Object.values(value)+'</div>');
                    }
                });
            });
        {/if}

    });
</script>