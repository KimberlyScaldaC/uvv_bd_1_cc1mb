create user kimberly with encrypted password '123';
alter user kimberly with createdb;
create database uvv with owner kimberly template template0 encoding 'UTF8' lc_collate 'pt_BR.UTF-8' lc_ctype 'pt_BR.UTF-8' allow_connections true;

\c uvv kimberly