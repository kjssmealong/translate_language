<?php
/* Smarty version 3.1.42, created on 2022-05-27 10:31:05
  from 'D:\xampp\htdocs\translate_language\application\layouts\scripts\layout_login.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.42',
  'unifunc' => 'content_629045f97c3410_68238354',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'e3d3fcc01a28d2aa2dce0677fadca4444de65817' => 
    array (
      0 => 'D:\\xampp\\htdocs\\translate_language\\application\\layouts\\scripts\\layout_login.tpl',
      1 => 1653621669,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_629045f97c3410_68238354 (Smarty_Internal_Template $_smarty_tpl) {
?><!DOCTYPE html>
<head>
    <title>Quản lý tài sản</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="Visitors Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template,
Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />
    <?php echo '<script'; ?>
 type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } <?php echo '</script'; ?>
>
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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" />
    <link rel="stylesheet" href=https://cdn.datatables.net/1.11.4/css/dataTables.bootstrap4.min.css />


    <link rel="stylesheet" href="/css/morris.css" type="text/css"/>
    <!-- calendar -->
    <link rel="stylesheet" href="/css/monthly.css">

        
    <?php echo '<script'; ?>
 src="https://code.jquery.com/jquery-3.5.1.js"><?php echo '</script'; ?>
>
    <?php echo '<script'; ?>
 src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"><?php echo '</script'; ?>
>
    <?php echo '<script'; ?>
 src="https://cdn.datatables.net/1.11.3/js/dataTables.bootstrap4.min.js"><?php echo '</script'; ?>
>

    <!-- //calendar -->
    <!-- //font-awesome icons -->

    <?php echo '<script'; ?>
 src="/js/raphael-min.js"><?php echo '</script'; ?>
>
    <?php echo '<script'; ?>
 src="/js/morris.js"><?php echo '</script'; ?>
>
</head>
<body>
<div class="log-w3">
    <div class="w3layouts-main">
            <h2>ĐĂNG NHẬP</h2>
            <form action="#" method="post">
                <input type="email" class="ggg" name="email" placeholder="E-MAIL" required="">
                <input type="password" class="ggg" name="password" placeholder="MẬT KHẨU" required="">
                <?php if (((isset($_smarty_tpl->tpl_vars['error']->value)))) {?>
                <div class="alert alert-danger">Sai mật khẩu!</div>
                <?php }?>
                <div class="clearfix"></div>
                <input type="submit" value="ĐĂNG NHẬP" name="login">
            </form>
    </div>
    <?php echo $_smarty_tpl->tpl_vars['this']->value->layout()->content;?>

</div>
<?php echo '<script'; ?>
 src="/js/bootstrap.js"><?php echo '</script'; ?>
>
<?php echo '<script'; ?>
 src="/js/jquery.dcjqaccordion.2.7.js"><?php echo '</script'; ?>
>
<?php echo '<script'; ?>
 src="/js/scripts.js"><?php echo '</script'; ?>
>
<?php echo '<script'; ?>
 src="/js/jquery.slimscroll.js"><?php echo '</script'; ?>
>
<?php echo '<script'; ?>
 src="/js/jquery.nicescroll.js"><?php echo '</script'; ?>
>
<!--[if lte IE 8]>
<?php echo '<script'; ?>
 language="javascript" type="text/javascript" src="js/flot-chart/excanvas.min.js"><?php echo '</script'; ?>
><![endif]-->
<?php echo '<script'; ?>
 src="/js/jquery.scrollTo.js"><?php echo '</script'; ?>
>
</body>
</html><?php }
}
