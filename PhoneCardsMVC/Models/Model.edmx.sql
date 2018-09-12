
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 07/26/2018 18:26:40
-- Generated from EDMX file: C:\Users\VKT-HASANY\Desktop\PhoneCardsMVC-master\PhoneCardsMVC\Models\Model.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [PhoneCardsDB];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_Contact_Company]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Contact] DROP CONSTRAINT [FK_Contact_Company];
GO
IF OBJECT_ID(N'[dbo].[FK_Contact_ConsultantType]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Contact] DROP CONSTRAINT [FK_Contact_ConsultantType];
GO
IF OBJECT_ID(N'[dbo].[FK_Contact_Department]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Contact] DROP CONSTRAINT [FK_Contact_Department];
GO
IF OBJECT_ID(N'[dbo].[FK_Contact_Group]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Contact] DROP CONSTRAINT [FK_Contact_Group];
GO
IF OBJECT_ID(N'[dbo].[FK_Contact_Title]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Contact] DROP CONSTRAINT [FK_Contact_Title];
GO
IF OBJECT_ID(N'[dbo].[FK_Department_Company]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Department] DROP CONSTRAINT [FK_Department_Company];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Company]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Company];
GO
IF OBJECT_ID(N'[dbo].[ConsultantType]', 'U') IS NOT NULL
    DROP TABLE [dbo].[ConsultantType];
GO
IF OBJECT_ID(N'[dbo].[Contact]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Contact];
GO
IF OBJECT_ID(N'[dbo].[Department]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Department];
GO
IF OBJECT_ID(N'[dbo].[Group]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Group];
GO
IF OBJECT_ID(N'[dbo].[Title]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Title];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Company'
CREATE TABLE [dbo].[Company] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(50)  NOT NULL
);
GO

-- Creating table 'ConsultantType'
CREATE TABLE [dbo].[ConsultantType] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(50)  NOT NULL
);
GO

-- Creating table 'Contact'
CREATE TABLE [dbo].[Contact] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(50)  NOT NULL,
    [Surname] nvarchar(50)  NOT NULL,
    [Phone] nvarchar(50)  NOT NULL,
    [GroupId] int  NOT NULL,
    [CompanyId] int  NULL,
    [DepartmentId] int  NULL,
    [ConsultantTypeId] int  NULL,
    [TitleId] int  NULL,
    [IsActive] bit  NOT NULL
);
GO

-- Creating table 'Department'
CREATE TABLE [dbo].[Department] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(50)  NOT NULL,
    [CompanyId] int  NOT NULL
);
GO

-- Creating table 'Group'
CREATE TABLE [dbo].[Group] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(50)  NOT NULL
);
GO

-- Creating table 'Title'
CREATE TABLE [dbo].[Title] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(50)  NOT NULL,
    [GroupId] int  NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [Id] in table 'Company'
ALTER TABLE [dbo].[Company]
ADD CONSTRAINT [PK_Company]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'ConsultantType'
ALTER TABLE [dbo].[ConsultantType]
ADD CONSTRAINT [PK_ConsultantType]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Contact'
ALTER TABLE [dbo].[Contact]
ADD CONSTRAINT [PK_Contact]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Department'
ALTER TABLE [dbo].[Department]
ADD CONSTRAINT [PK_Department]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Group'
ALTER TABLE [dbo].[Group]
ADD CONSTRAINT [PK_Group]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Title'
ALTER TABLE [dbo].[Title]
ADD CONSTRAINT [PK_Title]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [CompanyId] in table 'Department'
ALTER TABLE [dbo].[Department]
ADD CONSTRAINT [FK_Department_Company]
    FOREIGN KEY ([CompanyId])
    REFERENCES [dbo].[Company]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Department_Company'
CREATE INDEX [IX_FK_Department_Company]
ON [dbo].[Department]
    ([CompanyId]);
GO

-- Creating foreign key on [TitleId] in table 'Contact'
ALTER TABLE [dbo].[Contact]
ADD CONSTRAINT [FK_Contact_Title]
    FOREIGN KEY ([TitleId])
    REFERENCES [dbo].[Title]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Contact_Title'
CREATE INDEX [IX_FK_Contact_Title]
ON [dbo].[Contact]
    ([TitleId]);
GO

-- Creating foreign key on [CompanyId] in table 'Contact'
ALTER TABLE [dbo].[Contact]
ADD CONSTRAINT [FK_Contact_Company]
    FOREIGN KEY ([CompanyId])
    REFERENCES [dbo].[Company]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Contact_Company'
CREATE INDEX [IX_FK_Contact_Company]
ON [dbo].[Contact]
    ([CompanyId]);
GO

-- Creating foreign key on [ConsultantTypeId] in table 'Contact'
ALTER TABLE [dbo].[Contact]
ADD CONSTRAINT [FK_Contact_ConsultantType]
    FOREIGN KEY ([ConsultantTypeId])
    REFERENCES [dbo].[ConsultantType]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Contact_ConsultantType'
CREATE INDEX [IX_FK_Contact_ConsultantType]
ON [dbo].[Contact]
    ([ConsultantTypeId]);
GO

-- Creating foreign key on [DepartmentId] in table 'Contact'
ALTER TABLE [dbo].[Contact]
ADD CONSTRAINT [FK_Contact_Department]
    FOREIGN KEY ([DepartmentId])
    REFERENCES [dbo].[Department]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Contact_Department'
CREATE INDEX [IX_FK_Contact_Department]
ON [dbo].[Contact]
    ([DepartmentId]);
GO

-- Creating foreign key on [GroupId] in table 'Contact'
ALTER TABLE [dbo].[Contact]
ADD CONSTRAINT [FK_Contact_Group]
    FOREIGN KEY ([GroupId])
    REFERENCES [dbo].[Group]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Contact_Group'
CREATE INDEX [IX_FK_Contact_Group]
ON [dbo].[Contact]
    ([GroupId]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------