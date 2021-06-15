

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

INSERT INTO public.users (id, email, password_hash, locked_at, failed_login_attempts, first_name, last_name, picture_url) VALUES ('0d7e8501-a02a-43bb-ae3d-3c318c4cac16', 'pera@gmail.com', 'sha256|17|4thEkHx+Q6dbYFeJq+449w==|lZrc2rbRfZhWLCD4IK8u3Pe3RZ0p7QYRdLLWByBkXE4=', NULL, 0, 'Pera', 'Peric', 'images/user-placeholder.jpg');
INSERT INTO public.users (id, email, password_hash, locked_at, failed_login_attempts, first_name, last_name, picture_url) VALUES ('caafb393-ea09-48ef-af2c-db2319ef4fd8', 'milicaob97@gmail.com', 'sha256|17|G/Uq6blT5WwN2KaK3MBMgg==|aIdGceokxt/iqRUFXPBR8RvSgDuvYQCQyS5sncDcrks=', NULL, 0, 'Milica', 'Obradovic', '/uploads/users/caafb393-ea09-48ef-af2c-db2319ef4fd8/picture.jpg');
INSERT INTO public.users (id, email, password_hash, locked_at, failed_login_attempts, first_name, last_name, picture_url) VALUES ('1a659b1c-4f0c-41e0-9e49-a1e62bfc39f8', 'shekrba@gmail.com', 'sha256|17|zXcjfeq0a3kOjqNKWom/3w==|aTqRDRZ8CYVOuzmkyY9mgUjBGeT5ZxzTGTTmozj5ohM=', NULL, 0, 'Milan', 'Skrbic', '/uploads/users/1a659b1c-4f0c-41e0-9e49-a1e62bfc39f8/picture.jpg');


ALTER TABLE public.users ENABLE TRIGGER ALL;


ALTER TABLE public.posts DISABLE TRIGGER ALL;

INSERT INTO public.posts (id, description, user_id, picture_url, created_at) VALUES ('549d1a85-9a46-4120-a7c7-a22120a91b8d', 'Golden Flower', 'caafb393-ea09-48ef-af2c-db2319ef4fd8', '/uploads/posts/549d1a85-9a46-4120-a7c7-a22120a91b8d/picture.jpg', '2021-06-14 12:58:12.474783+02');
INSERT INTO public.posts (id, description, user_id, picture_url, created_at) VALUES ('0b807f4a-7188-46f1-90dc-105e804beb12', 'Photographer Photograph', 'caafb393-ea09-48ef-af2c-db2319ef4fd8', '/uploads/posts/0b807f4a-7188-46f1-90dc-105e804beb12/picture.jpg', '2021-06-14 12:58:29.174372+02');
INSERT INTO public.posts (id, description, user_id, picture_url, created_at) VALUES ('79081617-03b2-4e56-aa54-5a5fe66e955e', 'Polaroid', '0d7e8501-a02a-43bb-ae3d-3c318c4cac16', '/uploads/posts/79081617-03b2-4e56-aa54-5a5fe66e955e/picture.jpg', '2021-06-14 13:28:22.858987+02');
INSERT INTO public.posts (id, description, user_id, picture_url, created_at) VALUES ('c9515fa1-2393-43dc-9f75-663cee8c980a', 'Ilustracija slona', 'caafb393-ea09-48ef-af2c-db2319ef4fd8', '/uploads/posts/c9515fa1-2393-43dc-9f75-663cee8c980a/picture.jpg', '2021-06-14 13:29:42.678649+02');
INSERT INTO public.posts (id, description, user_id, picture_url, created_at) VALUES ('da8d8e5d-b0a3-439c-94ec-7bade131d27b', 'Multiple
Suborders', '1a659b1c-4f0c-41e0-9e49-a1e62bfc39f8', '/uploads/posts/da8d8e5d-b0a3-439c-94ec-7bade131d27b/picture.jpg', '2021-06-15 16:04:45.639601+02');


ALTER TABLE public.posts ENABLE TRIGGER ALL;


ALTER TABLE public.comments DISABLE TRIGGER ALL;



ALTER TABLE public.comments ENABLE TRIGGER ALL;


ALTER TABLE public.follows DISABLE TRIGGER ALL;

INSERT INTO public.follows (id, follower_id, user_id) VALUES ('cdfe5dc4-7514-41cd-a41a-f16a0cddf90a', 'caafb393-ea09-48ef-af2c-db2319ef4fd8', '1a659b1c-4f0c-41e0-9e49-a1e62bfc39f8');
INSERT INTO public.follows (id, follower_id, user_id) VALUES ('24f58b3f-b94a-4be0-8565-6c766aef7d66', '1a659b1c-4f0c-41e0-9e49-a1e62bfc39f8', 'caafb393-ea09-48ef-af2c-db2319ef4fd8');
INSERT INTO public.follows (id, follower_id, user_id) VALUES ('5b167cc1-4a4c-4be8-8505-871bcc653456', '1a659b1c-4f0c-41e0-9e49-a1e62bfc39f8', '0d7e8501-a02a-43bb-ae3d-3c318c4cac16');


ALTER TABLE public.follows ENABLE TRIGGER ALL;


ALTER TABLE public.likes DISABLE TRIGGER ALL;

INSERT INTO public.likes (id, post_id, user_id) VALUES ('009910ba-4385-4112-8c22-52c3ca3d73bb', '0b807f4a-7188-46f1-90dc-105e804beb12', '1a659b1c-4f0c-41e0-9e49-a1e62bfc39f8');


ALTER TABLE public.likes ENABLE TRIGGER ALL;


