<?php
class TrainingController extends Zend_Controller_Action
{
    protected $_arrParam;
    protected $_currentController;
    protected $_actionMain;
    protected $model;

    public function init(){

        $this->_helper->layout->setLayout('layout_admin');

        $this->_arrParam = $this->_request->getParams();
        $this->_currentController = '/' . $this->_arrParam['controller'];
        $this->_actionMain = '/' . $this->_arrParam['controller'] . '/list';

        $this->view->arrParam = $this->_arrParam;
        $this->view->currentController = $this->_currentController;
        $this->view->actionMain = $this->_actionMain;

        $this->model = new Model_Student;
    }
    public function indexAction(){
        $this->view->Title = 'Training';
        $this->model->test();

    }
    public function listAction(){
        $this->view->Title = 'Danh sách học sinh';
        $students = $this->model->listItems();
        $this->view->assign('list_student', $students);
    }
    public function addAction(){
        $this->view->Title = 'Thêm học sinh';
        if ($this->_request->isPost()) {
            $validator = new Zend_Validate_NotEmpty();
            $arrParam = $this->_arrParam;
            if ($validator->isValid($arrParam['name'])) {
                $this->model->addItem($arrParam);
                $this->_redirect($this->_actionMain);
            }
            else {
                $messages = $validator->getMessages();
                echo current($messages);
            }
        }
    }
    public function updateAction(){
        $this->view->Title = 'Cập nhật học sinh';
        $id = $this->_request->id;
        $student_model = $this->model->getItem($id);
        $this->view->assign('item_student', $student_model);

        if ($this->_request->isPost()) {
            $arrParam = $this->_arrParam;
            $this->model->updateItem($arrParam);
            $this->_redirect($this->_actionMain);
        }
    }
    public function deleteAction(){
        $id = $this->_request->id;
        $this->_helper->viewRenderer->setNoRender(true);
        $this->model->deleteItem($id);
        $this->_redirect($this->_actionMain);
    }
    public function validatelongAction(){
        // kiểm tra chiều dài 1 chuỗi
        $input = "ThiDDdddddddddddĐ";
        $validator = new Zend_Validate_StringLength(5, 10);
//        $validator->setMessages(array(
//            Zend_Validate_StringLength::TOO_SHORT=>'Chuỗi này quá ngắn',
//            Zend_Validate_StringLength::TOO_LONG=>'Chuỗi này quá dài',
//        ));

        if(!$validator->isValid($input)) {
            $messages = $validator->getMessages();
            echo current($messages);
        }
    }
    public function validateEmptyAction(){
        // kiểm tra chiều dài 1 chuỗi
        $input = "";
        $validator = new Zend_Validate_NotEmpty();
//        $validator->setMessages(array(
//            Zend_Validate_StringLength::TOO_SHORT=>'Chuỗi này quá ngắn',
//            Zend_Validate_StringLength::TOO_LONG=>'Chuỗi này quá dài',
//        ));

        if(!$validator->isValid($input)) {
            $messages = $validator->getMessages();
            echo current($messages);
        }
    }
    public function filterAction(){
        $str = 'Truong~!@#$%%^&&&&&*()1234';
        $filter = new Zend_Filter_Alnum(true);
        $result = $filter->filter($str);
        $ss = new Zend_Session_Namespace('cart');
        echo $ss->name;
        echo $result;
    }
    public function sessionsAction(){
        $ss = new Zend_Session_Namespace('cart');
        $ss->ID = 5;
        $ss->name ="Trường";
        echo $ss->ID;
        echo $ss->name;

        //lưu session trong vòng 5 giây
        $ss->setExpirationSeconds(5, $ss->name);
        //xóa session
        //$ss->unsetAll();
    }
    public function fileAction(){
        if($this->_request->ispost()){
            $upload = new Zend_File_Transfer_Adapter_Http();
            //$info = $upload->getFileInfo();

        }
    }
}