<%-- 
    Document   : header
    Created on : Dec 1, 2025
    Author     : Rangga
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String username = (String) session.getAttribute("user");
    String role = (String) session.getAttribute("role");
    java.util.List cartHeader = (java.util.List) session.getAttribute("cart");
    int cartCount = (cartHeader != null) ? cartHeader.size() : 0;
%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Ujang Amazon - Belanja Murah</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap');

        body { 
            background-color: #f8f9fa; 
            font-family: 'Poppins', sans-serif; 
            min-height: 100vh; 
            display: flex; 
            flex-direction: column; 
        }

        .navbar-custom {
            background: #ffffff;
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
            padding-top: 1rem;
            padding-bottom: 1rem;
        }

        .navbar-brand {
            font-weight: 800;
            letter-spacing: -0.5px;
            color: #0d6efd !important;
            font-size: 1.5rem;
        }

        .nav-link {
            font-weight: 500;
            color: #4b5563 !important;
            transition: color 0.2s ease;
        }

        .nav-link:hover {
            color: #0d6efd !important;
        }

        .btn-cart-icon {
            color: #4b5563;
            transition: all 0.2s;
            position: relative;
        }

        .btn-cart-icon:hover {
            color: #0d6efd;
            transform: scale(1.1);
        }

        .badge-cart {
            font-size: 0.65rem;
            padding: 0.35em 0.5em;
            top: -5px !important;
            right: -5px !important;
            animation: pulse-badge 2s infinite;
        }

        @keyframes pulse-badge {
            0% { transform: scale(1); box-shadow: 0 0 0 0 rgba(220, 53, 69, 0.7); }
            70% { transform: scale(1.1); box-shadow: 0 0 0 6px rgba(220, 53, 69, 0); }
            100% { transform: scale(1); box-shadow: 0 0 0 0 rgba(220, 53, 69, 0); }
        }

        .dropdown-menu {
            border: none;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            border-radius: 12px;
            padding: 0.5rem;
            margin-top: 1rem;
        }

        .dropdown-item {
            border-radius: 8px;
            padding: 8px 16px;
            font-size: 0.9rem;
        }

        .dropdown-item:hover {
            background-color: #f0f7ff;
            color: #0d6efd;
        }

        .dropdown-item.text-danger:hover {
            background-color: #fee2e2;
            color: #dc3545;
        }

        @media (max-width: 991px) {
            .navbar-collapse {
                background: white;
                padding: 1rem;
                border-radius: 12px;
                margin-top: 1rem;
                box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            }
            .vr { display: none; }
        }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg sticky-top navbar-custom">
        <div class="container">
            <a class="navbar-brand d-flex align-items-center" href="app">
                <div class="bg-primary bg-opacity-10 rounded p-2 me-2 d-flex align-items-center justify-content-center" style="width: 40px; height: 40px;">
                    <i class="fas fa-bolt text-primary fa-sm"></i>
                </div>
                Ujang Amazon
            </a>
            
            <button class="navbar-toggler border-0 shadow-none" type="button" data-bs-toggle="collapse" data-bs-target="#navContent">
                <i class="fas fa-bars text-dark fs-4"></i>
            </button>
            
            <div class="collapse navbar-collapse" id="navContent">
                <ul class="navbar-nav ms-auto align-items-center gap-2 mt-3 mt-lg-0">
                    
                    <li class="nav-item me-lg-2">
                        <a class="btn btn-link btn-cart-icon text-decoration-none position-relative p-2" href="app?action=cart">
                            <i class="fas fa-shopping-bag fs-5"></i>
                            <span id="cartCount" class="position-absolute translate-middle badge rounded-pill bg-danger border border-white badge-cart <%= (cartCount==0)?"d-none":"" %>">
                                <%= cartCount %>
                            </span>
                        </a>
                    </li>

                    <li class="vr d-none d-lg-block mx-2 text-secondary opacity-25"></li>

                    <% if (username == null) { %>
                        <li class="nav-item w-100 w-lg-auto">
                            <a href="login.jsp" class="btn btn-outline-primary w-100 rounded-pill px-4 fw-bold btn-sm">Masuk</a>
                        </li>
                        <li class="nav-item w-100 w-lg-auto">
                            <a href="register.jsp" class="btn btn-primary w-100 rounded-pill px-4 fw-bold btn-sm shadow-sm">Daftar</a>
                        </li>
                    <% } else { %>
                        <li class="nav-item dropdown w-100 w-lg-auto text-center text-lg-start">
                            <a class="nav-link dropdown-toggle d-flex align-items-center justify-content-center justify-content-lg-start gap-2" href="#" data-bs-toggle="dropdown">
                                <div class="bg-light rounded-circle border d-flex align-items-center justify-content-center" style="width: 35px; height: 35px;">
                                    <i class="fas fa-user text-secondary small"></i>
                                </div>
                                <span class="fw-semibold"><%= username %></span>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end shadow border-0 mt-2" style="border-radius: 12px; min-width: 200px;">
                                <% if ("ADMIN".equals(role)) { %>
                                    <li>
                                        <a class="dropdown-item py-2 d-flex align-items-center" href="admin">
                                            <i class="fas fa-tachometer-alt fa-fw me-3 text-secondary"></i> Dashboard
                                        </a>
                                    </li>
                                    <li><hr class="dropdown-divider my-1 opacity-25"></li>
                                <% } %>

                                <li>
                                    <a class="dropdown-item py-2 d-flex align-items-center" href="app?action=history">
                                        <i class="fas fa-history fa-fw me-3 text-secondary"></i> Riwayat Pesanan
                                    </a>
                                </li>

                                <li><hr class="dropdown-divider my-1 opacity-25"></li>

                                <li>
                                    <a class="dropdown-item py-2 d-flex align-items-center text-danger fw-semibold" href="app?action=logout">
                                        <i class="fas fa-sign-out-alt fa-fw me-3"></i> Keluar
                                    </a>
                                </li>
                            </ul>
                        </li>
                    <% } %>
                </ul>
            </div>
        </div>
    </nav>
    
    <div class="container flex-grow-1">