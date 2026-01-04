<%-- 
    Document   : footer
    Created on : Dec 1, 2025, 11:43:56 AM
    Author     : Rangga
--%>

</div> <style>
    .footer-section {
        background-color: #212529;
        color: #f8f9fa;
        font-size: 0.9rem;
    }
    .footer-link {
        color: #adb5bd;
        text-decoration: none;
        transition: all 0.2s ease-in-out;
        display: block;
        margin-bottom: 0.5rem;
    }
    .footer-link:hover {
        color: #fff;
        transform: translateX(5px);
    }
    .social-icon-btn {
        width: 36px;
        height: 36px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        background-color: rgba(255, 255, 255, 0.1);
        color: #fff;
        border-radius: 50%;
        margin-right: 0.5rem;
        transition: all 0.3s ease;
        text-decoration: none;
    }
    .social-icon-btn:hover {
        background-color: #0d6efd;
        color: white;
        transform: translateY(-3px);
    }
</style>

<footer class="footer-section pt-5 pb-3 mt-auto">
    <div class="container">
        <div class="row g-4 justify-content-between">
            <div class="col-md-4">
                <h5 class="fw-bold text-white mb-3 d-flex align-items-center">
                    <i class="fas fa-bolt text-primary me-2"></i> Ujang Amazon
                </h5>
                <p class="text-secondary small mb-3">
                    Platform e-commerce "terpercaya" dengan slogan andalan: 
                    <i>Murah itu pasti, kualitas itu misteri.</i> Belanja puas, dompet lemas.
                </p>
                <div class="d-flex">
                    <a href="#" class="social-icon-btn"><i class="fab fa-instagram"></i></a>
                    <a href="#" class="social-icon-btn"><i class="fab fa-twitter"></i></a>
                    <a href="#" class="social-icon-btn"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="social-icon-btn"><i class="fab fa-whatsapp"></i></a>
                </div>
            </div>

            <div class="col-md-3">
                <h6 class="fw-bold text-white mb-3">Menu Pintas</h6>
                <div class="d-flex flex-column">
                    <a href="app" class="footer-link">Beranda Utama</a>
                </div>
            </div>

            <div class="col-md-4">
                <h6 class="fw-bold text-white mb-3">Butuh Bantuan?</h6>
                <ul class="list-unstyled text-secondary small">
                    <li class="mb-2"><i class="fas fa-map-marker-alt me-2 text-primary"></i> Jl. Unpam Indah No. 404</li>
                    <li class="mb-2"><i class="fas fa-envelope me-2 text-primary"></i> help@ujang-amazon.com</li>
                    <li class="mb-2"><i class="fas fa-phone me-2 text-primary"></i> +62 812-3456-7890</li>
                </ul>
            </div>
        </div>

        <hr class="border-secondary my-4 opacity-25">

        <div class="row align-items-center">
            <div class="col-md-6 text-center text-md-start">
                <p class="mb-0 text-secondary small">&copy; 2025 <b>Ujang Amazon</b>. All rights reserved.</p>
            </div>
            <div class="col-md-6 text-center text-md-end mt-2 mt-md-0">
                <small class="text-white">Developed By: Rangga<span class="fas fa-heart text-danger"></span></small>
            </div>
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>