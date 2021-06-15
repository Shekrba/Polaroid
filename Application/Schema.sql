-- Your database schema. Use the Schema Designer at http://localhost:8001/ to add some tables.
CREATE TABLE users (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    email TEXT NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    locked_at TIMESTAMP WITH TIME ZONE DEFAULT NULL,
    failed_login_attempts INT DEFAULT 0 NOT NULL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    picture_url TEXT DEFAULT 'images/user-placeholder.jpg'
);
CREATE TABLE posts (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    description TEXT DEFAULT NULL,
    user_id UUID NOT NULL,
    picture_url TEXT DEFAULT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL
);
CREATE INDEX posts_user_id_index ON posts (user_id);
CREATE TABLE follows (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    follower_id UUID NOT NULL,
    user_id UUID NOT NULL
);
ALTER TABLE follows ADD CONSTRAINT follows_ref_follower_id FOREIGN KEY (follower_id) REFERENCES users (id) ON DELETE NO ACTION;
ALTER TABLE follows ADD CONSTRAINT follows_ref_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE NO ACTION;
ALTER TABLE posts ADD CONSTRAINT posts_ref_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE;
