<?php
class AccountController extends Zend_Controller_Action
{
    protected $_arrParam;
    protected $_currentController;
    protected $_actionMain;
    protected $model;
    protected $account_id;

    public function init(){

        $auth = Zend_Auth::getInstance();
        if(!$auth->hasIdentity()){
            $this->redirect('/login');
        }
        $this->account_id = $auth->getIdentity()->user_id;


        $this->_helper->layout->setLayout('layout_admin');

        $this->_arrParam = $this->_request->getParams();
        $this->_currentController = '/' . $this->_arrParam['controller'];
        $this->_actionMain = '/' . $this->_arrParam['controller'] . '/';

        $this->view->arrParam = $this->_arrParam;
        $this->view->currentController = $this->_currentController;
        $this->view->actionMain = $this->_actionMain;

        $this->model = new Model_User;
    }

    public function indexAction(){
        //lấy giá trị arrParam từ request


        $arrParam = $this->_arrParam;

        //lấy dữ liệu
        $this->view->user = $this->model->getUser($this->account_id);

        if(empty($this->view->user)){
            $this->redirect('/');
        }

        $this->view->all_borrow_asset = $this->model->getBorrowAsset($this->account_id);

        if (isset($_SESSION['message'])) {
            $this->view->message = $_SESSION['message'];
            unset( $_SESSION['message'] );
        }

    }
    public function changePasswordAction(){
        $arrParam = $this->_arrParam;
        $old_password = $arrParam['old_password'];
        $new_password = $arrParam['new_password'];
        $re_password = $arrParam['re_password'];
        $this->model->getPassword($arrParam['user_id']);
        if ($new_password==$re_password){
            if ($this->model->getPassword($arrParam['user_id']) == md5($old_password)){

                $change_password = $this->model->changePassword($arrParam);

                if ($change_password===true)
                {
                    echo 'abc';
                }
                else{
                    $error_input = ['error_input' => $change_password];
                }
            }
            else {
                $error_input = ['error_input' => "Bạn nhập sai mật khẩu!"];
            }
        }
        else {
            $error_input = ['error_input' => "Mật khẩu không khớp!"];
        }
        if (isset($error_input)) {
            $this->_helper->json->sendJson($error_input);
        }
        exit();
    }
    public function updateAction(){
        //lấy giá trị arrParam từ request
        $arrParam = $this->_arrParam;
        $arrParam["id"] = $_SESSION['user_id'];
        //lây dữ liệu từ các bảng khóa ngoại
        $role = new Model_Role();
        $this->view->role_list = $role->listRole();

        //lấy dữ liệu
        $this->view->user = $this->model->getUser($arrParam["id"]);

        if ($this->_request->isPost()) {
            //xử lý image
            $file_adapter = new Zend_File_Transfer_Adapter_Http();
            $file_adapter->setDestination(USER_IMAGE_PATH);

            //lấy giá trị image
            $file_upload = $file_adapter->getFileInfo();
            if ($file_upload['image']['name'])
            {
                $arrParam['image']=$file_upload['image']['name'];
                //validate for image
                $size_validator = new Zend_Validate_File_Size(array('max' => '1000KB'));
                $size_validator->setMessage('Dung lượng ảnh quá lớn', Zend_Validate_File_Size::TOO_BIG);

                $exist_validator = new Zend_Validate_File_Upload;
                $exist_validator->setMessage('Vui lòng chọn ảnh');

                $extension_validator = new Zend_Validate_File_Extension('jpg,png,gif');
                $extension_validator->setMessage('Sai định dạng hình ảnh', Zend_Validate_File_Extension::FALSE_EXTENSION);

                $file_adapter->addValidator($size_validator);
                $file_adapter->addValidator($exist_validator);
                $file_adapter->addValidator($extension_validator);

            }

            $user_update = $this->model->updateUser($arrParam);

            //get error input
            if ($user_update === true){
                if ($file_upload['image']['name']) {
                    if ($file_adapter->isValid()) {
                        $file_adapter->receive();
                    } else {
                        $error_input['image'] = $file_adapter->getMessages();
                    }
                }
            }
            else{
                $error_input = $user_update;
            }

            // nếu không có error input thì thông báo thành công, không thì trả ra view error input
            if (empty($error_input)){
                $_SESSION['message'] = 'Cập nhật người dùng thành công!';
                $this->redirect('/account');
            }
            else {
                $this->view->error_input = $error_input;
            }

        }
    }
}