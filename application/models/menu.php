<?php
class Model_Menu extends Zend_Db_Table{

    protected $_name = 'tbl_asset_group';
    protected $_primary = 'group_id';
    protected $db;



    public function init(){
        $this->db = Zend_Registry::get('connectDb');
    }

    public function countItem(){
        $select = $this->db->select()
                ->from('tbl_asset_group', array('COUNT(group_id)'))
                ->where('is_disabled = 0');
        $result = $this->db->fetchOne($select);
        return $result;

    }

    public function listItems(){
        $select = $this->db->select()
            ->from('tbl_asset_group')
            ->where('tbl_asset_group.is_disabled = 0')
            ->where('tbl_asset_group.active = 1')
            ->order('group_id DESC');;
//        echo $select;
//        exit();
        $result = $this->db->fetchAll($select);
        return $result;
    }

    public function listallItems(){
        //$result = $this->fetchAll($where, $order, $count, $offet);
        $select = $this->db->select()
                ->from('tbl_asset_group')
                ->joinLeft('tbl_asset', 'tbl_asset.asset_group_id=tbl_asset_group.group_id', array('asset_count'=>'COUNT(tbl_asset.asset_id)'))
                ->where('tbl_asset_group.is_disabled = 0')
                ->where('(tbl_asset.is_disabled = 0) OR (tbl_asset.is_disabled IS NULL)')
                ->group('group_id')
                ->group('tbl_asset.is_disabled')
                ->order('group_id DESC');

        $result = $this->db->fetchAll($select);
        return $result;
    }
    public function addItem($arrParam){

        $row['description']= $arrParam['description'];
        $row['active']= $arrParam['active'];
        $this->db->insert('tbl_asset_group', $row);
        $id = $this->db->lastInsertId();
        echo $id;
        return $id;
    }

    public function getItem($id){
        $where = 'group_id = ' . $id;
        $detail = $this->fetchRow($where)->toArray();
        return $detail;
    }
    public function updateItem($arrParam){
        $where = 'group_id='.$arrParam['id'];
        $row['description']= $arrParam['description'];
        $row['active']= $arrParam['active'];
        $this->db->update('tbl_asset_group', $row, $where);
    }
    public function deleteItem($ID){
        $where = 'group_id= '.$ID;
        $row['is_disabled']=1;
        $row['deleted_at']= date("Y-m-d H:i:s");
        $this->db->update('tbl_asset_group', $row, $where);
    }
    public function searchItem($key){

        $select = $this->db->select()
                ->from('tbl_asset_group')
                ->where('is_disabled = 0');
        $keywords = '%'.$key.'%';
        $select->where('lower(description) LIKE ?', $keywords);

        $result = $this->db->fetchAll($select);
        return $result;


    }
}