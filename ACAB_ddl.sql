USE master;
GO

IF DB_ID('NOS_NUTRI') IS NOT NULL
	ALTER DATABASE HAMMER_ACCES_CONTROL SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE HAMMER_ACCES_CONTROL
GO

CREATE DATABASE HAMMER_ACCES_CONTROL
GO

USE HAMMER_ACCES_CONTROL
GO

-- ===================================================================
-- Create Resource 
-- =================================================================== 
CREATE TABLE permission_type
(
	[type] VARCHAR(255) NOT NULL PRIMARY KEY
) 

-- ===================================================================
-- Create Resource 
-- =================================================================== 
CREATE TABLE [resource]
(
	[application] VARCHAR(255) NOT NULL PRIMARY KEY
)

-- ===================================================================
-- Create Page 
-- =================================================================== 
CREATE TABLE [page]
(
	[url] VARCHAR(255) NOT NULL,
	[resource] VARCHAR(255) NOT NULL

	CONSTRAINT page_pk PRIMARY KEY ([url]),
	CONSTRAINT fk_page_ref_resource FOREIGN KEY ([resource])
		REFERENCES [resource]([application])
			ON UPDATE CASCADE ON DELETE CASCADE
)

-- ===================================================================
-- Create Role 
-- =================================================================== 
CREATE TABLE [role]
(
	[title] VARCHAR(255) NOT NULL PRIMARY KEY
)

-- ===================================================================
-- Create Role 
-- =================================================================== 
CREATE TABLE [user]
(
	[name] VARCHAR(255) NOT NULL PRIMARY KEY,
	[password] VARCHAR(1024) NOT NULL,
	[profession] VARCHAR(255) NOT NULL

	CONSTRAINT fk_user_ref_role FOREIGN KEY ([profession])
		REFERENCES [role]([title])
			ON UPDATE CASCADE ON DELETE CASCADE
)

-- ===================================================================
-- Create Permission 
-- =================================================================== 
CREATE TABLE [permission]
(
	[url] VARCHAR(255) NOT NULL,
	[role] VARCHAR(255) NOT NULL ,
	[type] VARCHAR(255) NOT NULL

	CONSTRAINT pk_permission PRIMARY KEY([url], [role])

	CONSTRAINT fk_permission_ref_page FOREIGN KEY ([url])
		REFERENCES [page]([url])
			ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT fk_permission_ref_role FOREIGN KEY ([role])
		REFERENCES [role]([title])
			ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT fk_permission_ref_permission_type FOREIGN KEY ([type])
		REFERENCES [permission_type]([type])
			ON UPDATE CASCADE ON DELETE CASCADE
)