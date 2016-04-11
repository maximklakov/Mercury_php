<?php
require __DIR__ . "/uploader.config.php";

function  AuthoriseThisSession()
	{
		session_start();
		

		if(isset($_SESSION['ee_user_name'], $_SESSION['ee_user_pass']))
		{

			$userPass = $_SESSION['ee_user_pass'];
			$userName = $_SESSION['ee_user_name'];
				
			if (isset($_CONFIG['users']) && is_array($_CONFIG['users']))
			{
				foreach($_CONFIG['users'] as $user)
				{
					if($user[1] == $userPass)
					{
						echo $user[1] . ' ' . $user[0];
						
						if(strlen($userName) == 0 || (strtolower($userName) == strtolower($user[0])))
						{
							return true;
						}
					}
				}
				return false;
			}

		}
	return false;	
	}

if (!AuthoriseThisSession()) header( "Location: /");
	
	
?>

