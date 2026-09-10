IF DB_ID(N'ShopBanHang') IS NULL
BEGIN
    CREATE DATABASE [ShopBanHang];
END;
GO

USE [ShopBanHang];
GO

IF OBJECT_ID(N'dbo.category', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.category
    (
        id          BIGINT IDENTITY(1,1) NOT NULL,
        name        NVARCHAR(255) NOT NULL,
        description NVARCHAR(1000) NULL,
        status      BIT NOT NULL
            CONSTRAINT DF_category_status DEFAULT (1),
        created_at  DATETIME2 NOT NULL
            CONSTRAINT DF_category_created_at DEFAULT (SYSUTCDATETIME()),
        updated_at  DATETIME2 NULL,
        CONSTRAINT PK_category PRIMARY KEY (id)
    );
END;
GO

IF OBJECT_ID(N'dbo.app_user', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.app_user
    (
        id         BIGINT IDENTITY(1,1) NOT NULL,
        username   NVARCHAR(100) NOT NULL,
        password   NVARCHAR(255) NOT NULL,
        full_name  NVARCHAR(255) NULL,
        email      NVARCHAR(255) NOT NULL,
        phone      NVARCHAR(20) NULL,
        role       NVARCHAR(20) NOT NULL
            CONSTRAINT DF_app_user_role DEFAULT (N'ADMIN'),
        status     BIT NOT NULL
            CONSTRAINT DF_app_user_status DEFAULT (1),
        created_at DATETIME2 NOT NULL
            CONSTRAINT DF_app_user_created_at DEFAULT (SYSUTCDATETIME()),
        updated_at DATETIME2 NULL,
        CONSTRAINT PK_app_user PRIMARY KEY (id),
        CONSTRAINT UQ_app_user_username UNIQUE (username),
        CONSTRAINT UQ_app_user_email UNIQUE (email)
    );
END;
GO
