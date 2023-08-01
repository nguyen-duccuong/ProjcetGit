create database DB_DULICH
--tạo bảng "điểm đến"--
create table DiemDen(
	MaDiemDen varchar(50) primary key,
	TenDiemDen nvarchar(50),
	MoTa nvarchar(150)
);

--tạo bảng "Tour"--
create table Tour(
	MaTour varchar(50) primary key,
	MaDiemDen varchar(50),
	Ten_tour nvarchar(150),
	MoTa_tour nvarchar(150),
	Gia_tour int,
	Tgian int,
	Ngay_kh date,
	Ngay_kt date
);

--tạo bảng "Khách hàng"--
create table KhachHang(
	MaKhachHang varchar(50) primary key,
	hoten nvarchar(50),
	email varchar(50),
	sdt varchar(10)
);

--tạo bảng "khách hàng đã hoàn thành tour du lịch"
create table KhachHang2(
	email varchar(50) primary key,
	MaTour varchar(50),
	hoten nvarchar(50),
	sdt varchar(50),
);

--tạo bảng "đặt tour"--
create table DatTour(
	id int IDENTITY(1,1) primary key,
	MaTour varchar(50),
	MaKhachHang varchar(50),
	NgayDat date,
	SoNguoi int,
	TongTien int,
	NVDatTour varchar(50)
);

--tạo bảng "admin"--
create table NhanVienHT(
	MaNV varchar(50) primary key,
	Hoten nvarchar(50),
	username varchar(50),
	gt nvarchar(50),
	ngaysinh date,
	email varchar(50),
	Mat_khau varchar(50)
);

--tạo bảng "đánh giá"--
create table DanhGia(
	id int IDENTITY(1,1) primary key,
	MaTour varchar(50),
	TenKhachHang nvarchar(50),
	email varchar(50),
	sdt varchar(10),
	Rating int,
	PhanHoi nvarchar(255)
);

--add constraint
--bảng "điểm đến"--
alter table DiemDen
alter column TenDiemDen nvarchar(150) not null
alter table DiemDen
add constraint unq_DiemDen unique(TenDiemDen)
alter table DiemDen
alter column MoTa nvarchar(max) not null

--bảng "tour"--
alter table Tour
add constraint fk_Tour foreign key(MaDiemDen) references DiemDen(MaDiemDen) 
ALTER TABLE Tour
alter column Ten_tour nvarchar(150) not null
ALTER TABLE Tour
alter column MoTa_tour nvarchar(max) not null
ALTER TABLE Tour
alter column Gia_tour int not null
ALTER TABLE Tour
alter column Tgian int not null
ALTER TABLE Tour
alter column Ngay_kh date not null
ALTER TABLE Tour
alter column Ngay_kt date not null

--bảng "khách hàng"--
alter table KhachHang
alter column email varchar(50) not null
alter table KhachHang
alter column hoten nvarchar(50) not null
alter table KhachHang
alter column sdt varchar(10) not null
alter table KhachHang
add constraint unq_KhachHangsdt unique(sdt)
alter table KhachHang
add constraint unq_KhachHang unique(email)
alter table KhachHang 
add constraint chk_kh check(email LIKE '%_@__%.__%')

-- bảng "khách hàng 2"
alter table KhachHang2
alter column hoten nvarchar(50) not null
alter table KhachHang2
alter column sdt varchar(10) not null
alter table KhachHang2
add constraint unq_KhachHang2sdt unique(sdt)
alter table KhachHang2
add constraint unq_KhachHang2 unique(email)
alter table KhachHang2
add constraint chk_kh2 check(email LIKE '%_@__%.__%')
alter table KhachHang2
add constraint fk_kh2_tour foreign key(MaTour) references Tour(MaTour)


--bảng "đặt tour"--
alter table DatTour
add constraint fk_Dattour_t foreign key(MaTour) references Tour(MaTour)
alter table DatTour
add constraint fk_Dattour_kh foreign key(MaKhachHang) references KhachHang(MaKhachHang)
alter table DatTour 
alter column NgayDat  date not null
alter table DatTour 
alter column SoNguoi int not null
alter table DatTour
add constraint fk_dt_nv foreign key(NVDatTour) references NhanVienHT(MaNV)

--Nhân viên hệ thống
alter table NhanVienHT
alter column username varchar(50) not null
alter table NhanVienHT
alter column Hoten nvarchar(50) not null
alter table NhanVienHT
alter column Mat_khau varchar(50) not null
alter table NhanVienHT
add constraint unq_nv unique(username)
alter table NhanVienHT 
add constraint chk_nv check(email LIKE '%_@__%.__%')

