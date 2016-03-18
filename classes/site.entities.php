<?php
namespace Classes;

require_once __DIR__ . "/Repository/EmployeeRepository.php";
//require_once __DIR__ . "/ArticleRepository.php";

/* I know, that it is not single responsibility, so what? I need to do this as quick as possible ) */
class Entites {	
	private $employeeRepo;
	
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
		
		if (class_exists('\\Repository\\EmployeeRepository')) {$this->employeeRepo = new \Repository\EmployeeRepository($this->database);}
		//if (class_exists('ArticleRepository')) { $employeeRepo = new EmployeeRepository($this->database);}
   }
	
		function GetAllAgents(){

		if (!is_null($this->employeeRepo)){
			return $this->employeeRepo->GetAll();
		}
		
		$sql = 'Select First_Name, Last_Name, Id, guid from main.agents where Domain_Id = :domain';
		$sth = $this->database->prepare($sql, array(\PDO::ATTR_CURSOR => \PDO::CURSOR_FWDONLY));
		$sth->execute(array(':domain' => $this->domain));
		
		$agents = $sth->fetchAll();
				
		$sql = 'select af.f_value, ft.field_type, a.id  from main.field_types ft 
					inner join main.agent_fields af on af.field_type_id = ft.id 
					inner join main.agents a on a.id = af.agent_id
				where a.domain_id=:domain';
		$sth = $this->database->prepare($sql, array(\PDO::ATTR_CURSOR => \PDO::CURSOR_FWDONLY));
		$sth->execute(array(':domain' => $this->domain));
		
		
		}
}

?>