<aside>
    <div id="sidebar" class="nav-collapse">
        <!-- sidebar menu start-->
        <div class="leftside-navigation">
            <ul class="sidebar-menu" id="nav-accordion">
                <li>
                    <a {($currentController=='/index')?'class="active"':''} href="/">
                        <i class="fas fa-home"></i>
                        <span>Trang chủ</span>
                    </a>
                </li>
                <li>
                    <a {($currentController=='/asset')?'class="active"':''} href="/asset">
                        <i class="fas fa-cogs"></i>
                        <span>{($smarty.session.role_id==2)?"Quản lý":"Xem danh sách"} tài sản</span>
                    </a>
                </li>
                {if $smarty.session.role_id==2 }
                <li class="sub-menu">
                    <a {($currentController=='/menu')?'class="active"':''} href="/group">
                        <i class="fas fa-list"></i>
                        <span>Quản lý nhóm tài sản</span>
                    </a>
                </li>

                <li class="sub-menu">
                    <a {($currentController=='/user')?'class="active"':''} href="/user">
                        <i class="fa fa-user"></i>
                        <span>Quản lý người dùng</span>
                    </a>
                </li>
                <li>
                    <a {($currentController=='/inventory')?'class="active"':''} href="/inventory">
                        <i class="fa fa-book"></i>
                        <span>Xem danh sách kiểm kê</span>
                    </a>
                </li>
                {/if}
            </ul>
        </div>
        <!-- sidebar menu end-->
    </div>
</aside>