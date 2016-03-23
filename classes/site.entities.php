<?php
namespace Classes;

require_once __DIR__ . "/Repository/EmployeeRepository.php";
require_once __DIR__ . "/Repository/ArticleRepository.php";

/* We just need Entity Endpoint */
class Entites {	
	private $employeeRepo;
	private $ArticleRepo;
	
	private $database;
	
	private $domain;
	
	function __construct($db = null, $domain = null) {
		if (!is_null($db)){
			$this->database = $db;
		} else {
			try {
				$this->database = new PDO("pgsql:dbname=". $_C['db']['name'] ." host=". $_C['db']['host'], $_C['db']['username'], $_C['db']['password']);
			}
			catch (PDOException  $e)
			{
				// TODO: some logging would be nice
			}
		}
		
		if (!is_null($domain)){
			$this->domain = $domain;
		} else {
			$this->domain = -1;
		}
		
		if (class_exists('\\Repository\\EmployeeRepository')) { $this->employeeRepo = new \Repository\EmployeeRepository($this->database);}
		if (class_exists('\\Repository\\ArticleRepository'))  { $this->ArticleRepo = new \Repository\ArticleRepository($this->database);}
   }
	
		function GetAllAgents(){
			if (!is_null($this->employeeRepo)){
				return $this->employeeRepo->GetAll();
			}
		// TODO: some logging would be nice
		  return null;
		}
		
		function GetArticlesByCategory($category, $subCategory = null){
			if (!is_null($this->ArticleRepo)){
				return $this->ArticleRepo->GetByCategory($category, $subCategory);
			}
		// TODO: some logging would be nice
		  return null;
		}
}

?>