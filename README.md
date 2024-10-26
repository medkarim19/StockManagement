# Stock Management Web Application

## Project Objective
The aim of this project is to develop a web application for stock management dedicated to the Eagle Vizion team, a Canadian company, to gain better control over their inventory and manage resources for each project. To avoid synchronization issues among different stakeholders, it was decided to use a stock management tool that allows visualization of existing products and their allocation to ongoing projects.

## Project Overview
The web application to be developed will include the following features:

### Authentication
- **Secure Access**: The application is not open to all users. An authentication system with login and password entry is required. In case of incorrect input, an error message will appear.

### User Management
- **Admin Capabilities**: The administrator can create, modify, and delete user accounts. They can also list the various users of the application.

### Project Management
- **Project Creation**: The administrator can create a project, identified by its number and name.

### Product Management
- **Product Database**: Products are managed solely for the Eagle Vizion team (one database). Users can create, modify, and delete products (with different authorization levels) and search for products by their characteristics (e.g., reference, project name, category). A product can be assigned to a project.
- **Product Tracking**: The history/tracking of any changes/reassignments of a product from one project to another must be recorded and viewable.

### Order Management
- **Order Creation**: When creating a new project, an order line indicating the project number, project name, supplier name, product reference, and desired product quantity must be added. Order lists should be displayed with the order status (ordered, delivered).

## Features
- **User Authentication**: Secure login system for authorized users only.
- **User Management**: Administrators can manage user accounts.
- **Project Management**: Administrators can create and manage projects.
- **Product Management**: Comprehensive product management including creation, modification, deletion, and search functionality.
- **Order Management**: Manage orders related to projects, track order statuses, and ensure proper allocation of resources.



