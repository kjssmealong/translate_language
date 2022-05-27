<?php
class LoginController extends Zend_Controller_Action
{
    protected $_arrParam;
    protected $_currentController;
    protected $_actionMain;
    protected $model;

    public function init(){

        $this->_helper->layout->setLayout('layout_admin');

        $this->_arrParam = $this->_request->getParams();
        $this->_currentController = '/' . $this->_arrParam['controller'];
        $this->_actionMain = '/' . $this->_arrParam['controller'] . '/';

        $this->view->arrParam = $this->_arrParam;
        $this->view->currentController = $this->_currentController;
        $this->view->actionMain = $this->_actionMain;

        $this->model = new Model_Menu();


    }

    public function indexAction(){

        $this->_helper->layout->setLayout('layout_login');

//        Gọi kết nối với zendDB
        $db = Zend_Registry::get('connectDb');

        //khởi tạo Zend Auth
        $auth = Zend_Auth::getInstance();
        if($auth->hasIdentity()){
            $this->redirect('/menu');
        }
        //kết nối DB với Zend auth
        $authAdapter = new Zend_Auth_Adapter_DbTable($db);

        //set giá trị trong db để kiểm tra
        $authAdapter->setTableName('tbl_user')
                    ->setIdentityColumn('email')
                    ->setCredentialColumn('password');

        $select = $authAdapter->getDbSelect();
        $select->where('is_disabled = 0');

        if ($this->_request->isPost()){
            try {
                $email = $this->_arrParam['email'];
                $password = md5($this->_arrParam['password']);
                //set giá trị người dùng nhập để kiểm tra
                $authAdapter->setIdentity($email);
                $authAdapter->setCredential($password);

                //truy vấn kết quả
                $result = $auth->authenticate($authAdapter);
                if (!$result->isValid()){
                    //đăng nhập không thành công
                    $this->view->error = "Sai mật khẩu!";
                }else{
                    //đăng nhập thành công
                    $data = $authAdapter->getResultRowObject();
                    $auth->getStorage()->write($data);
                    $info = $auth->getIdentity();
                    $_SESSION['user_id'] = $info->user_id;
                    $_SESSION['role_id'] = $info->role_id;
                    $_SESSION['user_name'] = $info->name;
                    $_SESSION['image'] = $info->image;

                    $this->redirect('/');
                }
            } catch (Exception $e) {
                var_dump($e->getMessage());
            }
        }
    }
    public function checkloginAction(){
        $auth = Zend_Auth::getInstance();
        if($auth->hasIdentity()){
            $info = $auth->getIdentity();
            var_dump($info);
            echo 'bạn đã login rồi';
        }else{
            echo 'bạn chưa login';
        }
        $this->_helper->viewRenderer->setNoRender();
    }
    public function logoutAction(){
        $auth = Zend_Auth::getInstance();
        $auth->clearIdentity();
        $this->_redirect('/login');
        session_destroy();
        $this->_helper->viewRenderer->setNoRender();
    }
}