<?php
namespace Model;

require_once __DIR__ . "/BaseEntity.php";

class Employee extends BaseEntity {
	
	public $name;
	
	public $phones = array();
		
    // Additional fields (like social, etc.)
	public $fields = array();

	public $profilePicture;
	
	public $position;
	
	function __construct($guid = null, $name = null, $phones = null, $fields = null, $profilePicture = null, $position = null){
		$this->guid = $guid;
		$this->name = $name;
		if (!is_null($phones)) {$this->phones = $phones;}
		if (!is_null($fields)) {$this->fields = $fields;}
		$this->profilePicture = $profilePicture;
		$this->position = $position;		
	}
		
}

?>