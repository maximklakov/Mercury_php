
INSERT INTO main.field_types(id, Is_multi, field_type) values (1, 5, 'phone');
INSERT INTO main.field_types(id,  field_type) VALUES (2,  'social_facebook');
INSERT INTO main.field_types(id,  field_type) VALUES (3,  'social_vk');
INSERT INTO main.field_types(id,  field_type) VALUES (4,  'social_odnoklassniki');
INSERT INTO main.field_types(id,  field_type) VALUES (5,  'social_twitter');
INSERT INTO main.field_types(id,  field_type) VALUES (6,  'social_ria');
INSERT INTO main.field_types(id,  field_type) VALUES (7,  'social_olx');

INSERT INTO main.agents (id, Domain_Id, First_Name, Last_Name,Email, Phone, Status, Login_id)
VALUES (0, 0, 'test', 'test', 'test@test.test', '1234567', 1, 0);

INSERT INTO main.logins(id,  username, password, password_salt, Email,  status)
values (0, 'test', 'a94a8fe5ccb19ba61c4c0873d391e987982fbbd3', '0000', 'test@test.test', 0);
