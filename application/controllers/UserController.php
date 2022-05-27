<?php
class UserController extends Zend_Controller_Action
{
    protected $_arrParam;
    protected $_currentController;
    protected $_actionMain;
    protected $model;


    public function init(){

        $auth = Zend_Auth::getInstance();
        if(!$auth->hasIdentity()){
            $this->redirect('/login');
        }
        $this->_helper->layout->setLayout('layout_admin');

        $this->_arrParam = $this->_request->getParams();
        $this->_currentController = '/' . $this->_arrParam['controller'];
        $this->_actionMain = '/' . $this->_arrParam['controller'] . '/';

        $this->view->arrParam = $this->_arrParam;
        $this->view->currentController = $this->_currentController;
        $this->view->actionMain = $this->_actionMain;

        $this->model = new Model_User;

        if($_SESSION['role_id']==3){
            $this->redirect('/');
        }

    }

    //liệt kê dữ liệu trong db
    public function indexAction(){

        $this->view->title = "Quản lý người dùng";
        $this->view->user_list = $this->model->listUsers();
        if (isset($_SESSION['message'])) {
            $this->view->message = $_SESSION['message'];
            unset( $_SESSION['message'] );
        }
        if (isset($_SESSION['alert'])) {
            $this->view->message = $_SESSION['alert'];
            unset( $_SESSION['alert'] );
        }
    }

    //thêm dữ liệu vào db
    public function addAction(){

        //lấy giá trị arrParam từ request
        $arrParam = $this->_arrParam;
        //lấy danh sách từ các bảng con
        $role = new Model_Role();
        $this->view->role_list = $role->listRole();

        if ($this->_request->isPost()) {
            try {
                //xử lý image
                $file_adapter = new Zend_File_Transfer_Adapter_Http();
                $file_adapter->setDestination(USER_IMAGE_PATH);

                //validate for image
                $size_validator = new Zend_Validate_File_Size(array('max' => '10MB'));
                $size_validator->setMessage('*Dung lượng ảnh quá lớn', Zend_Validate_File_Size::TOO_BIG);
                $upload_validator = new Zend_Validate_File_Upload;
                $upload_validator->setMessage('*Vui lòng chọn ảnh');
                $extension_validator = new Zend_Validate_File_Extension('jpg,png,gif');
                $extension_validator->setMessage('Sai định dạng hình ảnh', Zend_Validate_File_Extension::FALSE_EXTENSION);

                $file_adapter->addValidator($size_validator);
                $file_adapter->addValidator($upload_validator);
                $file_adapter->addValidator($extension_validator);

                //lấy giá trị image
                $file_upload = $file_adapter->getFileInfo();
                $arrParam['image']=$file_upload['image']['name'];

                //get error input

                if($file_adapter->isValid() && $this->validate($arrParam)===true){
                    $file_adapter->receive();
                    $this->model->addUser($arrParam);
                }
                else{
                    if ($this->validate($arrParam)!==true) {
                        $error_input = $this->validate($arrParam);
                    }
                    $error_input['image'] = $file_adapter->getMessages();
                }


                // nếu không có error input thì thông báo thành công, không thì trả ra view error input
                if (empty($error_input)){
                    $_SESSION['message'] = 'Thêm người dùng thành công!';
                    $this->redirect('/user');
                }
                else {
                    $this->view->error_input = $error_input;
                    $this->view->name= $arrParam['name'];
                    $this->view->phone= $arrParam['phone'];
                    $this->view->email= $arrParam['email'];
                    $this->view->password= $arrParam['password'];
                    $this->view->role= $arrParam['role'];

                }
            } catch (Exception $e) {
                var_dump($e->getMessage());
            }
        }
    }

