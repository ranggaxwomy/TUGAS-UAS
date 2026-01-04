<%-- 
    Document   : index
    Created on : Dec 1, 2025
    Author     : Rangga
--%>

<%@include file="includes/header.jsp" %>
<%@page import="java.util.List, com.d1.model.Product"%>

<%
    if (request.getAttribute("products") == null) {
        response.sendRedirect("app");
        return;
    }

    boolean isUserLoggedIn = (session.getAttribute("user") != null);
%>

<style>
    .banner-gradient {
        background: linear-gradient(135deg, #0d6efd 0%, #0dcaf0 100%);
        border-radius: 1rem;
        position: relative;
        overflow: hidden;
        box-shadow: 0 10px 20px rgba(13, 110, 253, 0.15);
    }
    .banner-circle {
        position: absolute;
        background: rgba(255, 255, 255, 0.1);
        border-radius: 50%;
    }
    .product-card {
        border: 1px solid #f0f0f0;
        border-radius: 12px;
        transition: all 0.3s ease;
        background: #fff;
    }
    .product-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 15px 30px rgba(0,0,0,0.08);
        border-color: transparent;
    }
    .img-wrapper {
        height: 200px;
        background-color: #f8f9fa;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 12px 12px 0 0;
        padding: 1.5rem;
        position: relative;
    }
    .product-img {
        max-height: 100%;
        max-width: 100%;
        object-fit: contain;
        transition: transform 0.3s ease;
    }
    .product-card:hover .product-img {
        transform: scale(1.05);
    }
    .line-clamp-title {
        display: -webkit-box;
        -webkit-line-clamp: 1;
        -webkit-box-orient: vertical;
        overflow: hidden;
    }
    .line-clamp-desc {
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
        height: 2.8em;
    }
    .btn-cart {
        border-radius: 50px;
        font-weight: 600;
        padding: 0.6rem 1.2rem;
        box-shadow: 0 4px 6px rgba(13, 110, 253, 0.2);
    }
</style>

<div class="container py-4">
    <div class="banner-gradient text-white text-center p-5 mb-5">
        <div class="banner-circle" style="width: 200px; height: 200px; top: -50px; left: -50px;"></div>
        <div class="banner-circle" style="width: 300px; height: 300px; bottom: -100px; right: -50px;"></div>
        
        <div class="position-relative z-1">
            <h1 class="display-5 fw-bold mb-2">WELCOME TO UJANG AMAZON</h1>
            <p class="lead opacity-90 fst-italic">"DI JAMIN MURAH DAN TIDAK BERKUALITAS"</p>
        </div>
    </div>

    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-xl-4 g-4 mb-5">
        <% 
           List<Product> list = (List<Product>) request.getAttribute("products");
           if (list != null) {
               for(Product p : list) {
        %>
        <div class="col">
            <div class="card h-100 product-card">
                <div class="img-wrapper">
                    <img src="<%= p.getImageUrl() %>" class="product-img" alt="<%= p.getName() %>">
                </div>
             
                <div class="card-body d-flex flex-column p-4">
                    <h5 class="card-title fw-bold text-dark mb-1 line-clamp-title"><%= p.getName() %></h5>
                    <p class="card-text text-muted small mb-3 line-clamp-desc"><%= p.getDescription() %></p>
                    
                    <div class="mt-auto">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <span class="text-secondary small">Harga Terbaik</span>
                            <span class="fs-5 fw-bold text-primary">Rp <%= String.format("%,.0f", p.getPrice()) %></span>
                        </div>
                        
                        <button onclick="addToCart('<%= p.getId() %>')" class="btn btn-primary w-100 btn-cart">
                            <i class="fas fa-cart-plus me-2"></i> Add to Cart
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <% 
               }
           } 
        %>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
    const isLoggedIn = <%= isUserLoggedIn %>;

    function addToCart(pid) {
        if (!isLoggedIn) {
            Swal.fire({
                title: 'Akses Dibatasi',
                text: "Silakan login terlebih dahulu untuk mulai berbelanja.",
                icon: 'warning',
                iconColor: '#ffc107',
                showCancelButton: true,
                confirmButtonColor: '#0d6efd',
                cancelButtonColor: '#e2e6ea',
                confirmButtonText: 'Login Sekarang',
                cancelButtonText: '<span style="color:#6c757d">Batal</span>',
                customClass: {
                    popup: 'rounded-4 border-0 shadow-lg',
                    confirmButton: 'rounded-pill px-4',
                    cancelButton: 'rounded-pill px-4'
                }
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = 'login.jsp';
                }
            });
            return;
        }

        fetch('app?action=add&ajax=true&id=' + pid)
            .then(res => res.text())
            .then(count => {
                const badge = document.getElementById('cartCount');
                if(badge) {
                    badge.innerText = count;
                    badge.classList.remove('d-none');
                }

                const Toast = Swal.mixin({
                    toast: true,
                    position: 'top-end',
                    showConfirmButton: false,
                    timer: 2000,
                    timerProgressBar: true,
                    didOpen: (toast) => {
                        toast.addEventListener('mouseenter', Swal.stopTimer);
                        toast.addEventListener('mouseleave', Swal.resumeTimer);
                    }
                });

                Toast.fire({
                    icon: 'success',
                    title: 'Berhasil Masuk Keranjang'
                });
            })
            .catch(err => console.error(err));
    }
</script>

<%@include file="includes/footer.jsp" %>