<?php
namespace Repository;

abstract class BaseRepository{
		
	public $database;

	function __construct($db){
		if (!is_null($db))  $this->database = $db;		
	}
	
	abstract function GetAll();
	
	abstract function GetByGuid(string $guid);
	
}

?>