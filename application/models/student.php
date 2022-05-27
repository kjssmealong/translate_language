<?php
class Model_Student extends Zend_Db_Table{

    protected $_name = 'student';
    protected $_primary = 'student_id';

    public function listItems(){
        //$result = $this->fetchAll($where, $order, $count, $offet);
        $result = $this->fetchAll();
        return $result;
    }
    public function addItem($arrParam){
            $row = $this->fetchNew();
            $row['name']= $arrParam['name'];
            $row['age']= $arrParam['age'];
            $row['address']= $arrParam['address'];
            $row['status']= $arrParam['status'];
            $row->save();
    }

    public function getItem($id){
        $where = 'student_id = ' . $id;
        $detail = $this->fetchRow($where)->toArray();
        return $detail;
    }
    public function updateItem($arrParam){
        $where = 'student_id = '.$arrParam['id'];
        $row = $this->fetchRow($where);

        $row['name']= $arrParam['name'];
        $row['age']= $arrParam['age'];
        $row['address']= $arrParam['address'];
        $row['status']= $arrParam['status'];
        $row->save();
    }
    public function deleteItem($id){
        $where = 'student_id = '.$id;
        $this->delete($where);
    }


}