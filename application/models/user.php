<?php
class Model_User extends Zend_Db_Table{

    protected $_name = 'tbl_user';
    protected $_primary = 'user_id';
    protected $db;
    protected $_filter = null;
    protected $_validate = null;
    protected $_option = null;

    public function init(){
        $this->db = Zend_Registry::get('connectDb');

        $this->_filter = array(
            'user_id' => array('Int'),
        );
    }

    public function countUsers(){
        $select = $this->db->select()
            ->from('tbl_user', array('COUNT(user_id)'))
            ->where('is_disabled = 0');
        $result = $this->db->fetchOne($select);
        return $result;

    }

    public function listUsers(){
        //$result = $this->fetchAll($where, $order, $count, $offet);
        $select = $this->db->select()
            ->from('tbl_user')
            ->join('tbl_roles','tbl_user.role_id=tbl_roles.role_id', array('role_name'=>'name'))
            ->where('tbl_user.is_disabled = 0')
            ->order('tbl_user.user_id DESC');
        $result = $this->db->fetchAll($select);
        return $result;
    }
    public function addUser($arrParam){

        $arrParam['password'] = md5($arrParam['password']);

        $row['name']= $arrParam['name'];
        $row['phone']= $arrParam['phone'];
        $row['email']= $arrParam['email'];
        $row['password']= $arrParam['password'];
        $row['role_id']= $arrParam['role'];
        $row['image']= $arrParam['image'];
        $this->db->insert('tbl_user', $row);

    }

