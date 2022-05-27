<!--A Design by W3layouts
Author: W3layout
Author URL: http://w3layouts.com
License: Creative Commons Attribution 3.0 Unported
License URL: http://creativecommons.org/licenses/by/3.0/
-->
<!DOCTYPE html>
<head>
    <title>Quản lý tài sản</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="Visitors Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template,
Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />
    <script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
    <!-- bootstrap-css -->
    <link rel="stylesheet" href="/css/bootstrap.min.css" >
    <!-- //bootstrap-css -->
    <!-- Custom CSS -->
    <link href="/css/style.css" rel='stylesheet' type='text/css' />
    <link href="/css/charty.css" rel='stylesheet' type='text/css' />
    <link href="/css/mystyle.css" rel='stylesheet' type='text/css' />
    <link href="/css/style-responsive.css" rel="stylesheet"/>
    <!-- font CSS -->
    <link href='//fonts.googleapis.com/css?family=Roboto:400,100,100italic,300,300italic,400italic,500,500italic,700,700italic,900,900italic' rel='stylesheet' type='text/css'>
    <!-- font-awesome icons -->
    <link rel="stylesheet" href="/css/font.css" type="text/css"/>
{*    <link href="/css/font-awesome.css" rel="stylesheet">*}
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" />
    <link rel="stylesheet" href=https://cdn.datatables.net/1.11.4/css/dataTables.bootstrap4.min.css />


    <link rel="stylesheet" href="/css/morris.css" type="text/css"/>
    <!-- calendar -->
    <link rel="stylesheet" href="/css/monthly.css">

{*    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.2/css/bootstrap.css">*}
{*    <link rel="stylesheet" href="https://cdn.datatables.net/1.11.4/css/dataTables.bootstrap4.min.css">*}

    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.3/js/dataTables.bootstrap4.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.2.2/js/dataTables.buttons.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.html5.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.html5.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.3/js/dataTables.bootstrap4.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.print.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.6.0/Chart.min.js"></script>
    <script src="https://cdn.datatables.net/plug-ins/1.11.4/i18n/vi.json"></script>

    <!-- //calendar -->
    <!-- //font-awesome icons -->

    <script src="/js/raphael-min.js"></script>
    <script src="/js/morris.js"></script>
</head>
<body>
<section id="container">
    <!--header start-->
   {include file="layout/header.tpl"}
    <!--header end-->
    <!--sidebar start-->
        {include file="layout/sidebar.tpl"}
    <!--sidebar end-->
    <!--main content start-->
    <section id="main-content">
        <section class="wrapper">
            <!-- //market-->
            {$this->layout()->content}
        </section>
        <!-- footer -->
        {include file="layout/footer.tpl"}
        <!-- / footer -->
    </section>
    <!--main content end-->

    <script>
        //nút all check được chọn
        // $("#all-checked").change(function(){
        //     if(this.checked) {
        //         $('.delete_item_check').prop('checked', true);
        //         $('.delete_item_check').change(function(){
        //             $('#all-checked').prop('checked', false);
        //         })
        //     }
        //     else{
        //         $('.delete_item_check').prop('checked', false);
        //     }
        // })
        //disabled button

        $('#no-data').dataTable({
            "bPaginate": false
        });
    </script>
</section>
<script src="/js/bootstrap.js"></script>
<script src="/js/jquery.dcjqaccordion.2.7.js"></script>
<script src="/js/scripts.js"></script>
<script src="/js/jquery.slimscroll.js"></script>
<script src="/js/jquery.nicescroll.js"></script>
<!--[if lte IE 8]>
<script type="text/javascript" src="js/flot-chart/excanvas.min.js"></script><![endif]-->
<script src="/js/jquery.scrollTo.js"></script>
<script src="/js/charty.js"></script>
<!-- morris JavaScript -->
</body>
</html>
