<?php
namespace Repository;

require_once __DIR__ . '/BaseRepository.php';
require_once __DIR__ . '/../Model/Article.php';
require_once __DIR__ . '/../common.php';

class ArticleRepository extends BaseRepository {
	
	protected function constructWhereClause($parameters = null){
		if (!is_null($parameters) && (is_array ($parameters)))
		{
		 $returnString = ' where 1 = 1 ';
		 
		 foreach ($parameters as $key => $param){
			 switch ($key) {
				case ':domain':
					$returnString.= ' and a.Domain_Id = :domain';
					break;
				case ':guid':
					$returnString.= ' and a.guid = :guid';
					break;
				case ':category':
					$returnString.= ' and a.category = :category';
					break;
				case ':subcategory':
					$returnString.= ' and a.subcategory = :subcategory';
					break;
			}
		 }
		 
	 return $returnString;			
		}
		else return '';
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
		
		$sql = 'Select id, guid, name, category, subcategory, picture, date1, date2, text1, text2, article_text, domain_id, order_value 
				from  main.articles a '.$this->constructWhereClause($parameters).' order by order_value, id';

		$sth = $this->database->prepare($sql, array(\PDO::ATTR_CURSOR => \PDO::CURSOR_FWDONLY));		
		
		$sth->execute($parameters);
		
		$articles = array();
		
		foreach ($sth->fetchAll() as $ag)
		{
			$articles[$ag['name']] = new \Model\Article($ag['guid'], $ag['category'], $ag['subcategory'], $ag['name'], $ag['picture'], 
													  $ag['date1'], $ag['text1'], $ag['article_text'], $ag['date2'], $ag['text2'], $ag['order_value']);
		}
		
		return $articles;
	}
	
   function GetAll(){
	  return $this->GetByParameters();
   }
   
   function GetByCategory($category, $subCategory = null){
	   
	  $parameters = array(':category' => $category );
	  
	  if (!is_null($subCategory))
		  $parameters[':subcategory'] = $subCategory;
	  
	  return $this->GetByParameters($parameters);
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