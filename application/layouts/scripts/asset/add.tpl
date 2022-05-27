<section>
    <form class="form-horizontal bucket-form" method="POST" action="/asset/add" enctype="multipart/form-data">
        <header class="panel-heading">
            <div class="col-sm-4">
                <ul style="display: flex; list-style: none;" class="crumb">
                    <li><a href="/">Trang chủ</a></li>
                    <li><a href="/asset">Quản lý tài sản</a></li>
                    <li>Thêm tài sản</li>
                </ul>
            </div>
            <div class="col-sm-4">
                Thêm tài sản
            </div>
            <div class="col-sm-3">
            </div>
            <div class="col-sm-1">
                <button type="submit" class="btn btn-success" id="btn-add" style="margin-left: 48%" disabled="disabled" >Thêm</button>
            </div>
        </header>
        <div class="table-agile-info">
                <div class="form-group">
                    <label class="col-sm-3 control-label required-label">Tên</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control required" name="name" id="name" value="{(isset($name))? {$name} : ''}">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label required-label">Mã</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control required" name="code" value="{(isset($code))? {$code} : ''}">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label required-label">Nhóm tài sản</label>
                    <div class="col-sm-6">
                        <select class="form-control m-bot15  required" name="asset_group_id">
                            <option disabled selected value="">Chọn nhóm tài sản</option>
                            {foreach $menu_list as $key=>$value}
                            <option value="{$value.group_id}" {(isset($asset_group_id))?(($value.group_id==$asset_group_id)?'selected="selected"':'') : ''}>{$value.description}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">Cấu hình</label>
                    <div class="col-sm-6">
                        <textarea class="form-control" name="configuration">{(isset($configuration))? {$configuration} : ''}</textarea>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label required-label">Tình trạng</label>
                    <div class="col-sm-6">
                        <select class="form-control m-bot15  required" name="status">
                            <option disabled selected value>Chọn tình trạng</option>
                            {foreach $status_list as $key=>$value}
                                <option value="{$value.status_id}" {(isset($status))?(($value.status_id==$status)?'selected="selected"':'') : ''}>{$value.status_name}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <label class="col-sm-3 control-label required-label">Hình ảnh</label>
                        <div class="col-sm-6">
                            <input type="file" class="form-control  required" id="imgInp" name="image" accept="image/png, image/gif, image/jpeg" >
                        </div>
                    </div>
                    <div class="row">
                    <span id="image-area">
{*                        {if isset($image)}*}
{*                        <img src="/images/asset_images/{$image}" id="blah" height="120px">*}
{*                        <div id="remove-image-btn"><i class="fas fa-times"></i></div>*}
{*                        {/if}*}
                    </span>
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
                if($(this).val().length === 0){
                    empty = true;
                }
            });

            if (empty)
                $('#btn-add').attr('disabled', 'disabled');
            else
                $('#btn-add').attr('disabled', false);
        });
    });
        $('#imgInp').change(function(){
            console.log('abc');
            $('.err_input').remove();
            if (this.files && this.files[0]) {
                var reader = new FileReader();

                reader.onload = function (e) {
                    $('#image-area img').remove();
                    $('#remove-image-btn').remove();
                    $('#image-area').append('<img src="' + e.target.result +'" id="blah" height="120px">' + '<div href="" id="remove-image-btn"><i class="fas fa-times"></i></div>');
                    $('#remove-image-btn').click(function() {
                        $('#btn-add').attr('disabled', 'disabled');
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

</script>