<?php
class Model_Asset extends Zend_Db_Table{

    protected $_name = 'tbl_user';
    protected $_primary = 'user_id';
    protected $db;
    protected $_filter = null;
    protected $_validate = null;
    protected $_option = null;

    public function init(){
        $this->db = Zend_Registry::get('connectDb');

        $this->_filter = array(
            'asset_id' => array('Int'),
        );

    }

    public function countItem(){
        $select = $this->db->select()
            ->from('tbl_asset', array('COUNT(asset_id)'))
            ->where('is_disabled = 0');
        $result = $this->db->fetchOne($select);
        return $result;

    }

    public function listAssets($group_id){

        //$result = $this->fetchAll($where, $order, $count, $offet);
        $select = $this->db->select('tbl_person.name')
            ->from('tbl_asset')
            ->join('tbl_status','tbl_asset.status=tbl_status.status_id')
            ->join('tbl_state','tbl_asset.state=tbl_state.state_id')
            ->join('tbl_asset_group','tbl_asset.asset_group_id=tbl_asset_group.group_id', array('asset_group'=>'description'))
//            ->join('tbl_borrow', 'tbl_asset.asset_group_id=tbl_asset_group.group_id')
            ->where('tbl_asset.is_disabled = 0')
            ->order('tbl_asset.asset_id DESC');
        if (!empty($group_id)){
            $select->where('tbl_asset.asset_group_id = '.$group_id);
        }

        $result = $this->db->fetchAll($select);
        return $result;
    }
    public function validateAddAssets($arrParam){

        if (!isset($arrParam['id'])){
            $arrParam['id'] = 0;
        }
        $this->_validate = array(
            'name' => array(
                new Zend_Validate_NotEmpty(),
                new Zend_Validate_StringLength(
                    array(
                        'max' => 30
                    )
                ),
                Zend_Filter_Input::MESSAGES => array(
                    array(
                        Zend_Validate_NotEmpty::IS_EMPTY => 'Vui lòng nhập tên tài sản ',
                    ),
                    array(
                        Zend_Validate_StringLength::TOO_LONG => 'Tên tài sản tối đa 30 kí tự ',
                    )
                )
            ),
            'code' => array(
                new Zend_Validate_NotEmpty(),
                new Zend_Validate_StringLength(
                    array(
                        'max' => 20,
                        'min' => 3
                    )
                ),
                new Zend_Validate_Db_NoRecordExists(
                    array(
                        'table' => 'tbl_asset',
                        'field' => 'code',
                        'exclude' => array(
                            "field" => "asset_id",
                            "value" => $arrParam['id']
                        )

                    )

                ),
                Zend_Filter_Input::MESSAGES => array(
                    array(
                        Zend_Validate_NotEmpty::IS_EMPTY => 'Vui lòng nhập mã tài sản ',
                    ),
                    array(
                        Zend_Validate_StringLength::TOO_LONG => 'Mã tài sản tối đa 20 kí tự ',
                        Zend_Validate_StringLength::TOO_SHORT => 'Mã tài sản tối thiểu 3 kí tự ',
                    ),
                    array(
                        Zend_Validate_Db_NoRecordExists::ERROR_RECORD_FOUND=> 'Mã tài sản đã tồn tại',
                    ),
                )
            ),
            'asset_group_id' => array(
                new Zend_Validate_NotEmpty(),
                Zend_Filter_Input::MESSAGES => array(
                    array(
                        Zend_Validate_NotEmpty::IS_EMPTY => 'Vui lòng nhập nhóm tài sản ',
                    )
                ),
            ),
            'status' => array(
                new Zend_Validate_NotEmpty(),
                Zend_Filter_Input::MESSAGES => array(
                    array(
                        Zend_Validate_NotEmpty::IS_EMPTY => 'Vui lòng nhập tình trạng',
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
        if (!empty($arrParam['configuration'])){

            $this->_validate['configuration'] = array(
                new Zend_Validate_StringLength(
                    array(
                        'max' => 255,
                    )
                ),
                Zend_Filter_Input::MESSAGES => array(
                    array(
                        Zend_Validate_StringLength::TOO_LONG => 'Cấu hình tối đa 255 kí tự',
                    )
                ),
            );
        }
        $result = null;
        $input = new Zend_Filter_Input($this->_filter, $this->_validate, $arrParam, $this->_option);

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
    public function addAssets($arrParam){
        $row['name']= $arrParam['name'];
        $row['code']= $arrParam['code'];
        $row['configuration']= $arrParam['configuration'];
        $row['status']= $arrParam['status'];
        $row['asset_group_id']= $arrParam['asset_group_id'];
        $row['state']= 2;
        $row['image']= $arrParam['image'];
        $this->db->insert('tbl_asset', $row);
    }

    public function getAsset($id){
        $select = $this->db->select()
            ->from('tbl_asset')
            ->join('tbl_status','tbl_asset.status=tbl_status.status_id')
            ->join('tbl_state','tbl_asset.state=tbl_state.state_id')
            ->join('tbl_asset_group','tbl_asset.asset_group_id=tbl_asset_group.group_id', array('group_name'=>'description'))
            ->where('tbl_asset.asset_id ='. $id)
            ->where('tbl_asset.is_disabled = 0')
            ->order('tbl_asset.asset_id DESC');

        $result = $this->db->fetchRow($select);

//        $where = 'asset_id = ' . $id;
//        $detail = $this->fetchRow($where)->toArray();
        return $result;
    }

    public function updateAsset($arrParam){

        $where = 'asset_id='.$arrParam['id'];
        $row['name']= $arrParam['name'];
        $row['code']= $arrParam['code'];
        $row['configuration']= $arrParam['configuration'];
        $row['status']= $arrParam['status'];
        $row['asset_group_id']= $arrParam['asset_group_id'];
        if (!empty($arrParam['image'])){
            $row['image']= $arrParam['image'];
        }
        if ($arrParam['status'] ==3){
            $row['state']=5; //mất mát
        }
        $this->db->update('tbl_asset', $row, $where);

    }
    public function deleteAsset($ID){
        $where = 'asset_id= '.$ID;
        $row['is_disabled']=1;
        $row['deleted_at']= date("Y-m-d H:i:s");
        $this->db->update('tbl_asset', $row, $where);
    }
    public function borrow($arrParam){


        //insert vào bảng borrow

        $row['user_id']= $arrParam['borrow_user_id'];
        $row['borrow_date']= date("Y-m-d H:i:s", strtotime($arrParam['borrow_date']));

        $this->db->insert('tbl_borrow', $row);
//        $borrow_id = $this->db->lastInsertId('tbl_borrow', 'borrow_id');

        //get last insert id của borrow
        $select = $this->db->select()
            ->from('tbl_borrow')
            ->order('borrow_id DESC');
        $result = $this->db->fetchRow($select);

        foreach($arrParam["id"] as $item_id) {


            //insert vào bảng borrow detail
            $row_detail['asset_id']= $item_id;
            $row_detail['borrow_id']=  $result['borrow_id'];
            $this->db->insert('tbl_borrow_detail', $row_detail);
//
//
//            //chuyển tài sản thành trạng thái đang sử dụng
            $row_asset['state'] = 1;
            $where = 'asset_id= '.$item_id;
            $this->db->update('tbl_asset', $row_asset, $where);
        }

    }
    public function getCurrentBorrow($asset_id){
        $select = $this->db->select()
            ->from('tbl_borrow_detail')
            ->join('tbl_asset','tbl_borrow_detail.asset_id=tbl_asset.asset_id')
            ->join('tbl_borrow','tbl_borrow_detail.borrow_id=tbl_borrow.borrow_id')
            ->join('tbl_user','tbl_borrow.user_id=tbl_user.user_id', array('borrow_user_name'=>'name'))
            ->where('tbl_asset.asset_id ='. $asset_id)
            ->where('tbl_borrow_detail.status = 0');
        $result = $this->db->fetchRow($select);

        return $result;
    }
    public function getAllBorrow($asset_id){
        $select = $this->db->select()
            ->from('tbl_borrow_detail')
            ->join('tbl_asset','tbl_borrow_detail.asset_id=tbl_asset.asset_id')
            ->join('tbl_borrow','tbl_borrow_detail.borrow_id=tbl_borrow.borrow_id')
            ->join('tbl_user','tbl_borrow.user_id=tbl_user.user_id', array('borrow_user_name'=>'name'))
            ->where('tbl_asset.asset_id ='. $asset_id)
            ->order('borrow_detail_id DESC');

        $result = $this->db->fetchAll($select);


        return $result;
    }
    public function listInventoryAsset($asset_id){
        //$result = $this->fetchAll($where, $order, $count, $offet);
        $sql="";
        foreach($asset_id as $value){
            $sql .= 'tbl_asset.asset_id ='.$value.' or ';
        }
        $sql .= 'tbl_asset.asset_id is Null';
        $select = $this->db->select()
            ->from('tbl_asset')
            ->join('tbl_status','tbl_asset.status=tbl_status.status_id', array('status_name'=>'status_name'))
            ->join('tbl_state','tbl_asset.state=tbl_state.state_id', array('state_name'=>'state_name'))
            ->join('tbl_asset_group','tbl_asset.asset_group_id=tbl_asset_group.group_id', array('asset_group'=>'description'))
            ->where('tbl_asset.is_disabled = 0')
            ->where($sql);

        $result = $this->db->fetchAll($select);
        return $result;
    }
    public function inventory($arrParam){

        //get inventory code
        $select = $this->db->select()
            ->from('tbl_inventory', array('count' => 'count(*)'))
            ->where("inventory_date='".$arrParam['inventory_date']."'");
        $result = $this->db->fetchAll($select);
        $stt_code = $result[0]['count']+1;
        $date_code = date("dm", strtotime($arrParam['inventory_date']));
        $inventory_code = "CTKK-" . $date_code . "-" . $stt_code;

        //insert vào bảng inventory
        $row_inventory['inventory_person_id']= $_SESSION['user_id'];
        $row_inventory['inventory_date']= $arrParam['inventory_date'];
        $row_inventory['note']= $arrParam['inventory_note'];
        $row_inventory['inventory_code']= $inventory_code;

//        $row_inventory['inventory_code'] =
        $this->db->insert('tbl_inventory', $row_inventory);

        //get last insert id của inventory
        $select = $this->db->select()
            ->from('tbl_inventory')
            ->order('inventory_id DESC');

        $result = $this->db->fetchRow($select);
        $inventory_id = $result['inventory_id'];

        //đếm số lượng tài sản cần kiểm kê
        $asset_count = count($arrParam['inventory_asset_id']);
        //dùng vòng lặp
        for($i=0; $i<$asset_count; $i++){
            //insert vào bảng inventory detail
            $row_detail['asset_id'] = $arrParam['inventory_asset_id'][$i];
            $row_detail['before_status'] = $arrParam['before_status'][$i];
            $row_detail['inventory_status'] = $arrParam['inventory_detail_status'][$i];
            $row_detail['note'] = $arrParam['inventory_detail_note'][$i];
            $row_detail['inventory_id'] = $inventory_id;

            $this->db->insert('tbl_inventory_detail', $row_detail);

            //update bảng asset
            $row_asset['status']=$arrParam['inventory_detail_status'][$i];
            //update trạng thái mất
//            if($row_asset['status'] == 3){
//                $row_asset['state'] =5;
//            }
            $where = 'asset_id= '.$arrParam['inventory_asset_id'][$i];
            $this->db->update('tbl_asset', $row_asset, $where);


        }
        return $inventory_id;
    }
    public function countStatusAsset(){
        //$result = $this->fetchAll($where, $order, $count, $offet);
        $select = $this->db->select()
            ->from('tbl_status')
            ->joinLeft('tbl_asset', 'tbl_asset.status=tbl_status.status_id', array('asset_count'=>'COUNT(tbl_asset.asset_id)'))
            ->where('tbl_status.is_delete = 0')
            ->where('(tbl_asset.is_disabled = 0) OR (tbl_asset.is_disabled IS NULL)')
            ->group('tbl_asset.is_disabled')
            ->group('tbl_status.status_id')
            ->order('status_id ASC');

        $result = $this->db->fetchAll($select);
        return $result;

    }
    public function countStateAsset(){
        //$result = $this->fetchAll($where, $order, $count, $offet);
        $select = $this->db->select()
            ->from('tbl_state')
            ->joinLeft('tbl_asset', 'tbl_asset.state=tbl_state.state_id', array('asset_count'=>'COUNT(tbl_asset.asset_id)'))
            ->where('tbl_state.is_delete = 0')
            ->where('(tbl_asset.is_disabled = 0) OR (tbl_asset.is_disabled IS NULL)')
            ->group('tbl_asset.is_disabled')
            ->group('tbl_state.state_id')
            ->order('state_id ASC');

        $result = $this->db->fetchAll($select);
        return $result;

    }
    public function checkInventoryAsset($asset_id){
        $select = $this->db->select()
            ->from('tbl_inventory_detail')
            ->where('asset_id = '.$asset_id);

        $result = $this->db->fetchAll($select);
        return $result;
    }
}