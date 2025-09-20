# 📚 Library Management System (MySQL)

## 📖 Project Overview
This project is a **Library Management System** built using **MySQL**.  
It provides a structured way of storing and managing information about books, authors, members, and book loans in a relational database.  

The goal is to demonstrate knowledge of:
- Designing a **relational database schema**
- Using **constraints** (PRIMARY KEY, FOREIGN KEY, NOT NULL, UNIQUE)
- Implementing **relationships** (One-to-Many and Many-to-Many)
- Writing SQL scripts to create and manage the system

---

## 🏗 Database Schema
The system includes the following main tables:

1. **Books** – Stores book details (title, publication year, etc.)
2. **Authors** – Stores information about authors
3. **Book_Authors** – A link table to handle the Many-to-Many relationship between books and authors
4. **Members** – Stores library members’ details
5. **Loans** – Keeps track of book borrowing and return dates

### Relationships
- A book can have **one or many authors** (Many-to-Many via `book_authors`)
- A member can borrow **many books**, but each loan is linked to one book (One-to-Many)
- Books and loans are connected with a **foreign key relationship**




