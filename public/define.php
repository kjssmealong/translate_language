<?php

//duong dan den thu muc chua ung dung
defined('APPLICATION_PATH')
|| define('APPLICATION_PATH', realpath(dirname(__FILE__) . '/../application'));

//define application enviroment
defined('APPLICATION_ENV')
|| define('APPLICATION_ENV', (getenv('APPLICATION_ENV') ? getenv('APPLICATION_ENV') : 'production'));

//nap duong dan den thu vien
set_include_path(implode(PATH_SEPARATOR, array(
    dirname(__FILE__).'/library',
    get_include_path(),
)));

//duong dan den thu muc public
define('PUBLIC_PATH', realpath(dirname(__FILE__) . '/../public'));

//duong dan den thu muc file
define('FILE_PATH', PUBLIC_PATH . '/files');

define('IMAGE_PATH', PUBLIC_PATH.'/images');

define('ASSET_IMAGE_PATH', IMAGE_PATH.'/asset_images');

define('USER_IMAGE_PATH', IMAGE_PATH.'/user_images');

define('LIBRARY_PATH', realpath(dirname(__FILE__) . '/../library'));