<style>
    #image-area {
        position: relative;
        width: 100%;
        height: 100%;
        margin-left: 26%;
    }
    #image-area img{
        margin-top: 10px; ;
    }
    #remove-image-btn{
        position: absolute;
        top: 0%;
        left: 95%;
        transform: translate(-100%, -200%);
        -ms-transform: translate(-50%, -50%);
        background-color: #555;
        color: white;
        font-size: 11px;
        padding: 1px 4px;
        border: none;
        cursor: pointer;
        border-radius: 5px;
    }
</style>
<section>
    <form class="form-horizontal bucket-form" method="POST" action="/asset/update/id/{{$asset.asset_id}}" enctype="multipart/form-data">
        <header class="panel-heading">
            <div class="col-sm-4">
                <ul style="display: flex; list-style: none;" class="crumb">
                    <li><a href="/">Trang chủ</a></li>
                    <li><a href="/asset">Quản lý tài sản</a></li>
                    <li>Cập nhật tài sản</li>
                </ul>
            </div>
            <div class="col-sm-4">
                Cập nhật tài sản
            </div>
            <div class="col-sm-2">
            </div>
            <div class="col-sm-2">
                <button type="submit" class="btn btn-success" style="margin-left: 47%" id="btn-add" >Cập nhật</button>
            </div>
        </header>
        <div class="table-agile-info">

            <div class="form-group">
                <label class="col-sm-3 control-label required-label">Tên</label>
                <div class="col-sm-6">
                    <input type="text" class="form-control required" name="name" value="{(isset($name))? {$name} : {$asset.name}}">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label required-label">Mã</label>
                <div class="col-sm-6">
                    <input type="text" class="form-control required" name="code" value="{(isset($code))? {$code} : {$asset.code}}">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label required-label">Nhóm tài sản</label>
                <div class="col-sm-6">
                    <select class="form-control m-bot15 required" name="asset_group_id">
                        {foreach $menu_list as $key=>$value}
                            <option value="{$value.group_id}" {($value.group_id==$asset.asset_group_id)?'selected="selected"':""}>{$value.description}</option>
                        {/foreach}
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">Cấu hình</label>
                <div class="col-sm-6">
                    <textarea class="form-control" name="configuration">{(isset($configuration))? {$configuration} : {$asset.configuration}}</textarea>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label required-label">Tình trạng</label>
                <div class="col-sm-6">
                    <select class="form-control m-bot15 required" name="status">
                        {foreach $status_list as $key=>$value}
                            <option value="{$value.status_id}" {($value.status_id==$asset.status)?'selected="selected"':""}>{$value.status_name}</option>
                        {/foreach}
                    </select>
                </div>
            </div>
            <div class="form-group">
                <div class="row">
                    <label class="col-sm-3 control-label required-label">Hình ảnh</label>
                    <div class="col-sm-6">
                        <input type="file" class="form-control" id="imgInp" name="image" accept="image/png, image/gif, image/jpeg">
                        <input type="hidden" class="form-control required" id="image-check" name="image-check" value="1">
                    </div>
                </div>
                <div class="row">
                    <span id="image-area">
                        <img src="/images/asset_images/{$asset.image}" id="blah" width="150px" height="120px">
                        <div id="remove-image-btn"><i class="fas fa-times"></i></div>
                    </span>
                </div>
            </div>
        </div>
    </form>
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

