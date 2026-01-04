<%-- 
    Document   : checkout
    Created on : Dec 1, 2025, 11:46:33 AM
    Author     : Rangga
--%>

<%@include file="includes/header.jsp" %>
<%@page import="java.util.Map"%>
<% 
    Map<String,String> err = (Map) request.getAttribute("errors"); 
    String name = (String) request.getAttribute("oldName");
    String addr = (String) request.getAttribute("oldAddress"); 
%>

<style>
    .payment-option-label {
        cursor: pointer;
        transition: all 0.2s ease;
        border: 2px solid #dee2e6;
    }
    .payment-option-input:checked + .payment-option-label {
        border-color: #0d6efd;
        background-color: #f0f7ff;
        color: #0d6efd;
    }
    .payment-option-input:checked + .payment-option-label i {
        color: #0d6efd !important;
    }
    .form-floating > label {
        color: #6c757d;
    }
    .form-control:focus {
        border-color: #86b7fe;
        box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.15);
    }
</style>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-6 col-xl-5">
            <div class="text-center mb-4">
                <div class="d-inline-flex align-items-center justify-content-center bg-primary bg-opacity-10 text-primary rounded-circle mb-3" style="width: 60px; height: 60px;">
                    <i class="fas fa-file-invoice-dollar fs-3"></i>
                </div>
                <h2 class="fw-bold">Checkout Pesanan</h2>
                <p class="text-muted">Lengkapi data diri untuk menyelesaikan pesanan.</p>
            </div>

            <div class="card shadow-lg border-0 rounded-4 overflow-hidden">
                <div class="card-body p-4 p-md-5">
                    
                    <% if(err!=null && err.containsKey("cart")) { %>
                        <div class="alert alert-danger d-flex align-items-center rounded-3 mb-4" role="alert">
                            <i class="fas fa-exclamation-circle me-2"></i>
                            <div><%= err.get("cart") %></div>
                        </div>
                    <% } %>

                    <form action="app" method="POST">
                        <input type="hidden" name="action" value="place_order">
                        
                        <h5 class="fw-bold mb-3 text-dark"><i class="fas fa-user-circle me-2 text-primary"></i>Informasi Pengiriman</h5>
                        
                        <div class="form-floating mb-3">
                            <input type="text" name="name" class="form-control rounded-3 <%= (err!=null&&err.containsKey("name"))?"is-invalid":"" %>" id="floatingName" placeholder="Nama Lengkap" value="<%= (name!=null)?name:"" %>">
                            <label for="floatingName">Nama Lengkap Penerima</label>
                            <% if(err!=null&&err.containsKey("name")){ %>
                                <div class="invalid-feedback text-start ps-2"><%= err.get("name") %></div>
                            <% } %>
                        </div>

                        <div class="form-floating mb-3">
                            <input type="email" name="email" class="form-control rounded-3" id="floatingEmail" placeholder="name@example.com">
                            <label for="floatingEmail">Alamat Email <span class="text-muted">(Opsional)</span></label>
                        </div>

                        <div class="form-floating mb-4">
                            <textarea name="address" class="form-control rounded-3 <%= (err!=null&&err.containsKey("address"))?"is-invalid":"" %>" placeholder="Alamat Lengkap" id="floatingAddress" style="height: 100px"><%= (addr!=null)?addr:"" %></textarea>
                            <label for="floatingAddress">Alamat Lengkap Pengiriman</label>
                            <% if(err!=null&&err.containsKey("address")){ %>
                                <div class="invalid-feedback text-start ps-2"><%= err.get("address") %></div>
                            <% } %>
                        </div>

                        <h5 class="fw-bold mb-3 text-dark mt-5"><i class="fas fa-wallet me-2 text-primary"></i>Metode Pembayaran</h5>
                        
                        <div class="row g-3 mb-4">
                            <div class="col-6">
                                <input type="radio" class="btn-check payment-option-input" name="payment" id="pay1" value="Transfer Bank" checked>
                                <label class="payment-option-label card h-100 p-3 text-center rounded-3 align-items-center justify-content-center" for="pay1">
                                    <i class="fas fa-university fs-3 mb-2 text-secondary"></i>
                                    <span class="fw-bold small d-block">Transfer Bank</span>
                                </label>
                            </div>
                            <div class="col-6">
                                <input type="radio" class="btn-check payment-option-input" name="payment" id="pay2" value="COD">
                                <label class="payment-option-label card h-100 p-3 text-center rounded-3 align-items-center justify-content-center" for="pay2">
                                    <i class="fas fa-hand-holding-usd fs-3 mb-2 text-secondary"></i>
                                    <span class="fw-bold small d-block">Bayar ditempat (COD)</span>
                                </label>
                            </div>
                        </div>

                        <div class="d-grid">
                            <button class="btn btn-primary btn-lg py-3 rounded-3 fw-bold shadow-sm" type="submit">
                                Bayar Sekarang <i class="fas fa-chevron-right ms-2 small"></i>
                            </button>
                        </div>
                    </form>
                </div>
            </div>
            
            <div class="text-center mt-4">
                <a href="app?action=cart" class="text-decoration-none text-muted small">
                    <i class="fas fa-arrow-left me-1"></i> Kembali ke Keranjang
                </a>
            </div>
        </div>
    </div>
</div>

<%@include file="includes/footer.jsp" %>