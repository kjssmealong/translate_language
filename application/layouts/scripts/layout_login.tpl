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

    <!-- //calendar -->
    <!-- //font-awesome icons -->

    <script src="/js/raphael-min.js"></script>
    <script src="/js/morris.js"></script>
</head>
<body>
{*<a>abc</a>*}
<div class="log-w3">
    <div class="w3layouts-main">
            <h2>ĐĂNG NHẬP</h2>
            <form action="#" method="post">
                <input type="email" class="ggg" name="email" placeholder="E-MAIL" required="">
                <input type="password" class="ggg" name="password" placeholder="MẬT KHẨU" required="">
                {if (isset($error))}
                <div class="alert alert-danger">Sai mật khẩu!</div>
                {/if}
{*                <span><input type="checkbox" />Nhớ mật khẩu</span>*}
                <div class="clearfix"></div>
                <input type="submit" value="ĐĂNG NHẬP" name="login">
            </form>
    </div>
    {$this->layout()->content}
</div>
<script src="/js/bootstrap.js"></script>
<script src="/js/jquery.dcjqaccordion.2.7.js"></script>
<script src="/js/scripts.js"></script>
<script src="/js/jquery.slimscroll.js"></script>
<script src="/js/jquery.nicescroll.js"></script>
<!--[if lte IE 8]>
<script language="javascript" type="text/javascript" src="js/flot-chart/excanvas.min.js"></script><![endif]-->
<script src="/js/jquery.scrollTo.js"></script>
</body>
</html>