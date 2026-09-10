USE [ShopBanHang];
GO

IF NOT EXISTS (SELECT 1 FROM dbo.app_user WHERE username = N'admin')
BEGIN
    INSERT INTO dbo.app_user
        (username, password, full_name, email, phone, role, status, created_at, updated_at)
    VALUES
        (N'admin', N'$2a$10$jin4qtDs7ywWDmgjRlVU1OYqFsCN0J5Tmt9h3sOVtXmumbupt4arW',
         N'System Administrator', N'admin@shopbanhang.local', NULL, N'ADMIN', 1, SYSUTCDATETIME(), NULL);
END;
GO