    //cập nhật dữ liệu trong db
    public function updateAction(){

        //lấy giá trị arrParam từ request
        $arrParam = $this->_arrParam;

        //lây dữ liệu từ các bảng khóa ngoại
        $role = new Model_Role();
        $this->view->role_list = $role->listRole();

        //lấy dữ liệu
        $this->view->user = $this->model->getUser($arrParam["id"]);

        if(empty($this->view->user)){
            $this->redirect('/user');
        }

        if ($this->_request->isPost()) {
            try {
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

                if ($file_upload['image']['name']) {
                    if ($file_adapter->isValid() && ($this->validate($arrParam)===true )) {
                        $this->model->updateUser($arrParam);
                        $file_adapter->receive();
                    }
                    else{
                        if($this->validate($arrParam)!==true) {
                            $error_input = $this->validate($arrParam);
                        }
                        $error_input['image'] = $file_adapter->getMessages();
                    }
                }
                else{
                    if ($this->validate($arrParam)===true ) {
                        $this->model->updateUser($arrParam);
                    }
                    else{
                        $error_input = $this->validate($arrParam);
                    }
                }

                // nếu không có error input thì thông báo thành công, không thì trả ra view error input
                if (empty($error_input)){
                    $_SESSION['message'] = 'Cập nhật người dùng thành công!';
                    $this->redirect('/user');
                }
                else {
                    $this->view->error_input = $error_input;
                    $this->view->name= $arrParam['name'];
                    $this->view->phone= $arrParam['phone'];
                    $this->view->email= $arrParam['email'];
                    $this->view->role= $arrParam['role'];
                }
            } catch (Exception $e) {
                var_dump($e->getMessage());
            }
        }
    }

    //xóa dữ liệu trong db
    public function deleteAction(){

        //lấy giá trị arrParam từ request
        $arrParam = $this->_arrParam;

        //delete item
        try {
            if ($this->model->getBorrowAsset($arrParam["id"])){
                $_SESSION['alert'] = "Xóa người dùng không thành công";
                $error_input = ['error_input'=> "Xóa người dùng không thành công!"];
                $this->redirect('/user/detail/id/'.$arrParam["id"]);
                $this->_helper->json->sendJson($error_input);
            }
            else{
                $this->model->deleteUser($arrParam["id"]);
                $_SESSION['message'] = 'Xóa người dùng thành công!';
                $this->redirect('/user');
            }
        } catch (Exception $e) {
            var_dump($e->getMessage());
        }
    }

    //xóa nhiều dữ liệu trong db
    public function multideleteAction(){

        //lấy giá trị arrParam từ request
        $arrParam = $this->_arrParam;

        try {
        //kiểm tra người dùng có mượn tài sản không
            foreach($arrParam["id"] as $item_id)
            {
                if ($this->model->getBorrowAsset($item_id)){
                    $error = true;
                }
            }
            //kiểm tra error
            if (!isset($error)){
                foreach($arrParam["id"] as $item_id)
                {
                    //delete items
                    $this->model->deleteUser($item_id);
                }
            }
            else{
                //nếu có lỗi thì báo cho người dùng
                $error_input = ['error_input'=> "Xóa người dùng không thành công!"];
                $this->_helper->json->sendJson($error_input);
            }
        } catch (Exception $e) {
            var_dump($e->getMessage());
        }
    }

