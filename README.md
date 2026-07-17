# ShopKart — Full-Stack E-Commerce Web Application

ShopKart is a complete e-commerce web application built using **Java Servlets, JSP, JDBC, and MySQL**, following the traditional Java EE web development stack with Apache Tomcat as the server. This project was developed as a college submission and portfolio piece to demonstrate end-to-end web development skills — from database design to backend logic to a fully responsive frontend.

## Features

**User Side**
- Secure user authentication with BCrypt password hashing and email verification
- Session-based login system with "Forgot Password" recovery
- Product browsing with category filters, search, and price sorting
- Individual product detail pages with descriptions and images
- Shopping cart with add, update quantity, and remove functionality
- Wishlist to save products for later
- Mock payment flow with an animated order confirmation screen
- Order history with real-time status tracking (Placed → Shipped → Delivered) and order cancellation
- Automatic stock validation and inventory updates on purchase

**Admin Side**
- Role-based access control separating admin and customer views
- Full product management (Add, Edit, Delete) with live inventory
- Order management with status updates
- Admin dashboard showing total users, products, orders, and sales

Design
- Custom Bootstrap-based UI with a consistent design system (CSS variables for theming)
- Fully functional Dark Mode toggle with persistent preference (localStorage)
- Responsive product grid and clean, modern styling throughout

## Tech Stack
- Backend: Java, Servlets, JSP, JDBC
-Database:MySQL
- Server: Apache Tomcat 9
- Build Tool: Maven
-Frontend: HTML, CSS (custom design system), JavaScript
- Security: BCrypt password hashing, PreparedStatements (SQL injection prevention), session-based authentication
- Email: JavaMail API for signup verification

## Project Structure
Standard Maven web application layout — `src/main/java` for Servlets, `src/main/webapp` for JSP pages and static assets, with a centralized `DBUtil` class handling database connections via an external properties file (excluded from version control for security).

## Note
Database credentials are managed through a local `db.properties` file (gitignored) and are not included in this repository. To run this project locally, create your own `src/main/resources/db.properties` file with your MySQL credentials.

---

<img width="1228" height="599" alt="{65F76ACD-BDAA-4D6D-8515-4BDDC650014E}" src="https://github.com/user-attachments/assets/81f86def-074b-4c12-b9a5-20d50c1ce023" />
<img width="1351" height="572" alt="{351F650D-4B88-4467-A500-72183198E982}" src="https://github.com/user-attachments/assets/326fdc41-8263-4fa6-9bcc-ca664b2c7b7e" />
<img width="1239" height="558" alt="{EA2489A8-F7F1-48D4-A622-F29EA703C099}" src="https://github.com/user-attachments/assets/8c0ab1c8-47cb-4cea-962d-af3b39a7f38c" />
<img width="1164" height="577" alt="{9395EBCD-C198-4C73-8685-B082FC1F3378}" src="https://github.com/user-attachments/assets/18f07b6e-e952-4994-90b3-0e60201095c7" />