--bảng "đánh giá"--
alter table DanhGia
alter column TenKhachHang nvarchar(50) not null
alter table DanhGia
alter column Rating int null
alter table DanhGia
add constraint chk_danhgia check(Rating>0 and Rating <=5)
alter table DanhGia
alter column email varchar(50) not null
alter table DanhGia
alter column PhanHoi nvarchar(255) not null
alter table DanhGia
add constraint fk_dg_kh2 foreign key(email) references KhachHang2(email)

INSERT INTO NhanVienHT (MaNV, Hoten, username, email, Mat_khau) 
VALUES ('NV001', N'Trần Văn A', 'tranvana', 'tranvana@example.com', 'password123'), 
       ('NV002', N'Nguyễn Thị B', 'nguyenthib', 'nguyenthib@example.com', 'abc123'), 
       ('NV003', N'Lê Quang C', 'lequangc', 'lequangc@example.com', 'xyz456')

INSERT INTO KhachHang (MaKhachHang, hoten, email, sdt)
VALUES ('KH001', N'Nguyễn Văn A', 'nguyenvana@example.com', '0368009150'),
       ('KH002', N'Trần Thị B', 'tranthib@example.com', '0368009151'),
       ('KH003', N'Lê Minh C', 'leminhc@example.com', '0368009152'),
       ('KH004', N'Phạm Hoàng D', 'phamhoangd@example.com', '0368009153'),
       ('KH005', N'Đặng Thị E', 'dangthie@example.com', '0368009154'),
       ('KH006', N'Huỳnh Văn F', 'huynhvanf@example.com', '0368009155'),
       ('KH007', N'Ngô Thị G', 'ngothig@example.com', '0368009156'),
       ('KH008', N'Lương Văn H', 'luongvanh@example.com', '0368009157'),
       ('KH009', N'Bùi Thị I', 'buithii@example.com', '0368009158'),
       ('KH010', N'Võ Minh K', 'vominhk@example.com', '0368009159'),
       ('KH011', N'Trương Hoàng L', 'truonghoangl@example.com', '0368009160'),
       ('KH012', N'Hoàng Thị M', 'hoangthim@example.com', '0368009161'),
       ('KH013', N'Vương Văn N', 'vuongvann@example.com', '0368009162'),
       ('KH014', N'Lý Thị O', 'lythio@example.com', '0368009163'),
       ('KH015', N'Mạc Văn P', 'macvanp@example.com', '0368009164')

INSERT INTO DiemDen (MaDiemDen, TenDiemDen, MoTa)
VALUES ('DD001', N'Hạ Long', N'Hạ Long là một trong những kỳ quan thiên nhiên của Việt Nam, với vịnh núi đá và hang động nổi tiếng.'),
       ('DD002', N'Phong Nha - Kẻ Bàng', N'Phong Nha - Kẻ Bàng là một khu dự trữ sinh quyển và di sản thế giới của UNESCO với hệ thống hang động độc đáo.'),
       ('DD003', N'Hội An', N'Hội An là một thành phố cổ được bảo tồn tốt nhất tại Việt Nam, với kiến trúc pha trộn giữa phong cách Á Đông và phương Tây.'),
       ('DD004', N'Đà Lạt', N'Đà Lạt là một thành phố núi và khu du lịch nổi tiếng với khí hậu mát mẻ, hoa cỏ và kiến trúc độc đáo.'),
       ('DD005', N'Ninh Bình', N'Ninh Bình có phong cảnh đẹp với các khu vực đồng cỏ, đá vôi và các hang động nổi tiếng như Tam Cốc - Bích Động.'),
       ('DD006', N'Phú Quốc', N'Phú Quốc là hòn đảo lớn nhất của Việt Nam nằm ở Vịnh Thái Lan, với các bãi biển tuyệt đẹp và du lịch nghỉ dưỡng.'),
       ('DD007', N'Sapa', N'Sapa là một điểm đến núi cao nằm trong dãy Hoàng Liên Sơn, với cảnh quan tuyệt đẹp và văn hóa đặc trưng của người dân tộc thiểu số.'),
       ('DD008', N'Huế', N'Huế là một thành phố cổ với di sản văn hóa thế giới như Cố đô Huế và nhiều công trình kiến trúc lịch sử.'),
       ('DD009', N'Đà Nẵng', N'Đà Nẵng là một thành phố du lịch nổi tiếng với bãi biển Mỹ Khê, cầu Rồng và nhiều điểm tham quan khác.')

