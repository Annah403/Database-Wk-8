-- ==========================================
-- Database: Library Management System
-- Description: Manages books, authors, members, copies, and loans
-- ==========================================

-- Create Database
CREATE DATABASE library;
USE library;

-- ==========================================
-- Books Table
-- Stores all books in the library with their title and publication year
-- ==========================================
CREATE TABLE books (
  book_id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  publication_year INT NOT NULL
);

-- Insert sample books
INSERT INTO books (title, publication_year) VALUES
('The Great Gatsby', 1925),
('To Kill a Mockingbird', 1960),
('1984', 1949),
('Pride and Prejudice', 1813),
('The Catcher in the Rye', 1951),
('The Hobbit', 1937),
('Harry Potter and the Sorcerer\'s Stone', 1997),
('The Lord of the Rings', 1954),
('Moby Dick', 1851),
('War and Peace', 1869);


--  Authors Table
-- Stores author details

CREATE TABLE authors (
  author_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);

-- Junction Table: Resolves many-to-many between Books and Authors
CREATE TABLE book_authors (
  book_id INT NOT NULL,
  author_id INT NOT NULL,
  PRIMARY KEY (book_id, author_id),
  FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE,
  FOREIGN KEY (author_id) REFERENCES authors(author_id) ON DELETE CASCADE
);

-- Insert sample authors
INSERT INTO authors (name) VALUES
('F. Scott Fitzgerald'),
('Harper Lee'),
('George Orwell'),
('Jane Austen'),
('J.D. Salinger'),
('J.R.R. Tolkien'),
('J.K. Rowling'),
('Leo Tolstoy'),
('Herman Melville');

-- Link books to authors
INSERT INTO book_authors (book_id, author_id) VALUES
(1, 1), -- The Great Gatsby → F. Scott Fitzgerald
(2, 2), -- To Kill a Mockingbird → Harper Lee
(3, 3), -- 1984 → George Orwell
(4, 4), -- Pride and Prejudice → Jane Austen
(5, 5), -- The Catcher in the Rye → J.D. Salinger
(6, 6), -- The Hobbit → J.R.R. Tolkien
(7, 7), -- Harry Potter → J.K. Rowling
(8, 6), -- The Lord of the Rings → J.R.R. Tolkien
(9, 9), -- Moby Dick → Herman Melville
(10, 8); -- War and Peace → Leo Tolstoy


-- Members Table
-- Stores information about library members

CREATE TABLE members (
  member_id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  email VARCHAR(150) UNIQUE NOT NULL,
  phone VARCHAR(20),
  join_date DATE NOT NULL
);

-- Insert sample members
INSERT INTO members (first_name, last_name, email, phone, join_date) VALUES
('Alice', 'Johnson', 'alice.johnson@example.com', '0712345678', '2024-01-10'),
('Bob', 'Smith', 'bob.smith@example.com', '0723456789', '2024-02-15'),
('Carol', 'Williams', 'carol.williams@example.com', '0734567890', '2024-03-20'),
('David', 'Brown', 'david.brown@example.com', '0745678901', '2024-04-05'),
('Eva', 'Miller', 'eva.miller@example.com', '0756789012', '2024-05-12');


--  Book Copies Table
-- Tracks the physical copies of each book
-- Includes status (Available, Borrowed, Reserved)

CREATE TABLE book_copies (
  copy_id INT AUTO_INCREMENT PRIMARY KEY,
  book_id INT NOT NULL,
  status ENUM('Available', 'Borrowed', 'Reserved') DEFAULT 'Available',
  FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE
);

-- Insert sample copies
INSERT INTO book_copies (book_id, status) VALUES
(1, 'Available'), (1, 'Available'), -- 2 copies of The Great Gatsby
(2, 'Available'),                   -- 1 copy of To Kill a Mockingbird
(3, 'Available'), (3, 'Borrowed'),  -- 2 copies of 1984
(4, 'Available'),                   -- 1 copy of Pride and Prejudice
(5, 'Available'),                   -- 1 copy of The Catcher in the Rye
(6, 'Available'), (6, 'Available'), -- 2 copies of The Hobbit
(7, 'Available'),                   -- 1 copy of Harry Potter
(8, 'Available'), (8, 'Reserved'),  -- 2 copies of LOTR
(9, 'Available'),                   -- 1 copy of Moby Dick
(10, 'Available');                  -- 1 copy of War and Peace


-- 6. Loans Table
-- Records which member borrows which book copy
-- Includes loan date, due date, and optional return date

CREATE TABLE loans (
  loan_id INT AUTO_INCREMENT PRIMARY KEY,
  copy_id INT NOT NULL,
  member_id INT NOT NULL,
  loan_date DATE NOT NULL,
  due_date DATE NOT NULL,
  return_date DATE,
  FOREIGN KEY (copy_id) REFERENCES book_copies(copy_id) ON DELETE CASCADE,
  FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE
);

-- Insert sample loan records
INSERT INTO loans (copy_id, member_id, loan_date, due_date, return_date) VALUES
(5, 1, '2024-06-01', '2024-06-15', '2024-06-10'), -- Alice borrowed & returned 1984
(12, 2, '2024-06-05', '2024-06-20', NULL),        -- Bob borrowed LOTR, not returned yet
(7, 3, '2024-06-07', '2024-06-21', NULL),         -- Carol borrowed Catcher in the Rye
(2, 4, '2024-06-10', '2024-06-24', '2024-06-18'), -- David borrowed & returned Gatsby
(8, 5, '2024-06-12', '2024-06-26', NULL);         -- Eva borrowed The Hobbit


--  Test Queries

-- View all books
SELECT * FROM books;

-- View all authors
SELECT * FROM authors;

-- View all members
SELECT * FROM members;

-- View all book copies
SELECT * FROM book_copies;

-- View all loans
SELECT * FROM loans;

-- Join example: Books with their Authors
SELECT b.title AS Book_Title, a.name AS Author_Name
FROM books b
JOIN book_authors ba ON b.book_id = ba.book_id
JOIN authors a ON ba.author_id = a.author_id
ORDER BY b.title;
