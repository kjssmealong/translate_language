<section>
    <style>
        .btn-info {
            float: right;
        }
        table th {
            text-align: center;
        }
        .tbl-dgrr-physical th {
            white-space:nowrap;
            position: sticky;
            top: 0;
            background-color: #F1FBFE;
        }
        .stick-content {
            position: sticky;
            z-index: 1000;
            background-color: #F1FBFE !important;
            color: white !important;
            border: 1px solid white !important;
        }
        .stick-content1 {
            position: sticky;
            z-index: 500;
            background-color: #20B2AA !important;
            color: white !important;
            border: 1px solid white !important;
        }

    </style>
    <form class="form-horizontal bucket-form" method="POST" action="/asset/inventory" enctype="multipart/form-data">
    <header class="panel-heading">
        <div class="col-sm-4">
            <ul style="display: flex; list-style: none;" class="crumb">
                <li><a href="/">Trang chủ</a></li>
                <li><a href="/asset">Quản lý tài sản</a></li>
                <li>Kiểm kê tài sản</li>
            </ul>
        </div>
        <div class="col-sm-4">
            Kiểm kê tài sản
        </div>
        <div class="col-sm-4">
            <input type="submit" class="btn btn-primary" style="margin-left: 48%" value="Kiểm kê">
        </div>
    </header>
    <div class="table-agile-info">
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
            <div class="form-group">
                <label class="col-sm-3 control-label required-label">Ngày kiểm kê</label>
                <div class="col-sm-6">
                    <input type="date" class="form-control" name="inventory_date" value="{date("Y-m-d")}" max="{date("Y-m-d")}">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">Ghi chú</label>
                <div class="col-sm-6">
                    <textarea type="date" class="form-control" name="inventory_note"></textarea>
                </div>
            </div>
            <div class="table-responsive" style="overflow-y: scroll; max-height:600px; overflow-x:scroll;">
                <table class="table table-striped table-bordered tbl-dgrr-physical" >
                    <thead class="sticky-top bg-white">
                        <tr>
                            <th colspan="8" style="text-align: center">CHI TIẾT KIỂM KÊ</th>
                        </tr>
                        <tr>
                            <th>
                                STT
                            </th>
                            <th>
                                Tên tài sản
                            </th>
                            <th>
                                Mã tài sản
                            </th>
                            <th>
                                Nhóm tài sản
                            </th>
                            <th>
                                Tình trạng
                            </th>
                            <th>
                                Trạng thái
                            </th>
                            <th>
                                Tình trạng sau khi kiểm kê
                            </th>
                            <th>
                                Ghi chú
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                    {$stt = 1}
                    {foreach $asset_list  as $key=>$value}
                        <tr id="row{$value.asset_id}">
                            <input type="hidden" name="inventory_asset_id[]" value="{$value.asset_id}">
                            <input type="hidden" name="before_status[]" value="{$value.status}">
                            <td>{$stt++}</td>
                            <td style="color:black"; text-align: left;">{$value.name}</td>
                            <td style="color:black; text-align: left;" >{$value.code}</td>
                            <td style="color:black; text-align: left;" >{$value.asset_group}</td>
                            <td style="color:black" >{$value.status_name}</td>
                            <td style="color:black" >{$value.state_name}</td>
                            <td>
                                <select class="form-control m-bot15" name="inventory_detail_status[]">
                                {foreach $status_list as $status_key=>$status_value}
                                    <option value="{$status_value.status_id}" {($status_value.status_id==$value.status)?'selected="selected"':""}>{$status_value.status_name}</option>
                                {/foreach}
                                </select>
                            </td>
                            <td>
                                <textarea type="date" class="form-control" name="inventory_detail_note[]"></textarea>
                            </td>
                        </tr>
                    {/foreach}
                    </tbody>
                </table>

            </div>

        </form>
    </div>
</section>
<script>

</script>