INSERT INTO Tour (MaTour, MaDiemDen, Ten_tour, MoTa_tour, Gia_tour, Tgian, Ngay_kh, Ngay_kt)
VALUES 
    ('MT1', 'DD001', N'Tour 1', N'Mô tả tour 1', 1000000, 5, '2023-06-01', '2023-06-10'),
    ('MT2', 'DD002', N'Tour 2', N'Mô tả tour 2', 1500000, 7, '2023-06-15', '2023-06-30'),
    ('MT3', 'DD003', N'Tour 3', N'Mô tả tour 3', 2000000, 4, '2023-07-01', '2023-07-07'),
    ('MT4', 'DD004', N'Tour 4', N'Mô tả tour 4', 1200000, 6, '2023-07-10', '2023-07-20'),
    ('MT5', 'DD005', N'Tour 5', N'Mô tả tour 5', 1800000, 8, '2023-07-25', '2023-08-02'),
    ('MT6', 'DD006', N'Tour 6', N'Mô tả tour 6', 1600000, 5, '2023-08-05', '2023-08-12'),
    ('MT7', 'DD007', N'Tour 7', N'Mô tả tour 7', 1900000, 7, '2023-08-15', '2023-08-23'),
    ('MT8', 'DD008', N'Tour 8', N'Mô tả tour 8', 2200000, 6, '2023-08-25', '2023-09-02'),
    ('MT9', 'DD009', N'Tour 9', N'Mô tả tour 9', 2500000, 9, '2023-09-05', '2023-09-15')

INSERT INTO DatTour (MaTour, MaKhachHang, NgayDat, SoNguoi, TongTien, NVDatTour)
VALUES 
    ('MT1', 'KH001', '2023-06-01', 2, 2000000, 'NV001'),
    ('MT2', 'KH002', '2023-06-02', 4, 4000000, 'NV002'),
    ('MT3', 'KH003', '2023-06-03', 3, 3000000, 'NV003'),
    ('MT4', 'KH004', '2023-06-04', 5, 5000000, 'NV002'),
    ('MT5', 'KH005', '2023-06-05', 2, 2000000, 'NV001'),
    ('MT6', 'KH006', '2023-06-06', 3, 3000000, 'NV003'),
    ('MT7', 'KH007', '2023-06-07', 4, 4000000, 'NV003'),
    ('MT8', 'KH008', '2023-06-08', 2, 2000000, 'NV002'),
    ('MT9', 'KH009', '2023-06-09', 3, 3000000, 'NV001')

INSERT INTO KhachHang2 (email, MaTour, hoten, sdt) VALUES 
    ('kh1@example.com', 'MT1', N'Nguyễn Văn B', '0123456780'),
    ('kh2@example.com', 'MT2', N'Trần Thị B', '0123456781'),
    ('kh3@example.com', 'MT3', N'Lê Văn C', '0123456782'),
    ('kh4@example.com', 'MT4', N'Phạm Thị D', '0123456783'),
    ('kh5@example.com', 'MT5', N'Hoàng Văn E', '0123456784'),
    ('kh6@example.com', 'MT6', N'Vũ Thị F', '0123456785'),
    ('kh7@example.com', 'MT7', N'Đặng Văn G', '0123456786'),
    ('kh8@example.com', 'MT8', N'Nguyễn Thị H', '0123456787'),
    ('kh9@example.com', 'MT9', N'Lê Văn I', '0123456788'),
    ('kh10@example.com', 'MT4', N'Trần Thị K', '0123456789'),
    ('kh11@example.com', 'MT1', N'Nguyễn Văn L', '0123456790'),
    ('kh12@example.com', 'MT2', N'Trần Thị M', '0123456791'),
    ('kh13@example.com', 'MT3', N'Lê Văn N', '0123456792')

INSERT INTO DanhGia (MaTour, TenKhachHang, email, sdt, Rating, PhanHoi)
VALUES
('MT1', N'Nguyễn Văn B', 'kh1@example.com', '0123456780', 4, N'Tuyệt vời!'),
('MT2', N'Trần Thị B','kh2@example.com', '0123456781', 5, N'Rất tuyệt vời!'),
('MT3',  N'Lê Văn C', 'kh3@example.com', '0123456782', 4, N'Tuyệt vời!'),
('MT4', N'Phạm Thị D', 'kh4@example.com', '0123456783', 5, N'Rất tuyệt vời!')

--view--
--View "Danh sách điểm đến và tour liên quan":
CREATE VIEW ViewDiemDenTour AS
SELECT d.MaDiemDen, d.TenDiemDen, t.MaTour, t.Ten_tour
FROM DiemDen d
JOIN Tour t ON d.MaDiemDen = t.MaDiemDen;

--View "Danh sách khách hàng đã đặt tour":
CREATE VIEW ViewKhachHangDatTour AS
SELECT kh.MaKhachHang, kh.hoten, dt.MaTour, dt.NgayDat
FROM KhachHang kh
JOIN DatTour dt ON kh.MaKhachHang = dt.MaKhachHang;
select * from ViewKhachHangDatTour

