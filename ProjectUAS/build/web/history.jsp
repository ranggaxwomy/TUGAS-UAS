<%-- 
    Document   : history
    Created on : Dec 1, 2025, 2:30:08 PM
    Author     : Rangga
--%>

<%@include file="includes/header.jsp" %>
<%@page import="java.util.List, java.util.Map, com.d1.model.Product"%>

<style>
    .table-hover tbody tr.main-row {
        cursor: pointer;
        transition: background-color 0.2s;
    }
    .table-hover tbody tr.main-row:hover {
        background-color: #f1f5f9;
    }
    .badge-soft-warning {
        background-color: #fff8e1;
        color: #b7791f;
        border: 1px solid #fceeb5;
    }
    .badge-soft-success {
        background-color: #def7ec;
        color: #03543f;
        border: 1px solid #bcf0da;
    }
    .order-id {
        font-family: 'Consolas', 'Monaco', monospace;
        letter-spacing: 0.5px;
        color: #4a5568;
    }
    .btn-toggle-detail {
        transition: transform 0.3s ease;
    }
    .btn-toggle-detail.collapsed {
        transform: rotate(0deg);
    }
    .btn-toggle-detail:not(.collapsed) {
        transform: rotate(180deg);
        color: #0d6efd;
    }
    .detail-row {
        background-color: #f8f9fa;
        box-shadow: inset 0 0 10px rgba(0,0,0,0.03);
    }
    .product-thumb-sm {
        width: 50px;
        height: 50px;
        object-fit: contain;
        background: #fff;
        border: 1px solid #dee2e6;
        border-radius: 6px;
        padding: 2px;
    }
</style>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-10">
            
            <div class="d-flex align-items-center mb-4 ps-2">
                <div class="bg-primary bg-opacity-10 text-primary rounded-circle d-flex align-items-center justify-content-center me-3" style="width: 50px; height: 50px;">
                    <i class="fas fa-history fs-4"></i>
                </div>
                <div>
                    <h3 class="fw-bold mb-0">Riwayat Pesanan</h3>
                    <p class="text-muted small mb-0">Klik tombol panah untuk melihat detail barang.</p>
                </div>
            </div>

            <div class="card shadow-sm border-0 rounded-4 overflow-hidden">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table align-middle mb-0">
                            <thead class="bg-light">
                                <tr>
                                    <th class="ps-4 py-3 text-secondary text-uppercase small border-0" style="width: 25%;">ID Pesanan</th>
                                    <th class="py-3 text-secondary text-uppercase small border-0">Tanggal</th>
                                    <th class="py-3 text-secondary text-uppercase small border-0">Total</th>
                                    <th class="py-3 text-secondary text-uppercase small border-0 text-center">Status</th>
                                    <th class="pe-4 py-3 text-secondary text-uppercase small border-0 text-end">Detail</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    List<Map<String, Object>> history = (List<Map<String, Object>>) request.getAttribute("history");
                                    if (history != null && !history.isEmpty()) {
                                        for(Map<String, Object> o : history) {
                                            String orderId = String.valueOf(o.get("id"));
                                            List<Product> items = (List<Product>) o.get("items"); 
                                %>
                                <tr class="main-row border-bottom">
                                    <td class="ps-4 py-4">
                                        <div class="d-flex align-items-center">
                                            <div class="bg-light rounded p-2 me-3 text-secondary border">
                                                <i class="fas fa-receipt"></i>
                                            </div>
                                            <span class="order-id fw-bold">#ORD-<%= orderId %></span>
                                        </div>
                                    </td>
                                    <td class="text-muted">
                                        <i class="far fa-calendar-alt me-2 text-black-50"></i><%= o.get("date") %>
                                    </td>
                                    <td class="fw-bold text-dark">
                                        Rp <%= String.format("%,.0f", o.get("total")) %>
                                    </td>
                                    <td class="text-center">
                                        <% String st = (String) o.get("status"); 
                                           if(st.equals("Pending")) { %>
                                            <span class="badge badge-soft-warning px-3 py-2 rounded-pill fw-bold">
                                                <i class="fas fa-spinner fa-spin me-1"></i> Menunggu
                                            </span>
                                        <% } else { %>
                                            <span class="badge badge-soft-success px-3 py-2 rounded-pill fw-bold">
                                                <i class="fas fa-check-circle me-1"></i> <%= st %>
                                            </span>
                                        <% } %>
                                    </td>
                                    <td class="pe-4 text-end">
                                        <button class="btn btn-link text-decoration-none text-secondary btn-toggle-detail collapsed" 
                                                type="button" 
                                                data-bs-toggle="collapse" 
                                                data-bs-target="#detail-<%= orderId %>">
                                            <i class="fas fa-chevron-down"></i>
                                        </button>
                                    </td>
                                </tr>

                                <tr>
                                    <td colspan="5" class="p-0 border-0">
                                        <div class="collapse detail-row" id="detail-<%= orderId %>">
                                            <div class="p-4">
                                                <h6 class="fw-bold mb-3 small text-uppercase text-muted"><i class="fas fa-box-open me-2"></i>Daftar Barang Dibeli:</h6>
                                                
                                                <% if(items != null && !items.isEmpty()) { %>
                                                    <div class="list-group shadow-sm">
                                                        <% for(Product item : items) { %>
                                                            <div class="list-group-item border-0 d-flex align-items-center py-3">
                                                                <img src="<%= item.getImageUrl() %>" class="product-thumb-sm me-3">
                                                                <div class="flex-grow-1">
                                                                    <h6 class="mb-0 fw-semibold text-dark"><%= item.getName() %></h6>
                                                                    <small class="text-muted"><%= item.getDescription() %></small>
                                                                </div>
                                                                <div class="fw-bold text-primary">
                                                                    Rp <%= String.format("%,.0f", item.getPrice()) %>
                                                                </div>
                                                            </div>
                                                        <% } %>
                                                    </div>
                                                <% } else { %>
                                                    <div class="alert alert-light border text-center text-muted small mb-0">
                                                        <i class="fas fa-info-circle me-1"></i> Detail item tidak tersedia untuk pesanan ini.
                                                    </div>
                                                <% } %>
                                                
                                                <div class="mt-3 text-end border-top pt-3">
                                                    <small class="text-muted me-2">Total Transaksi:</small>
                                                    <span class="fs-5 fw-bold text-dark">Rp <%= String.format("%,.0f", o.get("total")) %></span>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <% 
                                        }
                                    } else { 
                                %>
                                <tr>
                                    <td colspan="5" class="text-center py-5">
                                        <div class="py-4 opacity-50">
                                            <i class="fas fa-box-open fa-4x text-muted mb-3"></i>
                                            <h5 class="fw-bold text-muted">Belum Ada Transaksi</h5>
                                            <a href="app" class="btn btn-sm btn-primary rounded-pill px-4 mt-2">Mulai Belanja</a>
                                        </div>
                                    </td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="includes/footer.jsp" %>