    //chi tiết dữ liệu
    public function detailAction(){

        //lấy giá trị arrParam từ request
        $arrParam = $this->_arrParam;

        //lấy dữ liệu
        $this->view->user = $this->model->getUser($arrParam["id"]);

        if(empty($this->view->user)){
            $this->redirect('/user');
        }

        $this->view->all_borrow_asset = $this->model->getBorrowAsset($arrParam["id"]);

        if (isset($_SESSION['message'])) {
            $this->view->message = $_SESSION['message'];
            unset($_SESSION['message'] );
        }
        if (isset($_SESSION['alert'])) {
            $this->view->alert = $_SESSION['alert'];
            unset($_SESSION['alert'] );
        }
        
    }
    public function returnAssetAction(){

        //lấy giá trị arrParam từ request
        $arrParam = $this->_arrParam;
        //lấy dữ liệu
        var_dump($arrParam);
        try {
            $this->model->returnAsset($arrParam);

            foreach($arrParam["asset_id"] as $asset_id)
            {
                $this->model->updateAssetState($asset_id);
            }
        } catch (Exception $e) {
            var_dump($e->getMessage());
        }
    }
    public function validate($arrParam){

        if (!isset($arrParam['id'])){
            $arrParam['id'] = 0;
        }

        $this->_validate = array(
            'name' => array(
                new Zend_Validate_NotEmpty(),
                new Zend_Validate_StringLength(
                    array(
                        'min' =>3,
                        'max' => 30
                    )
                ),
                'breakChainOnFailure' => true,
                Zend_Filter_Input::MESSAGES => array(
                    array(
                        Zend_Validate_NotEmpty::IS_EMPTY => 'Vui lòng nhập tên người dùng',
                    ),
                    array(
                        Zend_Validate_StringLength::TOO_LONG => 'Tên người dùng tối đa 30 kí tự',
                        Zend_Validate_StringLength::TOO_SHORT => 'Tên người dùng tối thiểu 3 kí tự',
                    )
                )
            ),
            'email' => array(
                new Zend_Validate_NotEmpty(),
                new Zend_Validate_EmailAddress(),
                new Zend_Validate_Db_NoRecordExists(
                    array(
                        'table' => 'tbl_user',
                        'field' => 'email',
                        'exclude' => array(
                            "field" => "user_id",
                            "value" => $arrParam['id']
                        )
                    )
                ),
                'breakChainOnFailure' => true,
                Zend_Filter_Input::MESSAGES => array(
                    array(
                        Zend_Validate_NotEmpty::IS_EMPTY => 'Vui lòng nhập email'
                    ),
                    array(
                        Zend_Validate_EmailAddress::INVALID => 'Không nhận dạng được email',
                        Zend_Validate_EmailAddress::INVALID_FORMAT => 'Vui lòng nhập đúng định dạng email',
                        Zend_Validate_EmailAddress::INVALID_HOSTNAME => 'Vui lòng nhập đúng định dạng email',
                    ),
                    array(
                        Zend_Validate_Db_NoRecordExists::ERROR_RECORD_FOUND => 'Email đã tồn tại'
                    )
                )
            ),

            'phone' => array(
                new Zend_Validate_Digits,
                new Zend_Validate_NotEmpty(),
                new Zend_Validate_Db_NoRecordExists(
                    array(
                        'table' => 'tbl_user',
                        'field' => 'phone',
                        'exclude' => array(
                            "field" => "user_id",
                            "value" => $arrParam['id']
                        )
                    )
                ),
                new Zend_Validate_StringLength(
                    array(
                        'min' => 10,
                        'max' => 11
                    )
                ),
                'breakChainOnFailure' => true,
                Zend_Filter_Input::MESSAGES => array(
                    array(
                        Zend_Validate_Digits::NOT_DIGITS => 'Số điện thoại không đúng định dạng'
                    ),
                    array(
                        Zend_Validate_NotEmpty::IS_EMPTY => 'Vui lòng nhập số điện thoại'
                    ),
                    array(
                        Zend_Validate_Db_NoRecordExists::ERROR_RECORD_FOUND => 'Số điện thoại đã được đăng ký'
                    ),
                    array(
                        Zend_Validate_StringLength::TOO_LONG => 'Số điện thoại tối đa 11 kí tự',
                        Zend_Validate_StringLength::TOO_SHORT => 'Số điện thoại tối thiểu 9 kí tự'
                    )

                )
            ),
//
            'password' => array(
                new Zend_Validate_NotEmpty(),
                new Zend_Validate_StringLength(
                    array(
                        'min' => 3,
                        'max' => 20
                    )
                ),
                new Zend_Validate_Regex('/^[a-zA-Z0-9_!@#$&*\/]+$/'),
                'breakChainOnFailure' => true,
                Zend_Filter_Input::MESSAGES => array(
                    array(
                        Zend_Validate_NotEmpty::IS_EMPTY => 'Vui lòng nhập mật khẩu'
                    ),
                    array(
                        Zend_Validate_StringLength::TOO_LONG => 'Mật khẩu tối đa 20 kí tự',
                        Zend_Validate_StringLength::TOO_SHORT => 'Mật khẩu tối thiểu 3 kí tự'
                    ),
                    array(
                        Zend_Validate_Regex::NOT_MATCH => 'Vui lòng chỉ sử dụng chữ cái, số và ký tự chấm câu thường gặp '
                    )
                )
            ),
            'role' => array(
                new Zend_Validate_NotEmpty(),
                Zend_Filter_Input::MESSAGES => array(
                    array(
                        Zend_Validate_NotEmpty::IS_EMPTY => 'Vui lòng nhập vai trò người dùng',
                    )
                ),
            ),
            'image-check' => array(
                new Zend_Validate_NotEmpty(),
                Zend_Filter_Input::MESSAGES => array(
                    array(
                        Zend_Validate_NotEmpty::IS_EMPTY => 'Vui lòng chọn hình ảnh',
                    )
                ),
            ),
        );

        $result = null;
        $_filter = array(
            'user_id' => array('Int'),
        );
        $input = new Zend_Filter_Input($_filter, $this->_validate, $arrParam, NULL);

        if ($input->isValid()){
            $result = true;
        }
        else {
            if ($input->hasInvalid() || $input->hasMissing()) {
                $messages = $input->getMessages();
                $result = $messages;
            }
        }
        return $result;

    }
}