--View "Danh sách tour và đánh giá":
CREATE VIEW ViewTourDanhGia AS
SELECT t.MaTour, t.Ten_tour, dg.Rating, dg.PhanHoi
FROM Tour t
LEFT JOIN DanhGia dg ON t.MaTour = dg.MaTour;

--View "Danh sách nhân viên hệ thống và thông tin đặt tour":
CREATE VIEW ViewNhanVienDatTour AS
SELECT nv.MaNV, nv.Hoten, dt.MaTour, dt.NgayDat, dt.SoNguoi
FROM NhanVienHT nv
JOIN DatTour dt ON nv.MaNV = dt.NVDatTour;

--View "Danh sách tour và số lượng đặt tour":
CREATE VIEW ViewTourSoLuongDatTour AS
SELECT t.MaTour, t.Ten_tour, COUNT(dt.id) AS SoLuongDatTour
FROM Tour t
LEFT JOIN DatTour dt ON t.MaTour = dt.MaTour
GROUP BY t.MaTour, t.Ten_tour;

--View "Danh sách khách hàng đã hoàn thành tour du lịch và đánh giá":
CREATE VIEW ViewKhachHangHoanThanhTour AS
SELECT kh2.email, kh2.MaTour, kh2.hoten, kh2.sdt, dg.Rating, dg.PhanHoi
FROM KhachHang2 kh2
LEFT JOIN DanhGia dg ON kh2.email = dg.email;

--View "Danh sách tour và tổng doanh thu":
CREATE VIEW ViewTourDoanhThu AS
SELECT t.MaTour, t.Ten_tour, SUM(dt.TongTien) AS TongDoanhThu
FROM Tour t
LEFT JOIN DatTour dt ON t.MaTour = dt.MaTour
GROUP BY t.MaTour, t.Ten_tour;

--View "Danh sách nhân viên hệ thống và số lượng đặt tour":
CREATE VIEW ViewNhanVienSoLuongDatTour AS
SELECT nv.MaNV, nv.Hoten, COUNT(dt.id) AS SoLuongDatTour
FROM NhanVienHT nv
JOIN DatTour dt ON nv.MaNV = dt.NVDatTour
GROUP BY nv.MaNV, nv.Hoten;

--View "Danh sách đánh giá theo tour":
CREATE VIEW ViewDanhGiaTheoTour AS
SELECT t.MaTour, t.Ten_tour, dg.Rating, dg.PhanHoi
FROM Tour t
JOIN DanhGia dg ON t.MaTour = dg.MaTour;


--Store Proc--
--Thủ tục lấy danh sách tour dựa trên mã điểm đến:
CREATE PROCEDURE GetToursByDestination
    @MaDiemDen VARCHAR(50)
AS
BEGIN
    SELECT *
    FROM Tour
    WHERE MaDiemDen = @MaDiemDen
END
exec GetToursByDestination @MaDiemDen = 'DD001'

--Thủ tục lấy thông tin khách hàng dựa trên mã khách hàng:
CREATE PROCEDURE GetCustomerInfo
    @MaKhachHang VARCHAR(50)
AS
BEGIN
    SELECT *
    FROM KhachHang
    WHERE MaKhachHang = @MaKhachHang
END

--Thủ tục lấy danh sách khách hàng đã hoàn thành tour dựa trên mã tour:
CREATE PROCEDURE GetCustomersCompletedTour
    @MaTour VARCHAR(50)
AS
BEGIN
    SELECT *
    FROM KhachHang2
    WHERE MaTour = @MaTour
END

--Thủ tục thêm khách hàng vào bảng KhachHang:
CREATE PROCEDURE AddCustomer
    @MaKhachHang VARCHAR(50),
    @Hoten NVARCHAR(50),
    @Email VARCHAR(50),
    @SDT VARCHAR(10)
AS
BEGIN
    INSERT INTO KhachHang (MaKhachHang, hoten, email, sdt)
    VALUES (@MaKhachHang, @Hoten, @Email, @SDT)
END

--Thủ tục cập nhật thông tin tour:
CREATE PROCEDURE UpdateTour
    @MaTour VARCHAR(50),
    @TenTour NVARCHAR(150),
    @MoTaTour NVARCHAR(150),
    @GiaTour INT,
    @Tgian INT,
    @NgayKhoiHanh DATE,
    @NgayKetThuc DATE
AS
BEGIN
    UPDATE Tour
    SET Ten_tour = @TenTour, MoTa_tour = @MoTaTour, Gia_tour = @GiaTour, Tgian = @Tgian, Ngay_kh = @NgayKhoiHanh, Ngay_kt = @NgayKetThuc
    WHERE MaTour = @MaTour
