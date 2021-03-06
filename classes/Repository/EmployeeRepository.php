<?php
namespace Repository;

require_once __DIR__ . '/BaseRepository.php';
require_once __DIR__ . '/../Model/Employee.php';
require_once __DIR__ . '/../common.php';

class EmployeeRepository extends BaseRepository {
	
	protected function constructWhereClause($parameters = null){
		
		 $returnString = ' where 1 = 1 ';
		 
		 foreach ($parameters as $key => $param){
			 switch ($key) {
				case ':domain':
					$returnString.= ' and a.Domain_Id = :domain';
					break;
				case ':guid':
					$returnString.= ' and a.guid = :guid';
					break;
				case ':status':
					$returnString.= ' and a.status = :status';
					break;
			}
		 }
	  return $returnString;			
	}
	
	protected function GetByParameters($parameters = null){
		global $_C;		
		
		if (!is_null($parameters) && (is_array ($parameters)))
		{
			$parameters[':domain'] = $_C['domain'];
		}
		else { 
			$parameters = array(':domain' => $_C['domain']);
		}
		
		$where = $this->constructWhereClause($parameters);
		
		$sql = 'Select name, id, guid, profile_picture, position from main.agents a '.$where.' order by id';
		$sth = $this->database->prepare($sql, array(\PDO::ATTR_CURSOR => \PDO::CURSOR_FWDONLY));		
		
		$sth->execute($parameters);
		
		$agents = array();
		
		foreach ($sth->fetchAll() as $ag)
		{
			$agents[$ag['id']] = new \Model\Employee($ag['guid'], $ag['name'], null, null, $ag['profile_picture'], $ag['position']);
		}
		
		if (count($agents) > 0){
			
			$sql = 'select af.f_value, ft.field_type, a.id  from main.field_types ft 
						inner join main.agent_fields af on af.field_type_id = ft.id 
						inner join main.agents a on a.id = af.agent_id '.
					$where
					.' order by a.id';
	
			$sth = $this->database->prepare($sql, array(\PDO::ATTR_CURSOR => \PDO::CURSOR_FWDONLY));
			$sth->execute($parameters);
			
			foreach ($sth->fetchAll() as $fl)
			{ 
				$agents[$fl['id']]->fields[$fl['field_type']] = $fl['f_value'];
			}
		}
		return $agents;
	}
	
   function GetAll(){
	  return $this->GetByParameters();
   }
	
   function GetByGuid(string $guid){
	   $ent = array();
	   
	   if ( (strlen( trim($guid) ) > 1) && (isValidGuid($guid)) ){

	   $ent = $this->GetByParameters(array(':guid' => $guid ));

	   if (count($ent)>0)
		   return $ent[0];
	   else return null;
	   }
   }
}


?>