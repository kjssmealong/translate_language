<?php
require(LIBRARY_PATH.'/PhpExcel/Classes/PHPExcel.php');

class InventoryController extends Zend_Controller_Action
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

        $this->model = new Model_Inventory();

        if($_SESSION['role_id']==3){
            $this->redirect('/');
        }
    }

    //liệt kê dữ liệu trong db
    public function indexAction(){
        $this->view->inventory_list = $this->model->listInventory();

        if (isset($_SESSION['alert'])) {
            $this->view->alert = $_SESSION['alert'];
            unset( $_SESSION['alert'] );
        }
    }

    public function detailAction(){
        $arrParam = $this->_arrParam;

        $this->view->inventory = $this->model->getInventory($arrParam['inventory_id']);
        if(empty($this->view->inventory)){
            $this->redirect('/inventory');
        }
        $this->view->inventory_detail = $this->model->detailInventory($arrParam['inventory_id']);

    }
    public function exportExcelAction(){

        //set no layout
        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout()->disableLayout();
        $arrParam = $this->_arrParam;

        //lấy dữ liệu từ model
        $inventory = $this->model->getInventory($arrParam['inventory_id']);
        $inventory_detail = $this->model->detailInventory($arrParam['inventory_id']);


        //tạo object phpexcel
        $objExcel = new PHPExcel();
        $objExcel->setActiveSheetIndex(0);


        $sheet = $objExcel->getActiveSheet()->setTitle($inventory['inventory_code']);

        //merge row & column
        $sheet->mergeCells('A2:C2');
        $sheet->mergeCells('A3:C3');
        $sheet->mergeCells('A5:F5');
        $sheet->mergeCells('B7:F7');
        $sheet->mergeCells('B8:F8');
        $sheet->mergeCells('B9:F9');
        $sheet->mergeCells('A11:A12');
        $sheet->mergeCells('B11:B12');
        $sheet->mergeCells('C11:C12');
        $sheet->mergeCells('F11:F12');
        $sheet->mergeCells('D11:E11');

        //set column width
        $sheet->getColumnDimension('A')->setWidth(17);
        $sheet->getColumnDimension('B')->setWidth(35);
        $sheet->getColumnDimension('c')->setWidth(30);
        $sheet->getColumnDimension('D')->setWidth(30);
        $sheet->getColumnDimension('E')->setWidth(30);
        $sheet->getColumnDimension('F')->setWidth(24);

        //set row height
        $sheet->getRowDimension('2')->setRowHeight(20);
        $sheet->getRowDimension('3')->setRowHeight(20);
        $sheet->getRowDimension('5')->setRowHeight(30);
        $sheet->getRowDimension('7')->setRowHeight(20);
        $sheet->getRowDimension('8')->setRowHeight(20);
        $sheet->getRowDimension('9')->setRowHeight(20);
        $sheet->getRowDimension('11')->setRowHeight(20);
        $sheet->getRowDimension('12')->setRowHeight(20);
        $sheet->getRowDimension('13')->setRowHeight(20);
        $sheet->getRowDimension('14')->setRowHeight(20);

        //chuyển inventory date thành ngày ... tháng ... năm
        $inventory_date = $inventory['inventory_date'];
        $inventory_day = date("d", strtotime($inventory_date));
        $inventory_month = date("m", strtotime($inventory_date));
        $inventory_year = date("y", strtotime($inventory_date));

        //thêm data
        $sheet  ->setCellValue('A2', 'VPĐD Plott tại Việt Nam')
                ->setCellValue('A3', '10 Phổ Quang, Phường 2, Tân Bình, Thành phố Hồ Chí Minh')
                ->setCellValue('A5', 'BẢN KIỂM KÊ TÀI SẢN')
                ->setCellValue('A7', 'Người kiểm kê')
                ->setCellValue('A8', 'Ngày kiểm kê')
                ->setCellValue('A9', 'Ghi chú')
                ->setCellValue('A11', 'STT')
                ->setCellValue('B11', 'Tên tài sản')
                ->setCellValue('C11', 'Mã tài sản')
                ->setCellValue('D11', 'Tình trạng')
                ->setCellValue('D12', 'Trước')
                ->setCellValue('E12', 'Sau')
                ->setCellValue('F11', 'Ghi chú')
                ->setCellValue('B7', $inventory['user_name'])
                ->setCellValue('B8', "$inventory_day/$inventory_month/20$inventory_year")
                ->setCellValue('B9', $inventory['note']);
        $next_row = 13;
        $stt = 1;
        foreach($inventory_detail as $key=>$value){
            $sheet->setCellValue('A'.$next_row, $stt);
            $sheet->setCellValue('B'.$next_row, $value['asset_name']);
            $sheet->setCellValue('C'.$next_row, $value['asset_code']);
            $sheet->setCellValue('D'.$next_row, $value['before_status_name']);
            $sheet->setCellValue('E'.$next_row, $value['inventory_status_name']);
            $sheet->setCellValue('F'.$next_row, $value['note']);

            $sheet->getStyle('A'.$next_row)->applyFromArray([
                'font' => [
                    'size' => 11,
                    'name' => 'Arial',
                ],
                'alignment' => [
                    'horizontal' => PHPEXcel_Style_Alignment::HORIZONTAL_CENTER,
                    'vertical' => PHPEXcel_Style_Alignment::VERTICAL_CENTER
                ],
                'borders' => array(
                    'allborders' => array(
                        'style' => PHPExcel_Style_Border::BORDER_THIN,
                    )
                )

            ]);

            $sheet->getStyle('B'.$next_row.':F'.$next_row)->applyFromArray([
                'font' => [
                    'size' => 11,
                    'name' => 'Arial',
                ],
                'borders' => array(
                    'allborders' => array(
                        'style' => PHPExcel_Style_Border::BORDER_THIN,
                    )
                )
            ]);

            $next_row++;
            $stt++;
        }

        $sheet->getStyle('A2:C2')->applyFromArray([
            'font' => [
                'bold' => true,
                'size' => 12,
                'name' => 'Arial',
            ],
            'alignment' => [
                'horizontal' => PHPEXcel_Style_Alignment::HORIZONTAL_CENTER,
                'vertical' => PHPEXcel_Style_Alignment::VERTICAL_CENTER
            ],

        ]);

        $sheet->getStyle('A3:C3')->applyFromArray([
            'font' => [
                'bold' => true,
                'size' => 12,
                'name' => 'Arial',
            ],
            'alignment' => [
                'horizontal' => PHPEXcel_Style_Alignment::HORIZONTAL_CENTER,
                'vertical' => PHPEXcel_Style_Alignment::VERTICAL_CENTER
            ],

        ]);

        $sheet->getStyle('A5:E5')->applyFromArray([
            'font' => [
                'bold' => true,
                'size' => 14,
                'name' => 'Arial',
            ],
            'alignment' => [
                'horizontal' => PHPEXcel_Style_Alignment::HORIZONTAL_CENTER,
                'vertical' => PHPEXcel_Style_Alignment::VERTICAL_CENTER
            ],

        ]);

        $sheet->getStyle('A7:E9')->applyFromArray([
            'font' => [
                'size' => 11,
                'name' => 'Arial',
            ],

        ]);

        $sheet->getStyle('A11:F12')->applyFromArray([
            'font' => [
                'bold' => true,
                'size' => 11,
                'name' => 'Arial',
            ],
            'alignment' => [
                'horizontal' => PHPEXcel_Style_Alignment::HORIZONTAL_CENTER,
                'vertical' => PHPEXcel_Style_Alignment::VERTICAL_CENTER
            ],
            'borders' => array(
                'allborders' => array(
                    'style' => PHPExcel_Style_Border::BORDER_THIN,
                )
            )
        ]);

        //footer of excel
        //ngay thang nam of excel
        $next_row++;
        $sheet->mergeCells("E$next_row:F$next_row");
        $sheet->setCellValue("E$next_row","Ngày $inventory_day tháng $inventory_month năm 20$inventory_year");
        $sheet->getStyle("E$next_row:F$next_row")->applyFromArray([
            'font' => [
                'italic' => true,
                'size' => 10,
                'name' => 'Arial',
            ],
            'alignment' => [
                'horizontal' => PHPEXcel_Style_Alignment::HORIZONTAL_CENTER,
                'vertical' => PHPEXcel_Style_Alignment::VERTICAL_CENTER
            ],
        ]);

        //row 'giam doc', 'nguoi kiem ke'
        $next_row++;
        $sheet->mergeCells("A$next_row:B$next_row");
        $sheet->setCellValue("A$next_row","Giám đốc");
        $sheet->getStyle("A$next_row:B$next_row")->applyFromArray([
            'font' => [
                'bold' => true,
                'size' => 11,
                'name' => 'Arial',
            ],
            'alignment' => [
                'horizontal' => PHPEXcel_Style_Alignment::HORIZONTAL_CENTER,
                'vertical' => PHPEXcel_Style_Alignment::VERTICAL_CENTER
            ],
        ]);

        $sheet->mergeCells("E$next_row:F$next_row");
        $sheet->setCellValue("E$next_row","Người kiểm kê");
        $sheet->getStyle("E$next_row:F$next_row")->applyFromArray([
            'font' => [
                'bold' => true,
                'size' => 11,
                'name' => 'Arial',
            ],
            'alignment' => [
                'horizontal' => PHPEXcel_Style_Alignment::HORIZONTAL_CENTER,
                'vertical' => PHPEXcel_Style_Alignment::VERTICAL_CENTER
            ],
        ]);

        //row 'ký họ tên'
        $next_row++;
        $sheet->mergeCells("A$next_row:B$next_row");
        $sheet->setCellValue("A$next_row","(Ký, họ tên, đóng dấu)");
        $sheet->getStyle("A$next_row:B$next_row")->applyFromArray([
            'font' => [
                'italic' => true,
                'size' => 10,
                'name' => 'Arial',
            ],
            'alignment' => [
                'horizontal' => PHPEXcel_Style_Alignment::HORIZONTAL_CENTER,
                'vertical' => PHPEXcel_Style_Alignment::VERTICAL_CENTER
            ],
        ]);

        $sheet->mergeCells("E$next_row:F$next_row");
        $sheet->setCellValue("E$next_row","(Ký, họ tên)");
        $sheet->getStyle("E$next_row:F$next_row")->applyFromArray([
            'font' => [
                'italic' => true,
                'size' => 10,
                'name' => 'Arial',
            ],
            'alignment' => [
                'horizontal' => PHPEXcel_Style_Alignment::HORIZONTAL_CENTER,
                'vertical' => PHPEXcel_Style_Alignment::VERTICAL_CENTER
            ],
        ]);

        //lưu file excel
        $objWriter = new PHPExcel_Writer_Excel2007($objExcel);
        ob_end_clean();
        $filename = 'ChiTiếtKiểmKê.xlsx';
        $objWriter->save($filename);

        $objWriter = PHPExcel_IOFactory::createWriter($objExcel, 'Excel2007');
        ob_end_clean();

        header("Pragma: no-cache");
        header("Cache-Control: must-revalidate, post-check=0, pre-check=0");
        header("Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        header("Content-Disposition: attachment;filename=$filename");
        header("Content-Length: ". filesize($filename));
        header("Content-Transfer-Encoding: binary ");

        readfile($filename);
    }
    public function multiExportAction(){


        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout()->disableLayout();

        $arrParam = $this->_arrParam;
        if (!isset($arrParam["inventory_id"])){
            $_SESSION['alert'] = "Chọn tối thiểu một dòng";
            $this->redirect('/inventory');
        }
        else {
            $objExcel = new PHPExcel;
            $numSheets = count($arrParam["inventory_id"]);

            foreach ($arrParam["inventory_id"] as $key=>$item_id) {

                if($key < $numSheets-1) {
                    $objExcel->createSheet();
                }
                $objExcel->setActiveSheetIndex($key);

                //lấy dữ liệu từ model
                $inventory = $this->model->getInventory($item_id);
                $inventory_detail = $this->model->detailInventory($item_id);

                //chuyển inventory date thành ngày ... tháng ... năm
                $inventory_date = $inventory['inventory_date'];
                $inventory_day = date("d", strtotime($inventory_date));
                $inventory_month = date("m", strtotime($inventory_date));
                $inventory_year = date("y", strtotime($inventory_date));


                $sheet = $objExcel->getActiveSheet()->setTitle($inventory['inventory_code']);

                //merge row & column
                $sheet->mergeCells('A2:C2');
                $sheet->mergeCells('A3:C3');
                $sheet->mergeCells('A5:F5');
                $sheet->mergeCells('B7:F7');
                $sheet->mergeCells('B8:F8');
                $sheet->mergeCells('B9:F9');
                $sheet->mergeCells('A11:A12');
                $sheet->mergeCells('B11:B12');
                $sheet->mergeCells('C11:C12');
                $sheet->mergeCells('F11:F12');
                $sheet->mergeCells('D11:E11');

                //set column width
                $sheet->getColumnDimension('A')->setWidth(17);
                $sheet->getColumnDimension('B')->setWidth(35);
                $sheet->getColumnDimension('c')->setWidth(30);
                $sheet->getColumnDimension('D')->setWidth(30);
                $sheet->getColumnDimension('E')->setWidth(30);
                $sheet->getColumnDimension('F')->setWidth(24);

                //set row height
                $sheet->getRowDimension('2')->setRowHeight(20);
                $sheet->getRowDimension('3')->setRowHeight(20);
                $sheet->getRowDimension('5')->setRowHeight(30);
                $sheet->getRowDimension('7')->setRowHeight(20);
                $sheet->getRowDimension('8')->setRowHeight(20);
                $sheet->getRowDimension('9')->setRowHeight(20);
                $sheet->getRowDimension('11')->setRowHeight(20);
                $sheet->getRowDimension('12')->setRowHeight(20);
                $sheet->getRowDimension('13')->setRowHeight(20);
                $sheet->getRowDimension('14')->setRowHeight(20);

                //thêm data
                $sheet  ->setCellValue('A2', 'VPĐD Plott tại Việt Nam')
                    ->setCellValue('A3', '10 Phổ Quang, Phường 2, Tân Bình, Thành phố Hồ Chí Minh')
                    ->setCellValue('A5', 'BẢN KIỂM KÊ TÀI SẢN')
                    ->setCellValue('A7', 'Người kiểm kê')
                    ->setCellValue('A8', 'Ngày kiểm kê')
                    ->setCellValue('A9', 'Ghi chú')
                    ->setCellValue('A11', 'STT')
                    ->setCellValue('B11', 'Tên tài sản')
                    ->setCellValue('C11', 'Mã tài sản')
                    ->setCellValue('D11', 'Tình trạng')
                    ->setCellValue('D12', 'Trước')
                    ->setCellValue('E12', 'Sau')
                    ->setCellValue('F11', 'Ghi chú')
                    ->setCellValue('B7', $inventory['user_name'])
                    ->setCellValue('B8', "$inventory_day/$inventory_month/20$inventory_year")
                    ->setCellValue('B9', $inventory['note']);
                $next_row = 13;
                $stt = 1;
                foreach ($inventory_detail as $key => $value) {
                    $sheet->setCellValue('A'.$next_row, $stt);
                    $sheet->setCellValue('B'.$next_row, $value['asset_name']);
                    $sheet->setCellValue('C'.$next_row, $value['asset_code']);
                    $sheet->setCellValue('D'.$next_row, $value['before_status_name']);
                    $sheet->setCellValue('E'.$next_row, $value['inventory_status_name']);
                    $sheet->setCellValue('F'.$next_row, $value['note']);

                    $sheet->getStyle('A'.$next_row)->applyFromArray([
                        'font' => [
                            'size' => 11,
                            'name' => 'Arial',
                        ],
                        'alignment' => [
                            'horizontal' => PHPEXcel_Style_Alignment::HORIZONTAL_CENTER,
                            'vertical' => PHPEXcel_Style_Alignment::VERTICAL_CENTER
                        ],
                        'borders' => array(
                            'allborders' => array(
                                'style' => PHPExcel_Style_Border::BORDER_THIN,
                            )
                        )

                    ]);

                    $sheet->getStyle('B'.$next_row.':F'.$next_row)->applyFromArray([
                        'font' => [
                            'size' => 11,
                            'name' => 'Arial',
                        ],
                        'borders' => array(
                            'allborders' => array(
                                'style' => PHPExcel_Style_Border::BORDER_THIN,
                            )
                        )
                    ]);

                    $next_row++;
                    $stt++;
                }

                $sheet->getStyle('A2:C2')->applyFromArray([
                    'font' => [
                        'bold' => true,
                        'size' => 12,
                        'name' => 'Arial',
                    ],
                    'alignment' => [
                        'horizontal' => PHPEXcel_Style_Alignment::HORIZONTAL_CENTER,
                        'vertical' => PHPEXcel_Style_Alignment::VERTICAL_CENTER
                    ],

                ]);

                $sheet->getStyle('A3:C3')->applyFromArray([
                    'font' => [
                        'bold' => true,
                        'size' => 12,
                        'name' => 'Arial',
                    ],
                    'alignment' => [
                        'horizontal' => PHPEXcel_Style_Alignment::HORIZONTAL_CENTER,
                        'vertical' => PHPEXcel_Style_Alignment::VERTICAL_CENTER
                    ],

                ]);

                $sheet->getStyle('A5:E5')->applyFromArray([
                    'font' => [
                        'bold' => true,
                        'size' => 14,
                        'name' => 'Arial',
                    ],
                    'alignment' => [
                        'horizontal' => PHPEXcel_Style_Alignment::HORIZONTAL_CENTER,
                        'vertical' => PHPEXcel_Style_Alignment::VERTICAL_CENTER
                    ],

                ]);

                $sheet->getStyle('A7:E9')->applyFromArray([
                    'font' => [
                        'size' => 11,
                        'name' => 'Arial',
                    ],

                ]);

                $sheet->getStyle('A11:F12')->applyFromArray([
                    'font' => [
                        'bold' => true,
                        'size' => 11,
                        'name' => 'Arial',
                    ],
                    'alignment' => [
                        'horizontal' => PHPEXcel_Style_Alignment::HORIZONTAL_CENTER,
                        'vertical' => PHPEXcel_Style_Alignment::VERTICAL_CENTER
                    ],
                    'borders' => array(
                        'allborders' => array(
                            'style' => PHPExcel_Style_Border::BORDER_THIN,
                        )
                    )
                ]);
                //footer of excel
                //ngay thang nam of excel
                $next_row++;
                $sheet->mergeCells("E$next_row:F$next_row");
                $sheet->setCellValue("E$next_row","Ngày $inventory_day tháng $inventory_month năm 20$inventory_year");
                $sheet->getStyle("E$next_row:F$next_row")->applyFromArray([
                    'font' => [
                        'italic' => true,
                        'size' => 10,
                        'name' => 'Arial',
                    ],
                    'alignment' => [
                        'horizontal' => PHPEXcel_Style_Alignment::HORIZONTAL_CENTER,
                        'vertical' => PHPEXcel_Style_Alignment::VERTICAL_CENTER
                    ],
                ]);

                //row 'giam doc', 'nguoi kiem ke'
                $next_row++;
                $sheet->mergeCells("A$next_row:B$next_row");
                $sheet->setCellValue("A$next_row","Giám đốc");
                $sheet->getStyle("A$next_row:B$next_row")->applyFromArray([
                    'font' => [
                        'bold' => true,
                        'size' => 11,
                        'name' => 'Arial',
                    ],
                    'alignment' => [
                        'horizontal' => PHPEXcel_Style_Alignment::HORIZONTAL_CENTER,
                        'vertical' => PHPEXcel_Style_Alignment::VERTICAL_CENTER
                    ],
                ]);

                $sheet->mergeCells("E$next_row:F$next_row");
                $sheet->setCellValue("E$next_row","Người kiểm kê");
                $sheet->getStyle("E$next_row:F$next_row")->applyFromArray([
                    'font' => [
                        'bold' => true,
                        'size' => 11,
                        'name' => 'Arial',
                    ],
                    'alignment' => [
                        'horizontal' => PHPEXcel_Style_Alignment::HORIZONTAL_CENTER,
                        'vertical' => PHPEXcel_Style_Alignment::VERTICAL_CENTER
                    ],
                ]);

                //row 'ký họ tên'
                $next_row++;
                $sheet->getRowDimension("$next_row")->setRowHeight(20);
                $sheet->mergeCells("A$next_row:B$next_row");
                $sheet->setCellValue("A$next_row","(Ký, họ tên, đóng dấu)");
                $sheet->getStyle("A$next_row:B$next_row")->applyFromArray([
                    'font' => [
                        'italic' => true,
                        'size' => 10,
                        'name' => 'Arial',
                    ],
                    'alignment' => [
                        'horizontal' => PHPEXcel_Style_Alignment::HORIZONTAL_CENTER,
                        'vertical' => PHPEXcel_Style_Alignment::VERTICAL_CENTER
                    ],
                ]);

                $sheet->mergeCells("E$next_row:F$next_row");
                $sheet->setCellValue("E$next_row","(Ký, họ tên)");
                $sheet->getStyle("E$next_row:F$next_row")->applyFromArray([
                    'font' => [
                        'italic' => true,
                        'size' => 10,
                        'name' => 'Arial',
                    ],
                    'alignment' => [
                        'horizontal' => PHPEXcel_Style_Alignment::HORIZONTAL_CENTER,
                        'vertical' => PHPEXcel_Style_Alignment::VERTICAL_CENTER
                    ],
                ]);
            }


            //lưu file excel
            $objWriter = new PHPExcel_Writer_Excel2007($objExcel);
            ob_end_clean();
            $filename = 'ChiTiếtKiểmKê.xlsx';
            $objWriter->save($filename);

            $objWriter = PHPExcel_IOFactory::createWriter($objExcel, 'Excel2007');
            ob_end_clean();

            header("Pragma: no-cache");
            header("Cache-Control: must-revalidate, post-check=0, pre-check=0");
            header("Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            header("Content-Disposition: attachment;filename=$filename");
            header("Content-Length: " . filesize($filename));
            header("Content-Transfer-Encoding: binary ");

            readfile($filename);
        }
    }

}