END

--Thủ tục lấy danh sách các tour được đặt bởi một khách hàng cụ thể:
CREATE PROCEDURE GetToursByCustomer
    @MaKhachHang VARCHAR(50)
AS
BEGIN
    SELECT Tour.*
    FROM Tour
    INNER JOIN DatTour ON Tour.MaTour = DatTour.MaTour
    WHERE DatTour.MaKhachHang = @MaKhachHang
END

--Thủ tục thêm một đánh giá mới cho một tour:
CREATE PROCEDURE AddReview
    @MaTour VARCHAR(50),
    @TenKhachHang NVARCHAR(50),
    @Email VARCHAR(50),
    @SDT VARCHAR(10),
    @Rating INT,
    @PhanHoi NVARCHAR(255)
AS
BEGIN
    INSERT INTO DanhGia (MaTour, TenKhachHang, email, sdt, Rating, PhanHoi)
    VALUES (@MaTour, @TenKhachHang, @Email, @SDT, @Rating, @PhanHoi)
END

--Thủ tục xóa một tour khỏi bảng Tour và tất cả các đặt tour liên quan:
CREATE PROCEDURE DeleteTour
    @MaTour VARCHAR(50)
AS
BEGIN
    DELETE FROM DatTour
    WHERE MaTour = @MaTour

    DELETE FROM Tour
    WHERE MaTour = @MaTour
END

--Thủ tục lấy danh sách các tour có đánh giá trung bình cao hơn một ngưỡng xác định:
CREATE PROCEDURE GetToursByAverageRating
    @ThresholdRating INT
AS
BEGIN
    SELECT Tour.*
    FROM Tour
    INNER JOIN (
        SELECT MaTour, AVG(Rating) AS AverageRating
        FROM DanhGia
        GROUP BY MaTour
        HAVING AVG(Rating) > @ThresholdRating
    ) AS AverageRatings ON Tour.MaTour = AverageRatings.MaTour
END


--trigger
--Trigger để tự động tạo mã tour khi thêm dữ liệu vào bảng "Tour":
CREATE TRIGGER Trg_Tour_Insert
ON Tour
FOR INSERT
AS
BEGIN
    DECLARE @MaTour VARCHAR(50)
    SET @MaTour = (SELECT 'MT' + RIGHT('00' + CAST((SELECT COUNT(*) + 1 FROM Tour) AS VARCHAR(2)), 2))

    UPDATE Tour
    SET MaTour = @MaTour
    WHERE MaTour IS NULL
END

--Trigger để tự động tính tổng tiền khi thêm dữ liệu vào bảng "DatTour":
CREATE TRIGGER Trg_DatTour_Insert
ON DatTour
FOR INSERT
AS
BEGIN
    UPDATE DatTour
    SET TongTien = SoNguoi * (SELECT Gia_tour FROM Tour WHERE MaTour = (SELECT MaTour FROM INSERTED))
    WHERE id IN (SELECT id FROM INSERTED)
END

--Trigger để tự động tạo mã khách hàng khi thêm dữ liệu vào bảng "KhachHang":
CREATE TRIGGER Trg_KhachHang_Insert
ON KhachHang
FOR INSERT
AS
BEGIN
    DECLARE @MaKhachHang VARCHAR(50)
    SET @MaKhachHang = (SELECT 'KH' + RIGHT('000' + CAST((SELECT COUNT(*) + 1 FROM KhachHang) AS VARCHAR(3)), 3))

    UPDATE KhachHang
    SET MaKhachHang = @MaKhachHang
    WHERE MaKhachHang IS NULL
END


--Thống kê
--Số lượng tour đang có:
SELECT COUNT(*) AS SoLuongTour FROM Tour;

--Số lượng khách hàng đã đặt tour:
SELECT COUNT(*) AS SoLuongKhachHangDatTour FROM DatTour;

--Tổng doanh thu từ tour:
SELECT SUM(TongTien) AS TongDoanhThu FROM DatTour;

--Số lượng đánh giá đã được thêm:
SELECT COUNT(*) AS SoLuongDanhGia FROM DanhGia;

--Tổng số lượng khách hàng đã hoàn thành tour du lịch:
SELECT COUNT(*) AS SoLuongKhachHangHoanThanh FROM KhachHang2;

--Số lượng tour trong mỗi điểm đến:
SELECT d.TenDiemDen, COUNT(*) AS SoLuongTour
FROM Tour t
JOIN DiemDen d ON t.MaDiemDen = d.MaDiemDen
GROUP BY d.TenDiemDen;

