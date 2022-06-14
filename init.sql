DROP DATABASE instagram;
CREATE DATABASE instagram;
USE instagram;

CREATE TABLE users (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE photos (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
    image VARCHAR(255) NOT NULL,
    user_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(id)
);

CREATE TABLE comments (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
    body VARCHAR(255) NOT NULL,
    user_id INTEGER NOT NULL,
    photo_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(photo_id) REFERENCES photos(id)
);

CREATE TABLE likes (
    user_id INTEGER NOT NULL,
    photo_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(photo_id) REFERENCES photos(id),
    PRIMARY KEY(user_id, photo_id)
);

CREATE TABLE supscriptions (
    follower_id INTEGER NOT NULL,
    followee_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(follower_id) REFERENCES users(id),
    FOREIGN KEY(followee_id) REFERENCES users(id),
    PRIMARY KEY(follower_id, followee_id)
);

CREATE TABLE tags (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE photo_tag (
    photo_id INTEGER NOT NULL,
    tag_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(photo_id) REFERENCES photos(id),
    FOREIGN KEY(tag_id) REFERENCES tags(id),
    PRIMARY KEY(photo_id, tag_id)
);

INSERT INTO users (username) VALUES
('Stalker'),
('Sasuke'),
('Homer');

INSERT INTO photos (image, user_id) VALUES
('https://ixbt.online/live/images/original/19/31/48/2020/12/16/9af265dc51.jpg', 1),
('https://images5.alphacoders.com/956/956208.png', 2),
('https://www.pngarts.com/files/11/Homer-Simpson-PNG-Transparent-Image.png', 3),
('https://i.pinimg.com/originals/bd/19/2f/bd192f2723f7d81013f04903d9e0428b.png', 3);

INSERT INTO comments(body, user_id, photo_id) VALUES
('I love you, Sasuke-kun!', 3, 2),
('Sasuke, how far you have fallen?', 1, 2),
('Homer, I am straight! So shut up!', 2, 3);

INSERT INTO likes(user_id, photo_id) VALUES
(3, 2),
(1, 2),
(1, 3),
(3, 1);

-- Command below will not work because of the constraint. Foreign keys should have unique combination.
-- INSERT INTO likes (user_id, photo_id) VALUES (1, 2);

INSERT INTO supscriptions(follower_id, followee_id) VALUES
(1, 2),
(3, 2),
(1, 3),
(3, 1);

INSERT INTO tags(name) VALUES
('cute'),
('kawaii'),
('sunset');

INSERT INTO photo_tag(photo_id, tag_id) VALUES
(1, 1),
(2, 1),
(3, 2);

SELECT users.username, photos.image 
FROM users 
JOIN photos ON users.id = photos.user_id