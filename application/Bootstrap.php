<?php

class Bootstrap extends Zend_Application_Bootstrap_Bootstrap
{
    protected function _initAutoload()
    {
        $arrConfig = array(
            'namespace' => '',
            'basePath' => APPLICATION_PATH,
        );
        $autoload = new Zend_Application_Module_Autoloader($arrConfig);
        return $autoload;
    }
    protected function _initSession(){
        //session_start();
        Zend_Session::start();
    }
    protected function _initDb()
    {

        $optionResources = $this->getOption('resources');
        $dbOption = $optionResources['db'];

        $dbOption['params']['username'] = 'postgres';
        $dbOption['params']['password'] = 'truong123';
//        $dbOption['params']['port'] = '123';
        $dbOption['params']['dbname'] = 'n-truong';
        $dbOption['params']['host'] = 'localhost';

        $adapter = $dbOption['adapter'];
        $config = $dbOption['params'];
        $db = Zend_Db::factory($adapter, $config);
        $db->setFetchMode(Zend_Db::FETCH_ASSOC);
//        $db->query("SET NAMES 'utf8'");
//        $db->query("SET CHARACTER SET 'utf8'");

        Zend_Registry::set('connectDb', $db);

        Zend_Db_Table::setDefaultAdapter($db);

        return $db;
    }
}
