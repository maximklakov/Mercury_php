<?php
namespace Model;

require_once __DIR__ . "/BaseEntity.php";

class Employee extends BaseEntity {
	
	public $name;
	
	public $phones = array();
		
    // Social networks references
	public $social = array();

	public $profilePicture;
	
	public $position;
	
	function __construct($guid = null, $name = null, $phones = null, $social = null, $profilePicture = null, $position = null){
		$this->guid = $guid;
		$this->name = $name;
		if (!is_null($phones)) {$this->phones = $phones;}
		$this->social = $social;
		$this->profilePicture = $profilePicture;
		$this->position = $position;		
	}
		
}

?>