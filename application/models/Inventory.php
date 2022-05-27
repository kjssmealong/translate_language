<?php
class Model_Inventory extends Zend_Db_Table{

    protected $_name = 'tbl_inventory';
    protected $_primary = 'inventory_id';
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
    //đếm số kiểm kê
    public function countInventory(){
        $select = $this->db->select()
            ->from('tbl_inventory', array('COUNT(inventory_id)'));
        $result = $this->db->fetchOne($select);
        return $result;
    }

    //hiển thị danh sách kiểm kê
    public function listInventory(){
        $select = $this->db->select()
            ->from('tbl_inventory')
            ->join('tbl_user','tbl_inventory.inventory_person_id=tbl_user.user_id', array('user_name'=>'name'))
            ->order('tbl_inventory.inventory_id DESC');

        $result = $this->db->fetchAll($select);
        return $result;
    }

    //hiển thị chi tiết kiểm kê
    public function getInventory($inventory_id){
        $select = $this->db->select()
            ->from('tbl_inventory')
            ->join('tbl_user','tbl_inventory.inventory_person_id=tbl_user.user_id', array('user_name'=>'name'))
            ->where('inventory_id = '.$inventory_id);

        $result = $this->db->fetchRow($select);
        return $result;

    }

    public function detailInventory($inventory_id){
        $select = $this->db->select()
            ->from('tbl_inventory_detail')
            ->join('tbl_inventory','tbl_inventory_detail.inventory_id=tbl_inventory.inventory_id', array('inventory_id'=>'inventory_id'))
            ->join('tbl_asset','tbl_inventory_detail.asset_id=tbl_asset.asset_id', array('asset_name'=>'name', 'asset_code'=>'code'))
            ->join(array('tbl_before_stt' => 'tbl_status'),'tbl_inventory_detail.before_status=tbl_before_stt.status_id', array('before_status_name'=>'status_name'))
            ->join(array('tbl_inventory_stt' => 'tbl_status'),'tbl_inventory_detail.inventory_status=tbl_inventory_stt.status_id', array('inventory_status_name'=>'status_name'))
            ->where('tbl_inventory_detail.inventory_id = '.$inventory_id);

        $result = $this->db->fetchAll($select);
        return $result;
    }
}