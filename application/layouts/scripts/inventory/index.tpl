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
                <li>Danh sách kiểm kê</li>
            </ul>
        </div>
        <div class="col-sm-6">
            Danh sách kiểm kê
        </div>
        <form method="POST" action="/inventory/multi-export">
        <div class="col-sm-2">
        </div>
        <div class="col-sm-1">
            <input type="submit" class="btn btn-success disabled-btn" id="export-btn" value="Xuất excel" disabled></input>
        </div>
    </header>
    <div class="table-agile-info">
        <div class="table-responsive">
            <table class="table table-striped table-bordered" style="width:100%">
                <thead>
                <tr>
{*                    <th style="width:60px;" class="no-sort">*}
{*                        <input type="checkbox" class="check-control" id="all-checked">*}
{*                    </th>*}
                    <th style="width:60px;" class="no-sort">
                        <input type="checkbox" class="check-control" id="all-checked">
                    </th>
                    <th style="color:black">Mã kiểm kê</th>
                    <th style="color:black">Người kiểm kê</th>
                    <th style="color:black">Ngày kiểm kê</th>
                    <th style="color:black">Ghi chú</th>
                    <th style="color:black" class="no-sort">Thao tác</th>
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
                {foreach $inventory_list  as $key=>$value}
                    <tr>
                        <td><label class="i-checks m-b-none"><input type="checkbox" class="delete_item_check" value="{$value.inventory_id}" name="inventory_id[]"><i></i></label></td>

{*                        <td><label class="i-checks m-b-none"><input type="checkbox" class="delete_item_check" value="{$value.user_id}"><i></i></label></td>*}
                        <td style="color:black; text-align: left; " >{$value.inventory_code}</td>
                        <td style="color:black; text-align: left" >{$value.user_name}</td>
                        <td style="color:black" >{date("d-m-Y", strtotime($value.inventory_date))}</td>
                        <td style="color:black" >{$value.note}</td>
                        <td>
                            <a href="/inventory/detail/inventory_id/{$value.inventory_id}" title="Xem chi tiết"><i class="fas fa-eye"></i></a>
                        </td>
                    </tr>
                {/foreach}
                </tbody>
                </form>


            </table>
        </div>
    </div>
</section>
<script>
    $("#export-btn").click(function(){
        $(".alert").remove();

    });
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
</script>