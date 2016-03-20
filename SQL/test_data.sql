
INSERT INTO main.Domains (Id, Domain_Name, Default_Lang_Id) values (1, '121 RE', 0);


INSERT INTO main.agents(
             id, domain_id, login_id, first_name, last_name, email, 
            phone, status, profile_picture, "position")
    VALUES ( 1, 1, 1, 'Ірина', 'Бєдна', '1@gmail.com', 
            1, 1, 'img/team/3.jpg', 'Провідний Спеціаліст');


INSERT INTO main.agents(
             id, domain_id, login_id, first_name, last_name, email, 
            phone, status, profile_picture, "position")
    VALUES ( 2, 1, 2, 'Галина', '', '2@gmail.com', 
            1, 1, 'img/team/2.jpg', 'Спеціаліст');


INSERT INTO main.agents(
             id, domain_id, login_id, first_name, last_name, email, 
            phone, status, profile_picture, "position")
    VALUES ( 3, 1, 3, 'Марина', 'Рандюк', 'Marina121r@gmail.com', 
            1, 1, 'img/team/1.jpg', 'Провідний Спеціаліст');

			
INSERT INTO main.agent_fields(id, agent_id, field_type_id, f_value)
    VALUES (1, 3, 6, 'http:\\dom.ria.ua');

	
INSERT INTO main.agent_fields(id, agent_id, field_type_id, f_value)
    VALUES (2, 3, 3, 'http://vk.com/id31747196');
	
INSERT INTO main.agent_fields(id, agent_id, field_type_id, f_value)
    VALUES (3, 3, 2, 'https://www.facebook.com/100007186382429');	
	