<header class="header fixed-top clearfix">
    <!--logo start-->
    <div class="brand">
        <a href="/" class="logo">
            PLOTT
        </a>
        <div class="sidebar-toggle-box">
            <div class="fa fa-bars"></div>
        </div>
    </div>
    <div class="nav notify-row" style="margin-left: 1350px; font-size:14px" id="top_menu">
        <!--  notification start -->
        <a href="/help" target="_blank">Hướng dẫn</a>
        <!--  notification end -->
    </div>
    <!--logo end-->
    <div class="top-nav clearfix">
        <!--search & user info start-->
        <ul class="nav pull-right top-menu">
            <!-- user login dropdown start-->
            <li class="dropdown">
                <a data-toggle="dropdown" class="dropdown-toggle" href="#" aria-expanded="true">
                    <img alt="" src="/images/user_images/{$smarty.session.image}">
                    <span class="username">{$smarty.session.user_name}</span>
                    <b class="caret"></b>
                </a>
                <ul class="dropdown-menu extended logout">
                    <li><a href="/account"><i class=" fa fa-suitcase"></i>Tài khoản</a></li>
                    <li><a href="/login/logout"><i class="fa fa-key"></i> Đăng xuất</a></li>
                </ul>
            </li>
            <!-- user login dropdown end -->

        </ul>
        <!--search & user info end-->
    </div>
</header>