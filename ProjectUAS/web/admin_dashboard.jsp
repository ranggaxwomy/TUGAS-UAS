<%-- 
    Document   : admin_dashboard
    Created on : Dec 1, 2025, 1:49:27 PM
    Author     : Rangga
--%>

<%@page import="java.util.*, com.d1.model.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <title>Dashboard Admin - Ujang Amazon</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body {
            background-color: #f1f5f9;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .navbar-admin {
            background: linear-gradient(135deg, #dc3545 0%, #b02a37 100%);
            box-shadow: 0 4px 12px rgba(220, 53, 69, 0.25);
        }
        .card-dashboard {
            border: none;
            border-radius: 16px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
            background: #fff;
            overflow: hidden;
        }
        .table-custom th {
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: #6c757d;
            background-color: #f8f9fa;
            border-bottom: 2px solid #e9ecef;
            padding: 1rem;
        }
        .table-custom td {
            vertical-align: middle;
            padding: 1rem;
            color: #343a40;
        }
        .btn-action {
            width: 32px;
            height: 32px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border-radius: 8px;
            transition: all 0.2s;
        }
        .btn-action:hover {
            transform: translateY(-2px);
        }
        .order-item {
            border-bottom: 1px solid #f1f5f9;
            padding: 1rem;
            transition: background 0.2s;
        }
        .order-item:last-child {
            border-bottom: none;
        }
        .order-item:hover {
            background-color: #f8f9fa;
        }
        .badge-soft-success {
            background-color: #d1e7dd;
            color: #0f5132;
        }
    </style>
</head>
<body>
    
    <nav class="navbar navbar-dark navbar-admin sticky-top mb-4 px-3 py-3">
        <div class="container-fluid">
            <span class="navbar-brand fw-bold d-flex align-items-center">
                <i class="fas fa-user-shield me-2"></i> Admin Panel
            </span>
            <div class="d-flex align-items-center">
                <span class="text-white-50 small me-3 d-none d-md-block">Selamat Bekerja, Admin</span>
                <a href="app?action=logout" class="btn btn-light btn-sm rounded-pill px-3 fw-bold text-danger shadow-sm">
                    <i class="fas fa-sign-out-alt me-1"></i> Logout
                </a>
            </div>
        </div>
    </nav>

    <div class="container py-2">
        <div class="row g-4">
            
            <div class="col-lg-8">
                <div class="card card-dashboard h-100">
                    <div class="card-header bg-white border-bottom border-light p-4 d-flex justify-content-between align-items-center">
                        <div>
                            <h5 class="fw-bold mb-0 text-dark">Manajemen Produk</h5>
                            <small class="text-muted">Kelola inventaris barang toko</small>
                        </div>
                        <a href="admin?action=add" class="btn btn-primary rounded-pill px-4 shadow-sm">
                            <i class="fas fa-plus me-2"></i> Produk Baru
                        </a>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-hover table-custom mb-0">
                            <thead>
                                <tr>
                                    <th class="ps-4">ID</th>
                                    <th>Nama Produk</th>
                                    <th>Harga</th>
                                    <th class="text-end pe-4">Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for(Product p : (List<Product>)request.getAttribute("products")) { %>
                                <tr>
                                    <td class="ps-4 text-muted fw-bold">#<%= p.getId() %></td>
                                    <td>
                                        <span class="fw-semibold text-dark"><%= p.getName() %></span>
                                    </td>
                                    <td class="text-primary fw-bold">
                                        Rp <%= String.format("%,.0f", p.getPrice()) %>
                                    </td>
                                    <td class="text-end pe-4">
                                        <a href="admin?action=edit&id=<%= p.getId() %>" class="btn-action bg-warning bg-opacity-10 text-warning me-1" title="Edit">
                                            <i class="fas fa-pen small"></i>
                                        </a>
                                        <a href="admin?action=delete&id=<%= p.getId() %>" class="btn-action bg-danger bg-opacity-10 text-danger" onclick="return confirm('Yakin ingin menghapus produk ini?')" title="Hapus">
                                            <i class="fas fa-trash small"></i>
                                        </a>
                                    </td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="card card-dashboard h-100">
                    <div class="card-header bg-white border-bottom border-light p-4">
                        <h5 class="fw-bold mb-0 text-dark">Pesanan Masuk</h5>
                        <small class="text-muted">Verifikasi transaksi terbaru</small>
                    </div>
                    <div class="card-body p-0">
                        <div class="overflow-auto" style="max-height: 600px;">
                            <% List<Map<String,Object>> orders = (List)request.getAttribute("orders");
                               if(orders != null && !orders.isEmpty()) {
                                   for(Map o : orders) { %>
                                <div class="order-item">
                                    <div class="d-flex justify-content-between align-items-start mb-2">
                                        <div>
                                            <h6 class="fw-bold text-dark mb-1"><%= o.get("name") %></h6>
                                            <div class="text-muted small">ID: #ORD-<%= o.get("id") %></div>
                                        </div>
                                        <div class="fw-bold text-success">
                                            Rp <%= String.format("%,.0f", o.get("total")) %>
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-between align-items-center mt-3">
                                        <% if("Pending".equals(o.get("status"))) { %>
                                            <span class="badge bg-warning bg-opacity-10 text-warning border border-warning border-opacity-25 rounded-pill px-3">
                                                <i class="far fa-clock me-1"></i> Pending
                                            </span>
                                            <a href="admin?action=verify&id=<%= o.get("id") %>" class="btn btn-sm btn-primary rounded-pill px-3 shadow-sm">
                                                <i class="fas fa-check me-1"></i> Verifikasi
                                            </a>
                                        <% } else { %>
                                            <span class="badge badge-soft-success rounded-pill px-3 py-2 w-100 text-center">
                                                <i class="fas fa-check-double me-2"></i> Transaksi Selesai
                                            </span>
                                        <% } %>
                                    </div>
                                </div>
                            <%     }
                               } else { %>
                                <div class="text-center py-5 text-muted">
                                    <i class="fas fa-clipboard-list fa-3x mb-3 opacity-25"></i>
                                    <p>Tidak ada pesanan baru</p>
                                </div>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>