--Các tour có số lượng đặt cao nhất:
SELECT t.Ten_tour, COUNT(*) AS SoLuongDat
FROM Tour t
JOIN DatTour dt ON t.MaTour = dt.MaTour
GROUP BY t.Ten_tour
ORDER BY COUNT(*) DESC;


--Nối bảng
--Nối hai bảng DiemDen và Tour dựa trên trường MaDiemDen:
SELECT *
FROM DiemDen
INNER JOIN Tour ON DiemDen.MaDiemDen = Tour.MaDiemDen;

--Nối hai bảng DiemDen và Tour dựa trên trường MaDiemDen và lọc theo một điều kiện:
SELECT *
FROM DiemDen
INNER JOIN Tour ON DiemDen.MaDiemDen = Tour.MaDiemDen
WHERE Tour.Gia_tour <= 2000000;

create procedure HoLe
		as
		begin
		select MaKhachHang, hoten
		from KhachHang
		where hoten Like N'Lê%';
		end
		exec HoLe

		create procedure TangGiaT2
	as
	begin
	update Tour set Gia_tour = Gia_tour / 2
	select * from Tour
	end
	exec TangGiaT1

	select * from Tour









	--Trang--
	--- View---
	--1--- hiển thị danh sách sách khách hàng đặt tour
	create view TTtour
	as 
	select hoten, Ten_tour, TenDiemDen
	from Tour, DiemDen, KhachHang2
	where Tour.MaTour = KhachHang2.MaTour and Tour.MaDiemDen = DiemDen.MaDiemDen
	select * From TTtour

	--2-- số tour có chi phí đặt tour là 3.000.000
	Create view ChiPhi
	as select count(*) as N'Số lượng tour'
	From dbo.DatTour
	where TongTien=3000000
	select * from ChiPhi

	--3--hiển thị danh sách mã khách hàng có tour điểm đến là huế
	create view DSHue
	as 
	select hoten, TenDiemDen
	from Tour, DiemDen, KhachHang2
	where Tour.MaTour = KhachHang2.MaTour and Tour.MaDiemDen = DiemDen.MaDiemDen and TenDiemDen = N'Huế'
	select * from DSHue

	--- trigger---
	--1-- kiểm tra việc nhập giá tour, sao cho giá tour bé hơn 0 thì đưa ra thông báo
	create trigger CheckGia1 on Tour
	After insert
	as
	begin
		declare @count_GiaTour int
		Select @count_GiaTour = (select Gia_tour from inserted )
		from Tour
		if(@count_GiaTour <= 0 )
		begin
		raiserror ('Giá tour phải lớn hơn 0',16,1)
		end
	end
	go

	Select * from Tour
	insert into Tour Values ('1234', 'DD001','hhdh', 'hdhf', 0, 4, '2023-06-01' , '2023-06-10')

	--2-- cập nhật doanh thu
	Create trigger DoanhThu
	on DatTour
	after insert
	as
	begin
		update DatTour
		set TongTien= (select Sum(TongTien) From DatTour where MaTour= inserted.MaTour)
		From DatTour
		Join inserted on DatTour.MaTour=inserted.MaTour
		end
		
		-- 3-- kiển tra tính hợp lệ khi xóa 1 tour
		create trigger XoaTour
		on DatTour
		for delete
		as if not exists (select * from deleted)
		begin
		print 'Không tồn tại hóa đơn này'
		rollback transaction
		end


		--STORE--
		--1-- in ra danh sách khách hàng có họ lê
		create procedure HoLe
		as
		begin
		select MaKhachHang, hoten
		from KhachHang
		where hoten Like N'Lê%';
		end
		exec HoLe

	--2-- danh sách khách hàng đánh giá là rất tuyệt vơi
	create procedure DG
	as
	begin
	select hoten, rating
	from KhachHang2, DanhGia
	where KhachHang2.email = DanhGia.email and Rating like N'Rất tuyệt vời!'
	end
	exec DG

	--3-- tour tăng giá 
	create procedure TangGiaT
	as
	update Tour set Gia_tour = Gia_tour * 2
	exec TangGiaT

	select * from Tour

	---select--
	--1--in ra top 3 giá tour cao nhất
	select MaTour, Ten_tour, Gia_tour
	from Tour
	where Gia_tour in (select distinct top 3 Gia_tour
						from Tour
						order by Gia_tour Desc)

	--2--in danh sách tour có tổng tiền trên 2000000
	select hoten, MaTour, TongTien
	from KhachHang, DatTour
	where KhachHang.MaKhachHang=DatTour.MaKhachHang and TongTien > 2000000
	order by TongTien ASC

	--3-- hiển thị danh sách tour có điểm đến là Đà nẵng
	select MaTour, TenDiemDen
	from Tour
	inner join DiemDen on Tour.MaDiemDen = DiemDen.MaDiemDen
	where TenDiemDen like N'Đà Nẵng'




	--Thơm--
	--view--
