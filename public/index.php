<?php
include_once 'define.php';

set_include_path(APPLICATION_PATH . '/../library');

require_once 'Zend/Application.php' ;
$application = new Zend_Application(
    APPLICATION_ENV,
    APPLICATION_PATH . '/configs/application.ini'
);

require_once APPLICATION_PATH.'/Smarty_View.php';

require_once 'Zend/Controller/Front.php';
require_once 'Zend/Controller/Action/Helper/ViewRenderer.php';

$front = Zend_Controller_Front::getInstance();

$config_app = $application->bootstrap()->getOptions();

$view = new Smarty_View($config_app['smarty']);

$render = new Zend_Controller_Action_Helper_ViewRenderer($view);

$render->setViewBasePathSpec(APPLICATION_PATH . '/layouts/scripts')
    ->setViewScriptPathSpec(':controller/:action.:suffix')
    ->setViewScriptPathNoControllerSpec(':action.:suffix')
    ->setViewSuffix('tpl');

Zend_Controller_Action_HelperBroker::addHelper($render);

$layout = Zend_Layout::startMvc(
    array(
        'layoutPath' => APPLICATION_PATH . '/layouts/scripts',
        'layout' => 'layout',
        'contentKey' => 'content'
    )
);
$layout->setViewSuffix('tpl');
Zend_Session::start();

$front->dispatch();
