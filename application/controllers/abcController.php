<?php
class abcController extends Zend_Controller_Action
{
    public function init()
    {
        $this->_helper->layout->setLayout('layout_admin');
        parent::init(); // TODO: Change the autogenerated stub
    }

    public function indexAction()
    {
//        $model = new Model_Test;
//        $model->test();
        var_dump('bc');
    }

    public function abcAction()
    {

    }
}