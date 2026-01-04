<%-- 
    Document   : invoice
    Created on : Dec 1, 2025, 11:45:24 AM
    Author     : Rangga
--%>

<%@include file="includes/header.jsp" %>

<style>
    .success-icon-wrapper {
        width: 80px;
        height: 80px;
        background-color: #d1e7dd;
        color: #198754;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 1.5rem auto;
    }
    .receipt-card {
        background: #fff;
        border-radius: 20px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.08);
        overflow: hidden;
        position: relative;
    }
    .receipt-header {
        background-image: linear-gradient(to bottom, #ffffff, #f8f9fa);
        padding-bottom: 2rem;
        border-bottom: 2px dashed #dee2e6;
        position: relative;
    }
    .receipt-header::after, .receipt-header::before {
        content: '';
        position: absolute;
        bottom: -10px;
        width: 20px;
        height: 20px;
        background-color: #f8f9fa;
        border-radius: 50%;
    }
    .receipt-header::before { left: -10px; }
    .receipt-header::after { right: -10px; }
    
    .info-row {
        display: flex;
        justify-content: space-between;
        margin-bottom: 1rem;
        font-size: 0.95rem;
    }
    .info-label { color: #6c757d; }
    .info-value { font-weight: 600; color: #212529; text-align: right; max-width: 60%; }
</style>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">
            <div class="receipt-card">
                <div class="receipt-header text-center pt-5 px-4">
                    <div class="success-icon-wrapper mb-4">
                        <i class="fas fa-check fa-3x"></i>
                    </div>
                    <h3 class="fw-bold text-dark mb-2">Pesanan Berhasil!</h3>
                    <p class="text-muted small">Terima kasih, <span class="fw-bold text-dark"><%= request.getAttribute("customerName") %></span>.<br>Pesanan Anda sedang kami proses.</p>
                </div>

                <div class="card-body bg-white px-4 py-4">
                    <div class="mb-4">
                        <h6 class="text-uppercase text-muted small fw-bold letter-spacing-1 mb-3">Detail Transaksi</h6>
                        
                        <div class="info-row">
                            <span class="info-label"><i class="far fa-credit-card me-2"></i>Metode Bayar</span>
                            <span class="info-value"><%= request.getAttribute("paymentType") %></span>
                        </div>

                        <div class="info-row">
                            <span class="info-label"><i class="fas fa-map-marker-alt me-2"></i>Alamat Kirim</span>
                            <span class="info-value text-break"><%= request.getAttribute("customerAddress") %></span>
                        </div>
                    </div>

                    <div class="p-3 rounded-3 bg-light border border-secondary border-opacity-10 mb-4">
                        <div class="d-flex justify-content-between align-items-center">
                            <span class="fw-bold text-secondary">Total Dibayar</span>
                            <span class="h4 fw-bold text-success mb-0">Rp <%= String.format("%,.0f", request.getAttribute("totalPrice")) %></span>
                        </div>
                    </div>

                    <a href="app" class="btn btn-primary w-100 py-3 rounded-pill fw-bold shadow-sm">
                        <i class="fas fa-shopping-bag me-2"></i> Belanja Lagi
                    </a>
                </div>
            </div>
            
            <div class="text-center mt-4">
                <p class="text-muted small mb-0">Bukti transaksi ini telah dikirim ke email Anda.</p>
            </div>
        </div>
    </div>
</div>

<%@include file="includes/footer.jsp" %>