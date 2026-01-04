<%-- 
    Document   : cart
    Created on : Dec 1, 2025, 11:44:55 AM
    Author     : Rangga
--%>

<%@include file="includes/header.jsp" %>
<%@page import="java.util.List, com.d1.model.Product"%>
<% 
    List<Product> cartItems = (List<Product>) session.getAttribute("cart"); 
    double total = (double) (request.getAttribute("totalPrice") != null ? request.getAttribute("totalPrice") : 0.0);
%>

<style>
    .cart-summary-card {
        background-color: #f8f9fa;
        border-radius: 16px;
        position: sticky;
        top: 2rem;
    }
    .product-img-cart {
        width: 80px;
        height: 80px;
        object-fit: contain;
        background: #fff;
        border-radius: 8px;
        border: 1px solid #eee;
        padding: 5px;
    }
    .table-cart td {
        vertical-align: middle;
    }
    .btn-trash {
        background-color: #fee2e2;
        color: #ef4444;
        border: none;
        transition: all 0.2s;
    }
    .btn-trash:hover {
        background-color: #ef4444;
        color: white;
        transform: scale(1.1);
    }
</style>

<div class="container py-4">
    <div class="d-flex align-items-center mb-4">
        <i class="fas fa-shopping-bag text-primary me-3 display-6"></i>
        <h2 class="fw-bold mb-0">Keranjang Belanja</h2>
    </div>

    <div class="row g-5">
        <div class="col-lg-8">
            <div class="card shadow-sm border-0 rounded-4">
                <div class="card-body p-0">
                    <% if (cartItems != null && !cartItems.isEmpty()) { %>
                    <div class="table-responsive">
                        <table class="table table-hover table-cart align-middle mb-0">
                            <thead class="bg-white border-bottom">
                                <tr>
                                    <th class="ps-4 py-3 text-secondary text-uppercase small">Produk</th>
                                    <th class="py-3 text-secondary text-uppercase small">Harga</th>
                                    <th class="text-end pe-4 py-3 text-secondary text-uppercase small">Hapus</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% int idx=0; for(Product p : cartItems) { %>
                                <tr>
                                    <td class="ps-4 py-4">
                                        <div class="d-flex align-items-center">
                                            <div class="flex-shrink-0">
                                                <img src="<%= p.getImageUrl() %>" class="product-img-cart shadow-sm">
                                            </div>
                                            <div class="flex-grow-1 ms-3">
                                                <h6 class="mb-1 fw-bold text-dark"><%= p.getName() %></h6>
                                                <small class="text-muted d-block">ID: #<%= p.getId() %></small>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="fw-bold text-primary">
                                        Rp <%= String.format("%,.0f", p.getPrice()) %>
                                    </td>
                                    <td class="text-end pe-4">
                                        <a href="app?action=delete&idx=<%= idx++ %>" class="btn btn-trash rounded-circle shadow-sm" title="Hapus Item">
                                            <i class="fas fa-trash-alt"></i>
                                        </a>
                                    </td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                    <% } else { %>
                    <div class="text-center py-5 my-5">
                        <div class="mb-4">
                            <i class="fas fa-shopping-basket text-black-50" style="font-size: 5rem;"></i>
                        </div>
                        <h4 class="fw-bold text-dark">Keranjangmu Kosong</h4>
                        <p class="text-muted mb-4">Sepertinya kamu belum menambahkan barang apapun.</p>
                        <a href="app" class="btn btn-primary btn-lg rounded-pill px-5 shadow-sm">
                            <i class="fas fa-arrow-left me-2"></i> Mulai Belanja
                        </a>
                    </div>
                    <% } %>
                </div>
            </div>
        </div>

        <% if (cartItems != null && !cartItems.isEmpty()) { %>
        <div class="col-lg-4">
            <div class="cart-summary-card p-4 border-0 shadow-sm">
                <h5 class="fw-bold mb-4">Ringkasan Pesanan</h5>
                
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <span class="text-muted">Total Tagihan</span>
                    <span class="h4 fw-bold text-primary mb-0">Rp <%= String.format("%,.0f", total) %></span>
                </div>

                <hr class="my-4 text-muted opacity-25">

                <% if(session.getAttribute("user") != null) { %>
                    <a href="app?action=checkout" class="btn btn-primary w-100 py-3 rounded-3 fw-bold shadow-sm mb-3">
                        <i class="fas fa-credit-card me-2"></i> Proses Checkout
                    </a>
                <% } else { %>
                    <a href="login.jsp" class="btn btn-warning w-100 py-3 rounded-3 fw-bold text-white shadow-sm mb-3">
                        <i class="fas fa-sign-in-alt me-2"></i> Login untuk Checkout
                    </a>
                <% } %>
                
                <a href="app?action=clear" class="btn btn-outline-danger w-100 py-2 rounded-3 border-0 btn-sm">
                    <i class="fas fa-trash me-2"></i> Kosongkan Keranjang
                </a>
            </div>
        </div>
        <% } %>
    </div>
</div>

<%@include file="includes/footer.jsp" %>