--1-- hiển thị danh sách sách đánh giá tour
CREATE VIEW DSDGT
AS 
	 SELECT Ten_tour, hoten, PhanHoi
  FROM Tour, KhachHang2, DanhGia
  WHERE Tour.MaTour = KhachHang2.MaTour and KhachHang2.MaTour=DanhGia.MaTour
  select * from DSDGT

--2-- hiển thị danh sách 3 tuor khách hàng đặt nhiều nhất

   CREATE VIEW DSTN AS
   SELECT TOP 3 Tour.MaDiemDen, Tour.Ten_tour, COUNT(DatTour.MaKhachHang) AS So_luong_dat
   FROM tour
   INNER JOIN DatTour ON Tour.MaTour = DatTour.MaTour
   GROUP BY Tour.MaDiemDen, Tour.Ten_tour
   ORDER BY COUNT(DatTour.MaTour) DESC;
   select * from DSTN

select * from DSTN

--3--hiển thị danh sách mã điểm đến được khách hàng đánh giá Tuyệt vời!
	Create VIEW DGT
	AS
    SELECT Ten_tour, TenKhachHang, PhanHoi
    FROM Tour, DanhGia
	WHERE Tour.MaTour = DanhGia.MaTour and PhanHoi = N'Tuyệt vời!';
	select * from DGT
select * from DGT

--stored procedure--
--1.Tạo stored procedure để thêm một điểm đến mới- Quy Nhơn--
CREATE PROCEDURE ThemDiemDen
    @MaDiemDen varchar(50),
    @TenDiemDen nvarchar(50),
    @MoTa nvarchar(150)
AS
BEGIN
    INSERT INTO DiemDen(MaDiemDen, TenDiemDen, MoTa) VALUES (@MaDiemDen, @TenDiemDen, @MoTa);
END;
SELECT * FROM DiemDen
EXEC ThemDiemDen 'DD010', N'Quy Nhơn', N'Quy Nhơn nép mình giữa một bên biển một bên núi với những bờ biển dài uốn cong thơ mộng.';
--2.hiển thị danh sách tổng tiền là trên 3000000--
CREATE PROCEDURE sp_HienThiTongTien
AS
BEGIN
    SELECT MaTour, MaKhachHang, NgayDat, SoNguoi, TongTien
    FROM DatTour
    WHERE TongTien > 3000000;
END;
EXECUTE sp_HienThiTongTien;

--3.Chỉnh sửa thông tin đặt tour của  khách--
CREATE PROCEDURE sp_ChinhSuaDatTour
    @MaKhachHang varchar(50),
    @SoNguoi int
AS
BEGIN
    UPDATE DatTour
    SET SoNguoi = @SoNguoi
    WHERE MaKhachHang =  @MaKhachHang;
END;
EXECUTE sp_ChinhSuaDatTour
    @MaKhachHang = 'KH001',
    @SoNguoi = 6;
SELECT * FROM DatTour

--Trigger --
--1.Cập nhật ngày tạo khi thêm mới một tour vào bảng Tour--
CREATE TRIGGER tr_AutoCapNhatTour
ON Tour
AFTER INSERT
AS
BEGIN
    UPDATE Tour
    SET Tgian = CONVERT(int, GETDATE())
    WHERE MaTour IN (SELECT MaTour FROM inserted);
END;	

--2.Tự động cập nhật tổng số khách thay đổi số lượng khách--
CREATE TRIGGER tr_CapNhatTongSoLuongKhach
ON Tour
AFTER INSERT
AS
BEGIN
    UPDATE DatTour
    SET SoNguoi = (SELECT SUM(SoNguoi) FROM DatTour WHERE MaTour = inserted.MaTour)
    FROM Tour
    INNER JOIN inserted ON Tour.MaTour = inserted.MaTour;
END;
--3.Cập nhật thông tin tour khi có sự thay đổi trong bảng Điểm đến.--
CREATE TRIGGER tr_UpdateTour
ON DiemDen
AFTER UPDATE
AS
BEGIN
    UPDATE Tour
    SET MoTa_tour = (SELECT MoTa FROM inserted WHERE inserted.MaDiemDen = Tour.MaDiemDen)
    FROM Tour
    INNER JOIN inserted ON Tour.MaDiemDen = inserted.MaDiemDen;
END;

--select--
--1. Hiển thị thông tin chi tiết về một tour du lịch cụ thể đã được đặt--
SELECT * FROM Tour 
WHERE MaTour = 'MT1';

--2.Liệt kê danh sách tour du lịch đã được đặt theo thời gian từ gần đến xa:--
SELECT * FROM DatTour
ORDER BY NgayDat DESC;

