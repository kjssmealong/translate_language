<?php
class GroupController extends Zend_Controller_Action
{
    protected $_arrParam;
    protected $_currentController;
    protected $_actionMain;
    protected $model;

    public function init(){

        //kiểm tra auth
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

        $this->model = new Model_Menu;

        if($_SESSION['role_id']==3){
            $this->redirect('/');
        }
    }

    //liệt kê dữ liệu trong db
    public function indexAction(){

        $this->view->title = "Nhóm tài sản";
        $this->view->menu_list = $this->model->listallItems();

        if (isset($_SESSION['message'])) {
            $this->view->message = $_SESSION['message'];
            unset($_SESSION['message']);
        }
    }

    //thêm dữ liệu vào db
    public function addAction(){
        try {
            //lấy giá trị arrParam từ request
            $arrParam = $this->_arrParam;
            //validation
            $description_add = $arrParam['description'];
            $validator = new Zend_Validate_NotEmpty();
            $exist_validator = new Zend_Validate_Db_NoRecordExists(
                array(
                    'table' => 'tbl_asset_group',
                    'field' => 'description',
                )
            );
            if($validator->isValid($description_add)) {
                if($exist_validator->isValid($description_add)){
                    $id = $this->model->addItem($arrParam);
                    $id_insert = ['id_insert'=> $id];
                    $_SESSION['message'] = 'Thêm dữ liệu thành công!';
                    $this->_helper->json->sendJson($id_insert);
                }
                else {
                    $error_input = ['error_input'=> "Tên nhóm tài sản đã tồn tại!"];
                    $this->_helper->json->sendJson($error_input);
                };
            }
            else{
                $error_input = ['error_input'=> "Vui lòng nhập tên nhóm tài sản!"];
                $this->_helper->json->sendJson($error_input);
            }

        } catch (Exception $e) {
            var_dump($e->getMessage());
        }
    }

    //cập nhật dữ liệu trong db
    public function updateAction(){

        //lấy giá trị arrParam từ request
        $arrParam = $this->_arrParam;

        try {
            //validation
            $description_update = $arrParam['description'];
            $validator = new Zend_Validate_NotEmpty();
            if($validator->isValid($description_update)) {
                $this->model->updateItem($arrParam);
            }
            else{
                $error_input = ['error_input'=> "Vui lòng nhập tên nhóm tài sản!"];
                $this->_helper->json->sendJson($error_input);
            };
        } catch (Exception $e) {
            var_dump($e->getMessage());
        }
    }

    //xóa dữ liệu trong db
    public function deleteAction(){

        //lấy giá trị arrParam từ request
        $arrParam = $this->_arrParam;

        try {
            //delete item
            if ($arrParam["asset_count"]>0){
                $error_input = ['error_input'=> "Xóa nhóm tài sản không thành công!"];
                $this->_helper->json->sendJson($error_input);
            }
            else {
                $this->model->deleteItem($arrParam["id"]);
            }
        } catch (Exception $e) {
            var_dump($e->getMessage());
        }
    }

    //xóa nhiều dữ liệu trong db
    public function multideleteAction(){

        //lấy giá trị arrParam từ request
        $arrParam = $this->_arrParam;
        //delete items
        try {
            foreach($arrParam["asset_count"] as $item_assetcount)
            {
                if($item_assetcount > 0){
                    $error = 1;
                }
            }
            if (isset($error)){
                $error_input = ['error_input'=> "Xóa nhóm tài sản không thành công!"];
                $this->_helper->json->sendJson($error_input);
            }
            else {
                foreach($arrParam["id"] as $item_id)
                {
                    $this->model->deleteItem($item_id);
                }
            }
        } catch (Exception $e) {
            var_dump($e->getMessage());
        }
    }

    //tìm kiếm dữ liệu
    public function searchAction(){

        $this->view->title = "Nhóm tài sản thông tin";

        $arrParam = $this->_arrParam;

        $this->view->menu_list = $this->model->searchItem( $arrParam["key"]);

    }

}