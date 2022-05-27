<?php
class Model_Status extends Zend_Db_Table{

    protected $_name = 'tbl_status';
    protected $_primary = 'status_id';
    protected $db;


    public function init(){
        $this->db = Zend_Registry::get('connectDb');
    }

    public function listStatus(){
        //$result = $this->fetchAll($where, $order, $count, $offet);
        $select = $this->db->select()
            ->from('tbl_status')
            ->where('is_delete = 0');
        $result = $this->db->fetchAll($select);
        return $result;
    }

}