--3. Hiển thị thông tin khách hàng và tour tương ứng đã đặt --
SELECT KhachHang.*, Tour.*
FROM KhachHang
INNER JOIN DatTour ON KhachHang.MaKhachHang = DatTour.MaKhachHang
INNER JOIN Tour ON DatTour.MaTour = Tour.MaTour;





--cường---
-- Tạo View
--1.Tạo View danh sách tất cả khách hàng
	CREATE VIEW view_KhachHang
	AS
	SELECT * 
	FROM KhachHang;

	SELECT * FROM view_KhachHang
--2.Tạo View CÓ BAO NHIÊU TOUR có giá 1000000

	CREATE VIEW view_Gia_tour1M
	AS
	SELECT COUNT(*) AS N'Số Lượng Tour'
	FROM dbo.Tour
	WHERE Gia_tour = 10000000;
	select * from view_Gia_tour1M
--3. Tạo View hiển thị danh sách các Tour và giá::
	
	CREATE VIEW view_Tour
	AS
	SELECT MaTour, Ten_tour, Gia_tour
	FROM Tour;
	select * from view_Tour
--Store
--1. In ra danh sách khách hàng  ( makh, tenkh) có họ nguyễn 
CREATE PROCEDURE GetCustomersByLastName
AS
BEGIN  
SELECT MaKhachHang, hoten  
FROM KhachHang 
WHERE hoten LIKE N'Nguyễn%';
END
EXEC GetCustomersByLastName;
--2.SỬA ĐỔI THÔNG TIN TOUR TĂNG GIÁ TOUR LÊN GẤP 2 LẦN 
create proc Gia_tour
as
update Tour set Gia_tour = Gia_tour *2
EXEC Gia_tour;
--3 TÌM KIẾM NHÂN VIÊN CÓ HỌ NGUYỄN
CREATE PROCEDURE SP_TIMKIEMNV
    @Hoten NVARCHAR(100) = NULL
AS
BEGIN
    SELECT *
FROM NhanVienHT
    WHERE (@Hoten IS NULL OR Hoten LIKE '%' + @Hoten + '%')
END
EXEC SP_TIMKIEMNV @HOTEN = N'NGUYỄN '
--Trigger
--1.Tạo trigger để kiểm tra ràng buộc: Tuổi của nhân viên mới không quá 45 tuổi sau khi thêm mới nhân viên?
CREATE TRIGGER trig_CheckEmployeeAge
ON NhanVienHT
AFTER INSERT
AS
BEGIN
    IF (
SELECT MAX(DATEDIFF(YEAR, ngaysinh, GETDATE())) FROM INSERTED) > 45
    BEGIN
        ROLLBACK;
        RAISERROR ('Tuổi của nhân viên không được vượt quá 45 tuổi.', 16, 1);
    END
END;
--2.Tạo hàm kiểm tra tính hợp lệ khi xóa đánh giá
create trigger XOADG
 on DanhGia
 for delete
 as
 if not exists ( select * from   deleted  )
 begin
 print ' khong ton tai danh gia nay'
 rollback transaction
 end 
 --3. Tạo trigger để kiểm tra ràng buộc: số nhân viên nam phải nhỏ hơn số nhân viên nữ sau khi thêm hoặc sửa đổi giới tính của nhân viên?(đ)
CREATE TRIGGER tr_KiemTraSoNhanVienNamNhoHonNu
ON NhanVienHT 
AFTER INSERT, UPDATE
AS
BEGIN
  DECLARE @SoNhanVienNam INT, @SoNhanVienNu INT

  SELECT 
    @SoNhanVienNam = COUNT(CASE WHEN gt = 'Nam' THEN 1 END),
    @SoNhanVienNu = COUNT(CASE WHEN gt = 'Nữ' THEN 1 END)
  FROM NhanVienHT

  IF (@SoNhanVienNam >= @SoNhanVienNu)
  BEGIN
    RAISERROR('Số nhân viên nam phải nhỏ hơn số nhân viên nữ', 16, 1)
    ROLLBACK TRANSACTION
    RETURN
  END
END
-- select
--1.Tìm khách hàng có tên, mã khách hàng có giới tính là nữ 
SELECT hoten, MaKhachHang,gt
FROM KhachHang
WHERE  gt = N'nu';
--2.Tìm khách hàng có tên, mã khách hàng có giới tính là nam 
SELECT hoten, MaKhachHang,gt
FROM KhachHang
WHERE  gt = N'nam';
-- 3.In ra các mã Tour, tên Tour có tổng tiền = 100000
SELECT *
FROM Tour
WHERE Gia_tour= 1000000
ORDER BY  Gia_tour ASC