-- =============================================
-- LOSTIFY DATABASE
-- Query untuk membuat database dan tabel
-- =============================================

-- Membuat database
CREATE DATABASE IF NOT EXISTS lostify;
USE lostify;

-- =============================================
-- TABEL: users
-- Untuk menyimpan data pengguna
-- =============================================
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =============================================
-- TABEL: reports
-- Untuk menyimpan laporan barang hilang/ditemukan
-- =============================================
CREATE TABLE IF NOT EXISTS reports (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    category VARCHAR(100),
    location VARCHAR(255),
    photo VARCHAR(255),
    status ENUM('Hilang', 'Ditemukan') DEFAULT 'Hilang',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =============================================
-- TABEL: notifications
-- Untuk menyimpan notifikasi pengguna
-- =============================================
CREATE TABLE IF NOT EXISTS notifications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    message TEXT,
    is_read TINYINT(1) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =============================================
-- INDEX untuk optimasi query
-- =============================================
CREATE INDEX idx_reports_user_id ON reports(user_id);
CREATE INDEX idx_reports_status ON reports(status);
CREATE INDEX idx_reports_created_at ON reports(created_at);
CREATE INDEX idx_notifications_user_id ON notifications(user_id);
CREATE INDEX idx_notifications_created_at ON notifications(created_at);

-- =============================================
-- DATA SAMPLE (Opsional)
-- =============================================
-- Contoh user
INSERT INTO users (name, email, password) VALUES 
('Admin', 'admin@lostify.com', MD5('admin123')),
('Test User', 'user@test.com', MD5('password'));

-- Contoh report
INSERT INTO reports (user_id, title, description, category, location, status) VALUES
(1, 'Dompet Hitam', 'Dompet kulit warna hitam berisi KTP', 'Dompet', 'Kantin Kampus', 'Hilang'),
(2, 'Kunci Motor', 'Kunci motor Honda dengan gantungan biru', 'Kunci', 'Parkiran Gedung A', 'Hilang');

-- Contoh notification
INSERT INTO notifications (user_id, title, message) VALUES
(1, 'Selamat Datang', 'Selamat datang di Lostify! Semoga barang Anda segera ditemukan.'),
(2, 'Laporan Baru', 'Ada laporan barang hilang baru di sekitar Anda.');
