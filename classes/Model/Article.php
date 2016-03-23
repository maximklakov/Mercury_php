<?php
namespace Model;

require_once __DIR__ . "/BaseEntity.php";

class Article extends BaseEntity {
	
	public $name;
	
	public $category;
	public $subCategory;
	
	public $picture;
	public $date1;
	public $date2;
	
	public $shortText1;
	public $shortText2;
	public $fullText;
	
	public $orderValue;
	
	
	function __construct($guid = null, $category = null, $subCategory = null, $name = null, $picture = null, $date1 = null, $shortText1 = null, $fullText = null, $date2 = null, $shortText2 = null, $orderValue = null){
		$this->guid = $guid;
		$this->name = $name;
		$this->category = $category;
		$this->subCategory = $subCategory;
		$this->picture = $picture;
		$this->date1 = $date1;
		$this->date2 = $date2;
		$this->shortText1 = $shortText1;
		$this->shortText2 = $shortText2;	
		$this->fullText = $fullText;			
		$this->orderValue = $orderValue;	
	}
		
}

?>