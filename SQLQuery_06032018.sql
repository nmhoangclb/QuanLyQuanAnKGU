CREATE DATABASE QuanLyQuanAn
GO

USE QuanLyQuanAn
GO

--Food
--Table
--FoodCategory
--Account
--Bill
--BillInfo

CREATE TABLE TableFood
(
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100)  NOT NULL DEFAULT N'Bàn chưa đặt tên',
	status NVARCHAR(100)  NOT NULL DEFAULT N'Trống' --Trống || Có người

)
GO


CREATE TABLE Account
(
	UserName NVARCHAR(100) PRIMARY KEY,
	DisplayName NVARCHAR(100) NOT NULL DEFAULT N'KGU',
	PassWord NVARCHAR(1000) NOT NULL DEFAULT 0,
	Type INT  NOT NULL DEFAULT 0 -- 1: admin || 0: staff
)
GO

CREATE TABLE FoodCategory
(
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) NOT NULL DEFAULT N'Chưa đặt tên'
)
GO

CREATE TABLE Food
(
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) NOT NULL DEFAULT N'Chưa đặt tên',
	idCategory INT NOT NULL,
	price FLOAT NOT NULL DEFAULT 0,
	
	FOREIGN KEY (idCategory) REFERENCES FoodCategory(id)
)
GO

CREATE TABLE Bill
(
	id INT IDENTITY PRIMARY KEY,
	DateCheckIn DATE NOT NULL,
	DateCheckOut DATE,
	idTable INT NOT NULL,
	status INT NOT NULL DEFAULT 0, -- 1: Đã thanh toán || 0: Chưa thanh toán
	
	FOREIGN KEY (idTable) REFERENCES TableFood(id)
)
GO

CREATE TABLE BillInfo
(
	id INT IDENTITY PRIMARY KEY,
	idBill INT NOT NULL,
	idFood INT NOT NULL,
	count INT NOT NULL DEFAULT 0,
	
	FOREIGN KEY (idBill) REFERENCES Bill(id),
	FOREIGN KEY (idFood) REFERENCES Food(id)
)
GO
--Thêm dữ liệu cho Account
INSERT INTO Account
(
	UserName,
	DisplayName,
	[PassWord],
	[Type]
)
VALUES
(
	
	N'admin',
	N'admin',
	N'admin',
	1
)
INSERT INTO Account
(
	UserName,
	DisplayName,
	[PassWord],
	[Type]
)
VALUES
(
	
	N'staff',
	N'staff',
	N'123456',
	0
)
GO
--Tạo store procedures 

CREATE PROC USP_GetAccountByUserName
@userName NVARCHAR(100)
AS
BEGIN
	SELECT * FROM Account WHERE UserName= @userName
END
GO

--EXECUTE USP_GetAccountByUserName @userName = N'staff'

--DROP PROC USP_GetAccountByUserName
--thêm dữ liệu vào bảng category và food
INSERT INTO FoodCategory
(
	-- id -- this column value is auto-generated
	name
)
VALUES
(
	N'Hải sản tươi sống'
)
INSERT INTO FoodCategory
(
	-- id -- this column value is auto-generated
	name
)
VALUES
(
	N'Thịt rừng'
)
--SELECT * FROM FoodCategory

INSERT INTO Food
(
	-- id -- this column value is auto-generated
	name,
	idCategory,
	price
)
VALUES
(
	N'Mực nướng muối ớt',
	1,
	120000
)
INSERT INTO Food
(
	-- id -- this column value is auto-generated
	name,
	idCategory,
	price
)
VALUES
(
	N'Tôm hùm xào me',
	1,
	150000
)
INSERT INTO Food
(
	-- id -- this column value is auto-generated
	name,
	idCategory,
	price
)
VALUES
(
	N'Heo rừng nướng mọi',
	2,
	80000
)

INSERT INTO Food
(
	-- id -- this column value is auto-generated
	name,
	idCategory,
	price
)
VALUES
(
	N'Nai xào sa tế',
	2,
	100000
)

CREATE PROC USP_Login
@userName NVARCHAR(100), @passWord NVARCHAR(100)
AS
BEGIN
	SELECT * FROM Account WHERE UserName= @userName AND PassWord = @passWord
	
END
GO
INSERT INTO TableFood
(
	-- id -- this column value is auto-generated
	name,
	[status]
)
VALUES
(
	N'BÀN 1',N'Trống'
	
)
INSERT INTO TableFood
(
	-- id -- this column value is auto-generated
	name,
	[status]
)
VALUES
(
	N'BÀN 2',N'Trống'
	
)
INSERT INTO TableFood
(
	-- id -- this column value is auto-generated
	name,
	[status]
)
VALUES
(
	N'BÀN 4',
	N'Trống'
	
)
INSERT INTO TableFood
(
	-- id -- this column value is auto-generated
	name,
	[status]
)
VALUES
(
	N'BÀN 5',
	N'Trống'
	
)
GO

DECLARE @i INT =36
WHILE @i < 45
BEGIN
	INSERT INTO TableFood(NAME,[status])VALUES(N'BÀN ' + cast(@i AS NVARCHAR(100)),N'Có người')
	SET @i = @i +1
END
GO 
create PROC USP_GetTableList
AS
BEGIN
	 SELECT * FROM TableFood
END

GO 


--execute USP_GetTableList
--DROP DATABASE QuanLyQuanAn
--insert bill
INSERT INTO Bill  ( DateCheckIn,DateCheckOut,idTable,[status] )
VALUES ( GETDATE(), NULL, 1, 0)
INSERT INTO Bill  ( DateCheckIn,DateCheckOut,idTable,[status] )
VALUES ( GETDATE(), NULL, 2, 1)
INSERT INTO Bill  ( DateCheckIn,DateCheckOut,idTable,[status] )
VALUES ( GETDATE(), NULL, 3, 0)
--insert billInfo
INSERT INTO BillInfo ( idBill,idFood,[count]) VALUES (1,1,2)

INSERT INTO FoodCategory
(
	-- id -- this column value is auto-generated
	name
)
VALUES
(
	N'Đồ uống'
)
INSERT INTO Food
(
	-- id -- this column value is auto-generated
	name,
	idCategory,
	price
)
VALUES
(
	N'Heniken',
	3,
	26000
)
INSERT INTO BillInfo
(
	-- id -- this column value is auto-generated
	idBill,
	idFood,
	[count]
)
VALUES
(
	3,
	4,
	3
)

SELECT * FROM Bill
SELECT * FROM BillInfo
SELECT * FROM Food
SELECT * FROM FoodCategory
SELECT id FROM Bill WHERE idTable = 3 AND [status] = 0