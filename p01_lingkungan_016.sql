CREATE DATABASE IF NOT EXISTS perpus_016
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

CREATE USER IF NOT EXISTS 'dev_016'@'localhost'
IDENTIFIED BY '<***********>';

GRANT ALL PRIVILEGES
ON perpus_016.*
TO 'dev_016'@'localhost';

SHOW GRANTS FOR 'dev_016'@'localhost';  