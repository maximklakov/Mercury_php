
INSERT INTO main.Domains (Id, Domain_Name, Default_Lang_Id) values (1, '121 RE', 804);


INSERT INTO main.agents(
             id, domain_id, login_id, name, email, 
            phone, status, profile_picture, "position")
    VALUES ( 1, 1, 1, 'Ірина', '1@gmail.com', 
            1, 1, 'img/team/3.jpg', 'Провідний Спеціаліст');


INSERT INTO main.agents(
             id, domain_id, login_id, name, email, 
            phone, status, profile_picture, "position")
    VALUES ( 2, 1, 2, 'Галина', '2@gmail.com', 
            1, 1, 'img/team/2.jpg', 'Спеціаліст');


INSERT INTO main.agents(
             id, domain_id, login_id, name, email, 
            phone, status, profile_picture, "position")
    VALUES ( 3, 1, 3, 'Марина', 'Marina121r@gmail.com', 
            1, 1, 'img/team/1.jpg', 'Провідний Спеціаліст');

			
INSERT INTO main.agent_fields(id, agent_id, field_type_id, f_value)
    VALUES (1, 3, 6, 'http://dom.ria.ua');

INSERT INTO main.agent_fields(id, agent_id, field_type_id, f_value)
    VALUES (2, 3, 3, 'http://vk.com/id31747196');
	
INSERT INTO main.agent_fields(id, agent_id, field_type_id, f_value)
    VALUES (3, 3, 2, 'https://www.facebook.com/100007186382429');	
	
INSERT INTO main.agent_fields(id, agent_id, field_type_id, f_value)
    VALUES (4, 1, 3, 'http://vk.com/id188877433');
	
INSERT INTO main.agent_fields(id, agent_id, field_type_id, f_value)
    VALUES (5, 1, 2, 'https://www.facebook.com/100002635164478');	
	
	
	
INSERT INTO main.articles(
            name, category, subcategory, picture, date1, date2, text1, 
            text2, article_text, domain_id, order_value)
    VALUES ('sales', 'services', null, 'shopping-cart', null, null, 'Продаж',
	'null', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Minima maxime quam architecto quo inventore harum ex magni, dicta impedit.', 1, 1);
	
INSERT INTO main.articles(
            name, category, subcategory, picture, date1, date2, text1, 
            text2, article_text, domain_id, order_value)
    VALUES ('advertisement', 'services', null, 'laptop', null, null, 'Реклама',
	'null', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Minima maxime quam architecto quo inventore harum ex magni, dicta impedit.', 1, 2);
	
INSERT INTO main.articles(
            name, category, subcategory, picture, date1, date2, text1, 
            text2, article_text, domain_id, order_value)
    VALUES ('guard', 'services', null, 'lock', null, null, 'Супровід',
	'null', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Minima maxime quam architecto quo inventore harum ex magni, dicta impedit.', 1, 3);

INSERT INTO main.articles(
            name, category, subcategory, picture, date1, date2, text1, 
            text2, article_text, domain_id, order_value)
    VALUES ('first', 'history', null, 'img/about/1.jpg', null, null, '2009-2011',
	'Our Humble Beginnings', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Minima maxime quam architecto quo inventore harum ex magni, dicta impedit.', 1, 1);
	
INSERT INTO main.articles(
            name, category, subcategory, picture, date1, date2, text1, 
            text2, article_text, domain_id, order_value)
    VALUES ('second', 'history', null, 'img/about/2.jpg', null, null, 'March 2011',
	'An Agency is Born', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Minima maxime quam architecto quo inventore harum ex magni, dicta impedit.', 1, 2);
	