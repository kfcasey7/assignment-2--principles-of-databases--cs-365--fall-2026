DROP DATABASE IF EXISTS passwords;
CREATE DATABASE passwords
    DEFAULT CHARACTER SET utf8mb4;

USE passwords;

SET @key_str = UNHEX(SHA2('fall-2026-databases-assignment-2', 512));

CREATE TABLE users
(
    users_id    INT UNSIGNED    NOT NULL AUTO_INCREMENT,
    first_name  VARCHAR(64)     NOT NULL,
    last_name   VARCHAR(64)     NOT NULL,
    PRIMARY KEY (users_id)
);

CREATE TABLE websites
(
    website_id      INT UNSIGNED    NOT NULL AUTO_INCREMENT,
    website_name    VARCHAR(128)    NOT NULL,
    url             VARCHAR(255)    NOT NULL,
    PRIMARY KEY (website_id),
    UNIQUE KEY uq_websites_url (url)
);

CREATE TABLE accounts
(
    account_id  INT UNSIGNED    NOT NULL AUTO_INCREMENT,
    users_id    INT UNSIGNED    NOT NULL,
    website_id  INT UNSIGNED    NOT NULL,
    username    VARCHAR(64)     NOT NULL,
    email       VARCHAR(255)    NOT NULL,
    password    VARBINARY(256)  NOT NULL,
    comment     VARCHAR(512),
    created_at  TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (account_id),
    UNIQUE KEY  uq_accounts_user_site_username  (users_id, website_id, username),
    CONSTRAINT fk_accounts_user
        FOREIGN KEY (users_id) REFERENCES users (users_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_accounts_website
        FOREIGN KEY (website_id) REFERENCES websites (website_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

INSERT INTO users (first_name, last_name)
VALUES 
    ('Keller', 'Casey'),
    ('Peyton', 'Mize'),
    ('John', 'Kelly');

INSERT INTO websites (website_name, url)
VALUES
    ('BlackBoard','https://blackboard.hartford.edu/ultra/stream'),
    ('Strava', 'https://www.strava.com/dashboard'),
    ('Google Drive', 'https://drive.google.com/'),
    ('Amazon', 'https://www.amazon.com/'),
    ('Youtube', 'https://www.youtube.com/'),
    ('LinkedIn', 'https://www.linkedin.com/in/keller-casey-5614ab323/'),
    ('Github', 'https://github.com/'),
    ('Map My Run', 'https://www.mapmyrun.com/dashboard'),
    ('Gmail', 'https://mail.google.com/'),
    ('Dropbox', 'https://www.dropbox.com/');

INSERT INTO accounts (users_id, website_id, username, email, password, comment, created_at)
VALUES
    (1, 1, 'kcasey', 'keller@example.com', AES_ENCRYPT('pDF6sgL6GDz3', @key_str), 'For School', '2026-09-26 09:30:05'),
    (1, 2, 'keller05', 'keller@example.com', AES_ENCRYPT('Jzez9kpYRmHe', @key_str), 'Only on phone', '2024-08-06 04:35:28'),
    (1, 3, 'kcasey', 'keller@example.com', AES_ENCRYPT('cdx3nNyhAVVL', @key_str), 'Same for all google products', '2025-03-16 07:03:12'),
    (1, 4, 'Kel_Runner', 'kcasey@example.com', AES_ENCRYPT('MQfqWDuv2rHZ', @key_str), 'Family account', '2023-02-28 08:37:31'),
    (2, 5, 'Pmize', 'pmize@example.com', AES_ENCRYPT('b6mbKP4NPxxw', @key_str), 'Google login', '2019-05-23 05:28:57'),
    (2, 6, 'Peypey', 'pmize@example.com', AES_ENCRYPT('WGEhJvEtvRYn', @key_str), 'Good Account', '2021-07-27 10:34:33'),
    (2, 7, 'Peytonm', 'pmize@example.com', AES_ENCRYPT('agedWnhC9BcW', @key_str), 'old account', '2022-01-24 22:12:54'),
    (3, 8, 'Johnk', 'johkel@example.com', AES_ENCRYPT('e3554agzFjqf', @key_str), 'Same for Strava', '2026-03-17 05:09:23'),
    (3, 9, 'EpicGamer37', 'johnk@example.com', AES_ENCRYPT('4pTKJyBnL4ry', @key_str), 'google account', '2025-11-04 17:54:00'),
    (3, 10, 'Johnk', 'johkel@example.com', AES_ENCRYPT('6jrA4UMDRcC6', @key_str), 'extra storage', '2024-04-30 23:14:52');