<style>

</style>
<section>
    <header class="panel-heading">
        <div class="col-sm-12">
            Cập nhật người dùng
        </div>
    </header>
    <div class="table-agile-info">

        <form class="form-horizontal bucket-form" method="POST" action="/user/update/id/{$user.user_id}" enctype="multipart/form-data">
            <div class="form-group">
                <label class="col-sm-3 control-label required-label">Họ tên</label>
                <div class="col-sm-6">
                    <input type="text" class="form-control" name="name" value="{(!empty($name))? {$name} : {$user.name}}">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label required-label">Số điện thoại</label>
                <div class="col-sm-6">
                    <input type="text" class="form-control" name="phone" value="{(!empty($phone))? {$phone} : {$user.phone}}">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label required-label">Email</label>
                <div class="col-sm-6">
                    <input type="text" class="form-control" name="email" value="{(!empty($email))? {$email} : {$user.email}}">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label required-label" >Vai trò</label>
                <div class="col-sm-6">
                    <select class="form-control m-bot15" name="role">
                        {foreach $role_list as $key=>$value}
                            <option value="{$value.role_id}" {($value.role_id==$user.role_id)?'selected="selected"':""} >{$value.name}</option>
                        {/foreach}
                    </select>
                </div>
            </div>
            <div class="form-group">
                <div class="row">
                    <label class="col-sm-3 control-label required-label">Hình ảnh</label>
                    <div class="col-sm-6">
                        <input type="file" class="form-control" id="imgInp" name="image" accept="image/png, image/gif, image/jpeg">
                        <input type="hidden" class="form-control" id="image-check" name="image-check" value="1">
                    </div>
                </div>
                <div class="row">
                    <span id="image-area">
                        <img src="/images/user_images/{$user.image}" id="blah" height="120px">
                        <div id="remove-image-btn"><i class="fas fa-times"></i></div>
                    </span
                </div>
            </div>
            <button type="submit" class="btn btn-success" style="margin-left: 46%">Cập nhật</button>
        </form>
    </div>

</section>

<script>
    $(document).ready(function() {

        function RemoveImageClick(){
            $('#remove-image-btn').click(function() {
                $('#image-area img').remove();
                $('#remove-image-btn').remove();
                $('#imgInp').val('');
                $('#image-check').val('');
            });
        }

        RemoveImageClick();

        $('#imgInp').change(function(){
            $('.err_input').remove();
            if (this.files && this.files[0]) {
                var reader = new FileReader();

                reader.onload = function (e) {
                    $('#image-area img').remove();
                    $('#remove-image-btn').remove();
                    $('#image-area').append('<img src="' + e.target.result +'" id="blah" width="150px" height="120px">' + '<div href="" id="remove-image-btn"><i class="fas fa-times"></i></div>');
                    $('#image-check').val('1');
                    RemoveImageClick()
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