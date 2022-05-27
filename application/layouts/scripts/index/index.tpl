<div class="market-updates">
    <div class="col-md-3 market-update-gd">
        <div class="market-update-block clr-block-2">
            <a href="/asset">
                <div class="col-md-4 market-update-right">
                    <i class="fa fa-laptop"> </i>
                </div>
                <div class="col-md-8 market-update-left">
                    <h4>Tài sản</h4>
                    <h3>{$this->asset_count}</h3>
                </div>
                <div class="clearfix"> </div>
            </a>
        </div>
    </div>
    <div class="col-md-3 market-update-gd">
        <div class="market-update-block clr-block-1">
            <a href="/group">
                <div class="col-md-4 market-update-right">
                    <i class="fa fa-align-justify"></i>
                </div>
                <div class="col-md-8 market-update-left">
                    <h4>Nhóm tài sản</h4>
                    <h3>{$this->menu_count}</h3>
                </div>
                <div class="clearfix"> </div>
            </a>
        </div>
    </div>
    <div class="col-md-3 market-update-gd">
        <div class="market-update-block clr-block-3">
            <a href="/user">
                <div class="col-md-4 market-update-right">
                    <i class="fa fa-users"></i>
                </div>
                <div class="col-md-8 market-update-left">
                    <h4>Người dùng</h4>
                    <h3>{$this->user_count}</h3>
                </div>
                <div class="clearfix"> </div>
            </a>
        </div>
    </div>
    <div class="col-md-3 market-update-gd">
        <div class="market-update-block clr-block-4">
            <a href="/inventory">
                <div class="col-md-4 market-update-right">
                    <i class="fa fa-laptop"> </i>
                </div>
                <div class="col-md-8 market-update-left">
                    <h4>Danh sách kiểm kê</h4>
                    <h3>{$this->inventory_count}</h3>
                </div>
                <div class="clearfix"> </div>
            </a>
        </div>
    </div>
    <div class="clearfix"> </div>
</div>
<div class="row">
    <div class="col-md-5">
        <canvas id="StatusChart"></canvas>
    </div>
    <div class="col-md-2">
    </div>
    <div class="col-md-5">
        <canvas id="StateChart"></canvas>
    </div>
</div>
<script>

    // Global Options
    Chart.defaults.global.defaultFontFamily = 'Lato';
    Chart.defaults.global.defaultFontSize = 18;
    Chart.defaults.global.defaultFontColor = '#777';

    let StatusChart = document.getElementById('StatusChart').getContext('2d');

    let massStatusPopChart = new Chart(StatusChart, {
        type:'doughnut', // bar, horizontalBar, pie, line, doughnut, radar, polarArea
        data:{
            labels:[
                {foreach $asset_status_count as $value}
                    '{$value.status_name}',
                {/foreach}

            ],
            datasets:[{
                label:'Population',
                data:[
                    {foreach $asset_status_count as $value}
                    {$value.asset_count},
                    {/foreach}
                ],
                //backgroundColor:'green',
                backgroundColor:[
                    {foreach $asset_status_count as $value}
                        {if $value.status_id == 1}
                        'rgba(0, 255, 26, 0.6)',
                        {elseif $value.status_id == 2}
                        'rgba(255, 159, 64, 0.6)',
                        {elseif $value.status_id == 3}
                        'rgba(255, 0, 0, 0.6)',
                        {/if}
                    {/foreach}
                ],
                borderWidth:1,
                borderColor:'#777',
                hoverBorderWidth:3,
                hoverBorderColor:'#000'
            }]
        },
        options:{
            title:{
                display:true,
                text:'Thống kê tình trạng tài sản',
                fontSize:25
            },
            legend:{
                display:true,
                position:'right',
                labels:{
                    fontColor:'#000'
                }
            },
            layout:{
                padding:{
                    left:50,
                    right:0,
                    bottom:0,
                    top:0
                }
            },
            tooltips:{
                enabled:true
            }
        }
    });
</script>
<script>
    let StateChart = document.getElementById('StateChart').getContext('2d');

    Chart.defaults.global.defaultFontFamily = 'Lato';
    Chart.defaults.global.defaultFontSize = 18;
    Chart.defaults.global.defaultFontColor = '#777';

    let massStatePopChart = new Chart(StateChart, {
        type:'doughnut', // bar, horizontalBar, pie, line, doughnut, radar, polarArea
        data:{
            labels:[
                {foreach $asset_state_count as $value}
                '{$value.state_name}',
                {/foreach}
            ],
            datasets:[{
                label:'Population',
                data:[
                    {foreach $asset_state_count as $value}
                    {$value.asset_count},
                    {/foreach}
                ],
                //backgroundColor:'green',
                backgroundColor:[
                    {foreach $asset_state_count as $value}
                    {if $value.state_id == 2}
                    'rgba(0, 255, 26, 0.6)',
                    {elseif $value.state_id == 1}
                    'rgba(255, 159, 64, 0.6)',
                    {elseif $value.state_id == 5}
                    'rgba(255, 0, 0, 0.6)',
                    {/if}
                    {/foreach}
                ],
                borderWidth:1,
                borderColor:'#777',
                hoverBorderWidth:3,
                hoverBorderColor:'#000'
            }]
        },
        options:{
            title:{
                display:true,
                text:'Thống kê trạng thái tài sản',
                fontSize:25
            },
            legend:{
                display:true,
                position:'right',
                labels:{
                    fontColor:'#000'
                }
            },
            layout:{
                padding:{
                    left:50,
                    right:0,
                    bottom:0,
                    top:0
                }
            },
            tooltips:{
                enabled:true
            }
        }
    });
</script>

