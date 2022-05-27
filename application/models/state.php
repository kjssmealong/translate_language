<?php
class Model_State extends Zend_Db_Table{

    protected $_name = 'tbl_state';
    protected $_primary = 'state_id';
    protected $db;


    public function init(){
        $this->db = Zend_Registry::get('connectDb');
    }

    public function listState(){
        //$result = $this->fetchAll($where, $order, $count, $offet);
        $select = $this->db->select()
            ->from('tbl_state')
            ->where('is_delete = 0')
            ->order('state_id DESC');
        $result = $this->db->fetchAll($select);
        return $result;
    }

}