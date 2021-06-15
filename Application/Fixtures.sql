

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


SET SESSION AUTHORIZATION DEFAULT;

ALTER TABLE public.users DISABLE TRIGGER ALL;

INSERT INTO public.users (id, email, password_hash, locked_at, failed_login_attempts, first_name, last_name, picture_url) VALUES ('caafb393-ea09-48ef-af2c-db2319ef4fd8', 'milicaob97@gmail.com', 'sha256|17|G/Uq6blT5WwN2KaK3MBMgg==|aIdGceokxt/iqRUFXPBR8RvSgDuvYQCQyS5sncDcrks=', NULL, 0, 'Milica', 'Obradovic', '/uploads/users/caafb393-ea09-48ef-af2c-db2319ef4fd8/picture.jpg');
INSERT INTO public.users (id, email, password_hash, locked_at, failed_login_attempts, first_name, last_name, picture_url) VALUES ('1a659b1c-4f0c-41e0-9e49-a1e62bfc39f8', 'shekrba@gmail.com', 'sha256|17|zXcjfeq0a3kOjqNKWom/3w==|aTqRDRZ8CYVOuzmkyY9mgUjBGeT5ZxzTGTTmozj5ohM=', NULL, 0, 'Milan', 'Skrbic', '/uploads/users/1a659b1c-4f0c-41e0-9e49-a1e62bfc39f8/picture.jpg');


ALTER TABLE public.users ENABLE TRIGGER ALL;


ALTER TABLE public.follows DISABLE TRIGGER ALL;

INSERT INTO public.follows (id, follower_id, user_id) VALUES ('fb3cfcf5-54f9-4e9f-8d24-6c62b99b2559', '1a659b1c-4f0c-41e0-9e49-a1e62bfc39f8', 'caafb393-ea09-48ef-af2c-db2319ef4fd8');


ALTER TABLE public.follows ENABLE TRIGGER ALL;


ALTER TABLE public.posts DISABLE TRIGGER ALL;

INSERT INTO public.posts (id, description, user_id, picture_url, created_at) VALUES ('549d1a85-9a46-4120-a7c7-a22120a91b8d', 'Golden Flower', 'caafb393-ea09-48ef-af2c-db2319ef4fd8', '/uploads/posts/549d1a85-9a46-4120-a7c7-a22120a91b8d/picture.jpg', '2021-06-14 12:58:12.474783+02');
INSERT INTO public.posts (id, description, user_id, picture_url, created_at) VALUES ('0b807f4a-7188-46f1-90dc-105e804beb12', 'Photographer Photograph', 'caafb393-ea09-48ef-af2c-db2319ef4fd8', '/uploads/posts/0b807f4a-7188-46f1-90dc-105e804beb12/picture.jpg', '2021-06-14 12:58:29.174372+02');
INSERT INTO public.posts (id, description, user_id, picture_url, created_at) VALUES ('a6bb9eef-9c53-4820-9af5-dad3d588a849', 'Milan 
Skrbic 
Emakina', '1a659b1c-4f0c-41e0-9e49-a1e62bfc39f8', '/uploads/posts/a6bb9eef-9c53-4820-9af5-dad3d588a849/picture.jpg', '2021-06-14 13:03:37.507771+02');


ALTER TABLE public.posts ENABLE TRIGGER ALL;


