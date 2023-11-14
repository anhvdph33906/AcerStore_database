CREATE DATABASE AcerStores;
GO
USE AcerStores;
GO

--1. San pham chi tiet
CREATE TABLE SanPhamChiTiet (
	SanPhamChiTietId INT IDENTITY (1, 1) PRIMARY KEY
   ,ThongSoId INT
   ,SanPhamId int
   ,LoaiSP VARCHAR(50) NOT NULL
   ,SoLuong INT NOT NULL
   ,Gia MONEY NOT NULL
   ,TrangThai BIT
   ,MoTa VARCHAR(1000)
);
GO

--2. San pham
CREATE TABLE SanPham (
	SanPhamId INT IDENTITY (1, 1) PRIMARY KEY
   ,MaSP varchar(20) not null
   ,Ten VARCHAR(50) NOT NULL
   ,XuatXu INT not null
   ,NgayRaMat date
   ,HinhAnh image not null
   ,MoTa VARCHAR(1000)
   ,TrangThai BIT NOT NULL
);
GO

--3. Thong so
CREATE TABLE ThongSo (
	ThongSoId INT IDENTITY PRIMARY KEY
   ,ManHinh VARCHAR(50) NOT NULL
   ,Ram VARCHAR(10) NOT NULL
   ,KichThuoc VARCHAR(30) NOT NULL
   ,CPU VARCHAR(20) NOT NULL
   ,HeDieuHanh VARCHAR(30) NOT NULL
   ,TrongLuong VARCHAR(10) NOT NULL
);
GO

--4. Xuat xu
CREATE TABLE XuatXu (
	XuatXuId INT IDENTITY (1, 1) PRIMARY KEY
   ,NoiSanXuat VARCHAR(10) NOT NULL
   ,NgayRaMat DATE NOT NULL
);
GO

--5 Danh muc
CREATE TABLE DanhMuc (
	MaDM int identity primary key not null
   ,TenDM VARCHAR(20) NOT NULL
   ,SanPhamId int not null
);
GO

--6. Nhan vien
CREATE TABLE NhanVien (
	MaNV VARCHAR(10) PRIMARY KEY NOT NULL
   ,Ten VARCHAR(20) NOT NULL
   ,SoDT INT NOT NULL
   ,MatKhau VARCHAR(10) NOT NULL
   ,VaiTro BIT NOT NULL
);
GO

--7. IMEI
CREATE TABLE IMEI (
	ImeiId INT IDENTITY (1, 1) PRIMARY KEY
   ,SanPhamChiTietId INT
   ,HoaDonId INT
   ,Ma VARCHAR(20) NOT NULL
);
GO

--8. Hoa don chi tiet
CREATE TABLE HoaDonChiTiet (
	MaHDCT VARCHAR(20) PRIMARY KEY
	,HoaDonId INT
   ,BaoHanhId INT
   ,MaKH VARCHAR(10)
   ,MaNV VARCHAR(10)
   ,ThoiGianTao DATE NOT NULL
   ,ThoiGianThanhToan DATE NOT NULL
   ,Gia MONEY NOT NULL
   ,Voucher FLOAT
   ,ThanhTien MONEY NOT NULL
   ,TienKhachTra MONEY NOT NULL
   ,GhiChu NVARCHAR(1000)
);
GO

--9. Hoa don
CREATE TABLE HoaDon (
	HoaDonId INT IDENTITY PRIMARY KEY
   ,MaHD VARCHAR(20) not null
   ,GhiChu NVARCHAR(1000)
   ,TongTien MONEY NOT NULL
   ,ThanhToan VARCHAR(20) NOT NULL
   ,TrangThai BIT NOT NULL
);
GO

--10. Lich su hoa don
CREATE TABLE LichSuHoaDon (
	LichSuHoaDonId INT IDENTITY PRIMARY KEY
   ,HoaDonId INT
   ,TrangThai BIT NOT NULL
);
GO

--11. Bao hanh
CREATE TABLE BaoHanh (
	BaoHanhId INT IDENTITY PRIMARY KEY
   ,ThoiGianBD DATE NOT NULL
   ,ThoiGianKT DATE NOT NULL
   ,DieuKien NVARCHAR(100) NOT NULL
   ,PhiPhatSinh MONEY
   ,TrangThai BIT
);
GO

--12. Khach hang
Create TABLE KhachHang (
	MaKH VARCHAR(10) PRIMARY KEY
   ,Ten NVARCHAR(30) NOT NULL
   ,GioiTinh bit not null
   ,SoDT INT NOT NULL
   ,DiaChi NVARCHAR(50)
   ,TrangThai bit not null,
);
GO

