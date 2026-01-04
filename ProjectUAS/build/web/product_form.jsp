<%-- 
    Document   : product_form
    Created on : Dec 1, 2025, 2:06:44 PM
    Author     : Rangga
--%>

<%@page import="com.d1.model.Product"%>
<% Product p = (Product) request.getAttribute("product"); %>
<!DOCTYPE html>
<html lang="id">
<head>
    <title><%= (p!=null)?"Edit":"Tambah" %> Produk - Admin Panel</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .card-form {
            border: none;
            border-radius: 20px;
            box-shadow: 0 15px 30px rgba(0,0,0,0.08);
            overflow: hidden;
            width: 100%;
            max-width: 550px;
        }
        .form-header {
            background: linear-gradient(135deg, #0d6efd 0%, #0099ff 100%);
            padding: 1.5rem 2rem;
            color: white;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .img-preview-container {
            width: 150px;
            height: 150px;
            background: #ffffff;
            border: 1px solid #dee2e6;
            border-radius: 12px;
            padding: 5px;
            margin: 0 auto 1.5rem auto;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .img-preview-container img {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain;
            border-radius: 8px;
        }
        .form-floating > .form-control:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.15);
        }
        .btn-save {
            padding: 12px;
            font-weight: 600;
            letter-spacing: 0.5px;
        }
    </style>
</head>
<body>

    <div class="card card-form">
        <div class="form-header">
            <div>
                <h5 class="fw-bold mb-0">
                    <%= (p!=null)?"Edit Produk":"Produk Baru" %>
                </h5>
                <small class="opacity-75">Form Admin</small>
            </div>
            <i class="fas <%= (p!=null)?"fa-edit":"fa-box-open" %> fa-2x opacity-50"></i>
        </div>

        <div class="card-body p-4">
            
            <form action="admin" method="POST">
                <input type="hidden" name="action" value="save">
                
                <div class="text-center">
                    <div class="img-preview-container">
                        <img id="previewImg" 
                             src="<%= (p!=null && p.getImageUrl()!=null && !p.getImageUrl().isEmpty()) ? p.getImageUrl() : "https://via.placeholder.com/150?text=No+Image" %>" 
                             alt="Preview Produk">
                    </div>
                </div>

                <div class="form-floating mb-3">
                    <input type="text" name="image" class="form-control" id="floatingImg" placeholder="URL Gambar" 
                           value="<%= (p!=null)?p.getImageUrl():"" %>" oninput="updatePreview(this.value)">
                    <label for="floatingImg"><i class="fas fa-link me-2 text-secondary"></i>URL Gambar Produk</label>
                </div>

                <div class="row g-3 mb-3">
                    <div class="col-4">
                        <div class="form-floating">
                            <input type="text" name="id" class="form-control bg-light" id="floatingId" placeholder="ID" 
                                   value="<%= (p!=null)?p.getId():"" %>" <%= (p!=null)?"readonly":"" %> required>
                            <label for="floatingId">ID</label>
                        </div>
                    </div>
                    <div class="col-8">
                        <div class="form-floating">
                            <input type="hidden" name="price" id="realPrice" value="<%= (p!=null)?(long)p.getPrice():"" %>">
                            
                            <input type="text" class="form-control" id="floatingPrice" placeholder="Harga" 
                                   value="<%= (p!=null)?String.format("%,d", (long)p.getPrice()).replace(',', '.') : "" %>" 
                                   onkeyup="formatRupiah(this)" required>
                            <label for="floatingPrice">Harga (Rp)</label>
                        </div>
                    </div>
                </div>

                <div class="form-floating mb-3">
                    <input type="text" name="name" class="form-control" id="floatingName" placeholder="Nama Produk" 
                           value="<%= (p!=null)?p.getName():"" %>" required>
                    <label for="floatingName">Nama Produk</label>
                </div>

                <div class="form-floating mb-4">
                    <textarea name="desc" class="form-control" id="floatingDesc" placeholder="Deskripsi" style="height: 100px"><%= (p!=null)?p.getDescription():"" %></textarea>
                    <label for="floatingDesc">Deskripsi Singkat</label>
                </div>

                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary btn-save rounded-pill shadow-sm">
                        <i class="fas fa-save me-2"></i> SIMPAN DATA
                    </button>
                    <a href="admin" class="btn btn-light text-muted rounded-pill">
                        Batal
                    </a>
                </div>
            </form>
        </div>
    </div>

    <script>
        function updatePreview(url) {
            const img = document.getElementById('previewImg');
            if (url && url.trim() !== '') {
                img.src = url;
                img.onerror = function() {
                    this.src = 'https://via.placeholder.com/150?text=Error';
                };
            } else {
                img.src = 'https://via.placeholder.com/150?text=No+Image';
            }
        }

        function formatRupiah(element) {
            let val = element.value;
            val = val.replace(/[^0-9]/g, '');
            document.getElementById('realPrice').value = val;
            
            if (val === "") {
                element.value = "";
                return;
            }
            
            let formatted = val.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
            element.value = formatted;
        }
    </script>

</body>
</html>