<?php
class Model_Role extends Zend_Db_Table{

    protected $_name = 'tbl_roles';
    protected $_primary = 'role_id';
    protected $db;


    public function init(){
        $this->db = Zend_Registry::get('connectDb');
    }

    public function listRole(){
        //$result = $this->fetchAll($where, $order, $count, $offet);
        $select = $this->db->select()
            ->from('tbl_roles')
            ->where('is_disabled = 0')
            ->order('role_id DESC');
        $result = $this->db->fetchAll($select);
        return $result;
    }

}