--13. Lich su khach hang da mua
CREATE TABLE LichSuKhachHang (
	LichSuKhachHangId INT IDENTITY PRIMARY KEY
   ,MaHDCT VARCHAR(20)
   ,Ngaymua DATE NOT NULL
   ,SoLuong INT NOT NULL
   ,TrangThai BIT
);
GO

--14: Doi tra 
CREATE TABLE DoiTra (
	DoiTraId INT IDENTITY PRIMARY KEY
   ,MaHDCT VARCHAR(20)
   ,NgayBD DATE NOT NULL
   ,NgayKT DATE NOT NULL
   ,Lydo NVARCHAR(1000) NOT NULL
);

-- 15: Khuyen mai
CREATE TABLE Khuyenmai (
	MaKM VARCHAR(10) PRIMARY KEY
   ,SanPhamId INT
   ,TenKM NVARCHAR(100) NOT NULL
   ,TGBD DATE NOT NULL
   ,TGKT DATE NOT NULL
   ,TriGia FLOAT NOT NULL
   ,KieuKM VARCHAR(10) NOT NULL
   ,TrangThai VARCHAR NOT NULL
);
GO

--16: Giao ca
CREATE TABLE GiaoCa (
	MaGC VARCHAR(10) PRIMARY KEY
   ,MaNV VARCHAR(10)
   ,ThoiGianBD DATE NOT NULL
   ,ThoiGianKT DATE NOT NULL
   ,TienBD MONEY NOT NULL
   ,TienCk MONEY NOT NULL
   ,TienMat MONEY NOT NULL
   ,TongTien MONEY NOT NULL
   ,TienQLThu MONEY NOT NULL
   ,ChiPhiPhatSinh MONEY NOT NULL
   ,GhiChu NVARCHAR(1000)
);
GO

--17: Thong ke
CREATE TABLE ThongKe (
	SanPhamId INT NOT NULL
   ,HoaDonId INT NOT NULL
   ,thoigian DATE
);
GO

ALTER TABLE SanPhamChiTiet ADD FOREIGN KEY (ThongSoId) REFERENCES ThongSo (ThongSoId),
FOREIGN KEY (SanPhamId) REFERENCES SanPham (SanPhamId);
GO

ALTER TABLE SanPham ADD FOREIGN KEY (SanPhamChiTietId) REFERENCES SanPhamChiTiet (SanPhamChiTietId)
GO

ALTER TABLE SanPham ADD FOREIGN KEY (MaDM) REFERENCES DanhMuc (MaDM)
GO
ALTER TABLE DanhMuc ADD FOREIGN KEY (SanPhamId) REFERENCES SanPham (SanPhamId);
GO

ALTER TABLE IMEI ADD FOREIGN KEY (SanPhamChiTietId) REFERENCES SanPhamChiTiet (SanPhamChiTietId),
FOREIGN KEY (HoaDonId) REFERENCES HoaDon(HoaDonId);
GO

ALTER TABLE HoaDonChiTiet ADD FOREIGN KEY (BaoHanhId) REFERENCES BaoHanh (BaoHanhId)
, FOREIGN KEY (MaKH) REFERENCES KhachHang (MaKH)
, FOREIGN KEY (MaNV) REFERENCES NhanVien (MaNV);
GO

ALTER TABLE HoaDonChiTiet ADD FOREIGN KEY (HoaDonId) REFERENCES HoaDon (HoaDonId);
GO

ALTER TABLE LichSuHoaDon ADD FOREIGN KEY (HoaDonId) REFERENCES HoaDon (HoaDonId);
GO

ALTER TABLE LichSuKhachHang ADD FOREIGN KEY (MaHDCT) REFERENCES HoaDonChiTiet (MaHDCT);
GO

ALTER TABLE DoiTra ADD FOREIGN KEY (MaHDCT) REFERENCES HoaDonChiTiet (MaHDCT);
GO

ALTER TABLE Khuyenmai ADD FOREIGN KEY (SanPhamId) REFERENCES SanPham (SanPhamId);
GO

ALTER TABLE GiaoCa ADD FOREIGN KEY (MaNV) REFERENCES NhanVien (MaNV);
GO

ALTER TABLE ThongKe ADD CONSTRAINT Pk_SanPham_HoaDon PRIMARY KEY (SanPhamId, HoaDonId)
, FOREIGN KEY (SanPhamId) REFERENCES SanPham (SanPhamId)
, FOREIGN KEY (HoaDonId) REFERENCES HoaDon (HoaDonId);

CREATE TABLE SanPham 
Add MaSP varchar(20) not null;