    public function getUser($id){
        $select = $this->db->select()
            ->from('tbl_user')
            ->join('tbl_roles','tbl_user.role_id=tbl_roles.role_id', array('user_role'=>'name'))
            ->where('tbl_user.user_id ='. $id)
            ->where('tbl_user.is_disabled = 0')
            ->order('tbl_user.user_id DESC');
        $result = $this->db->fetchRow($select);
        return $result;
    }
    public function updateUser($arrParam){

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
                        Zend_Validate_NotEmpty::IS_EMPTY => 'Vui l??ng nh???p t??n ng?????i d??ng',
                    ),
                    array(
                        Zend_Validate_StringLength::TOO_LONG => 'T??n ng?????i d??ng t???i ??a 30 k?? t???',
                        Zend_Validate_StringLength::TOO_SHORT => 'T??n ng?????i d??ng t???i thi???u 3 k?? t???',
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
                        Zend_Validate_NotEmpty::IS_EMPTY => 'Vui l??ng nh???p email'
                    ),
                    array(
                        Zend_Validate_EmailAddress::INVALID => 'Kh??ng nh???n d???ng ???????c email',
                        Zend_Validate_EmailAddress::INVALID_FORMAT => 'Vui l??ng nh???p ????ng ?????nh d???ng email',
                        Zend_Validate_EmailAddress::INVALID_HOSTNAME => 'Vui l??ng nh???p ????ng ?????nh d???ng email',
                    ),
                    array(
                        Zend_Validate_Db_NoRecordExists::ERROR_RECORD_FOUND => 'Email ???? t???n t???i'
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
                        Zend_Validate_Digits::NOT_DIGITS => 'S??? ??i???n tho???i kh??ng ????ng ?????nh d???ng'
                    ),
                    array(
                        Zend_Validate_NotEmpty::IS_EMPTY => 'Vui l??ng nh???p s??? ??i???n tho???i'
                    ),
                    array(
                        Zend_Validate_Db_NoRecordExists::ERROR_RECORD_FOUND => 'S??? ??i???n tho???i ???? ???????c ????ng k??'
                    ),
                    array(
                        Zend_Validate_StringLength::TOO_LONG => 'S??? ??i???n tho???i t???i ??a 11 k?? t???',
                        Zend_Validate_StringLength::TOO_SHORT => 'S??? ??i???n tho???i t???i thi???u 9 k?? t???'
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
                        Zend_Validate_NotEmpty::IS_EMPTY => 'Vui l??ng nh???p m???t kh???u'
                    ),
                    array(
                        Zend_Validate_StringLength::TOO_LONG => 'M???t kh???u t???i ??a 20 k?? t???',
                        Zend_Validate_StringLength::TOO_SHORT => 'M???t kh???u t???i thi???u 3 k?? t???'
                    ),
                    array(
                        Zend_Validate_Regex::NOT_MATCH => 'Vui l??ng ch??? s??? d???ng ch??? c??i, s??? v?? k?? t??? ch???m c??u th?????ng g???p '
                    )
                )
            ),
            'role' => array(
                new Zend_Validate_NotEmpty(),
                Zend_Filter_Input::MESSAGES => array(
                    array(
                        Zend_Validate_NotEmpty::IS_EMPTY => 'Vui l??ng nh???p vai tr?? ng?????i d??ng',
                    )
                ),
            ),
        );

        $result = null;
        $input = new Zend_Filter_Input($this->_filter, $this->_validate, $arrParam, $this->_option);
        if ($input->isValid()){
            $where = 'user_id='.$arrParam['id'];
            $row['name']= $arrParam['name'];
            $row['phone']= $arrParam['phone'];
            $row['email']= $arrParam['email'];
            $row['role_id']= $arrParam['role'];

            if (!empty($arrParam['image'])){
                $row['image']= $arrParam['image'];
            }

            $this->db->update('tbl_user', $row, $where);
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
    public function deleteUser($ID){
        $where = 'user_id= '.$ID;
        $row['is_disabled']=1;
        $row['deleted_at']= date("Y-m-d H:i:s");
        $this->db->update('tbl_user', $row, $where);
    }
    public function getBorrowAsset($user_id){
        $select = $this->db->select()
            ->from('tbl_borrow_detail')
            ->join('tbl_borrow','tbl_borrow_detail.borrow_id=tbl_borrow.borrow_id')
            ->join('tbl_asset','tbl_borrow_detail.asset_id=tbl_asset.asset_id', array('borrow_asset_name'=>'name'))
            ->where('tbl_borrow.user_id ='. $user_id)
            ->where('tbl_borrow_detail.return_date IS NULL')
            ->where('tbl_asset.is_disabled = 0')
//            ->where('tbl_asset.is_disabled = 0')
            ->order('tbl_borrow_detail.borrow_detail_id DESC');

        $result = $this->db->fetchAll($select);

        return $result;
    }
    public function returnAsset($arrParam){

        //update v??o b???ng m?????n

        foreach($arrParam["borrow_detail_id"] as $borrow_detail_id)
        {
            $row['return_date']= date("Y-m-d H:i:s");
            $row['status']=1;
            $where = 'borrow_detail_id= '.$borrow_detail_id;

            $this->db->update('tbl_borrow_detail', $row, $where);
        }

    }
    public function updateAssetState($asset_id){

        $row['state'] = 2;
        $where = 'asset_id= '.$asset_id;
        $this->db->update('tbl_asset', $row, $where);
    }

    public function getPassword($user_id){
        $select = $this->db->select()
            ->from('tbl_user')
            ->where('tbl_user.user_id ='. $user_id);
        $result = $this->db->fetchRow($select);
        return $result['password'];
    }
    public function changePassword($arrParam){

        $this->_validate = array(
            'new_password' => array(
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
                        Zend_Validate_NotEmpty::IS_EMPTY => 'Vui l??ng nh???p m???t kh???u'
                    ),
                    array(
                        Zend_Validate_StringLength::TOO_LONG => 'M???t kh???u t???i ??a 20 k?? t???',
                        Zend_Validate_StringLength::TOO_SHORT => 'M???t kh???u t???i thi???u 3 k?? t???'
                    ),
                    array(
                        Zend_Validate_Regex::NOT_MATCH => 'Vui l??ng ch??? s??? d???ng ch??? c??i, s??? v?? k?? t??? ch???m c??u th?????ng g???p '
                    )
                )
            ),
        );
        $result = null;
        $input = new Zend_Filter_Input($this->_filter, $this->_validate, $arrParam, $this->_option);
        if ($input->isValid()){
//            echo 'abc';
            $row['password'] = md5($arrParam['new_password']);
            $where = 'user_id= '.$arrParam['user_id'];
            $this->db->update('tbl_user', $row, $where);
            $result = true;
        }
        else {
            if ($input->hasInvalid() || $input->hasMissing()) {
                $messages = $input->getMessages();
                foreach($messages as $key=>$message_value){
                    foreach($message_value as $key=>$value){
                        $result = $value;
                    }
                }
            }
        }
        return $result;
    }
}