<?php
namespace Repository;

require_once __DIR__ . '/BaseRepository.php';
require_once __DIR__ . '/../Model/Employee.php';
require_once __DIR__ . '/../common.php';

class EmployeeRepository extends BaseRepository {
	
	function GetByClause(string $clause, array $parameters = null){
		global $_C;
		$sql = 'Select first_name, last_name, id, guid, profile_picture, position from main.agents where Domain_Id = :domain';
		$sth = $this->database->prepare($sql, array(\PDO::ATTR_CURSOR => \PDO::CURSOR_FWDONLY));
		
		if (!is_null($parameters) && (is_array ($parameters)))
		{
			$parameters[':domain'] = $_C['domain'];
		}
		else { 
			$parameters = array(':domain' => $_C['domain']);
		}
		
		$sth->execute($parameters);
		
		foreach ($sth->fetchAll() as $ag)
		{
			$agents[$ag['id']] = new \Model\Employee($ag['guid'], $ag['first_name'].' '.$ag['last_name'], null, null, $ag['profile_picture'], $ag['position']);
		}
		
		if (count($agents) > 0){
			
			$sql = 'select af.f_value, ft.field_type, a.id  from main.field_types ft 
						inner join main.agent_fields af on af.field_type_id = ft.id 
						inner join main.agents a on a.id = af.agent_id
					where a.domain_id=:domain';
					
			$sth = $this->database->prepare($sql, array(\PDO::ATTR_CURSOR => \PDO::CURSOR_FWDONLY));
			$sth->execute($parameters);

			$fields = $sth->fetchAll();
			
			foreach ($sth->fetchAll() as $fl)
			{
				$agents[$fl['fl']]->social[$fl['field_type']] = $fl['f_value'];
			}
		}
	}
	
   function GetAll(){
	  return $this->GetByClause('1 = 1');
   }
	
   function GetByGuid(string $guid){
	   $empl = array();
	   
	   if ( (strlen( trim($guid) ) > 1) && (isValidGuid($guid)) ){
		   $empl = $this->GetByClause(" guid = '.$guid.'");
	   }
	   
	   if (count($empl)>0)
		   return $empl[0];
	   else return null;
   }
}


?>