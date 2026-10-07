USE passwords;

SET @key_str = UNHEX(SHA2('fall-2026-databases-assignment-2',512));

-- Create a new entry into the database, which already has your ten initial entries.
INSERT INTO websites (website_name, url)
VALUES ('MYSQL','https://www.mysql,com/');

INSERT INTO accounts (users_id, website_id, username, email, password, comment)
SELECT u.users_id,
       w.website_id,
       'keller_05',
       'keller@gmail.com',
       AES_ENCRYPT('vT*mQx2LrN4p', @key_str),
       'registered for mysql'
FROM users AS u
CROSS JOIN websites AS w
where u.first_name = 'Keller'
    AND u.last_name = 'Casey'
    AND w.url = 'https://www.mysql,com/';


-- Get the password associated with the URL of one of your ten entries.
SELECT  w.website_name,
        w.url,
        a.username,
        CAST(AES_DECRYPT(a.password, @key_str) AS CHAR) AS password
FROM accounts AS a
INNER JOIN websites AS w
    ON a.website_id = w.website_id
WHERE w.url = 'https://blackboard.hartford.edu/ultra/stream';

-- Get all the password-related data, including the *decrypted* password, associated with URLs that have `https` in two of your ten entries.
SELECT  u.first_name,
        u.last_name,
        w.website_name,
        w.url,
        a.username,
        a.email,
        CAST(AES_DECRYPT(a.password, @key_str) AS CHAR) AS password,
        a.comment,
        a.created_at
FROM accounts AS a
INNER JOIN users AS u
    ON a.users_id = u.users_id
INNER JOIN websites AS w
    ON a.website_id = w.website_id
WHERE w.url LIKE 'https://%'
ORDER BY a.created_at
LIMIT 2;

-- Change a URL associated with one of the passwords in your ten entries.
UPDATE websites
SET url = 'https://www.dropbox.com/home/'
WHERE url = 'https://www.dropbox.com/';

-- Change the password to any entry.
UPDATE accounts AS a
INNER JOIN websites AS w
    ON a.website_id = w.website_id
SET a.password = AES_ENCRYPT('Rk7wPz3mLq9X', @key_str)
WHERE w.url = 'https://github.com/'
and a.username = 'Peytonm';

-- Remove a tuple based on a URL.
DELETE FROM websites
WHERE url = 'https://www.youtube.com/';

-- Remove a tuple based on a password.
DELETE FROM accounts
WHERE CAST(AES_DECRYPT(password, @key_str) AS CHAR) = '4pTKJyBnL4ry';