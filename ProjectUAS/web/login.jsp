<%-- 
    Document   : login
    Created on : Dec 1, 2025, 1:49:05 PM
    Author     : Rangga
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <title>Login - Ujang Amazon</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            overflow-x: hidden; 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .card-login {
            border: none;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            overflow: hidden;
            width: 100%;
            max-width: 400px;
        }
        .login-header {
            background: linear-gradient(to right, #0d6efd, #0099ff);
            padding: 2rem 1rem 3rem 1rem;
            text-align: center;
            color: white;
            position: relative;
        }
        .login-header::after {
            content: '';
            position: absolute;
            bottom: -25px;
            left: 0;
            width: 100%;
            height: 50px;
            background: white;
            border-radius: 50% 50% 0 0; 
            transform: scaleX(1.5);
        }
        .form-control-custom {
            padding: 12px 15px 12px 45px;
            border-radius: 10px;
            border: 1px solid #e2e8f0;
            background-color: #f8f9fa;
            transition: all 0.3s;
        }
        .form-control-custom:focus {
            background-color: white;
            box-shadow: 0 0 0 4px rgba(13, 110, 253, 0.1);
            border-color: #0d6efd;
        }
        .input-icon {
            position: absolute;
            top: 50%;
            left: 15px;
            transform: translateY(-50%);
            z-index: 10;
            color: #a0aec0;
            transition: color 0.3s;
        }
        .input-group:focus-within .input-icon {
            color: #0d6efd;
        }
        .btn-login {
            border-radius: 10px;
            padding: 12px;
            font-weight: 600;
            letter-spacing: 0.5px;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(13, 110, 253, 0.3);
        }
        
        .alert-placeholder {
            height: 60px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 0.5rem;
        }
        .alert-custom {
            width: 100%;
            margin: 0;
            font-size: 0.85rem;
            padding: 0.5rem 1rem;
            border: none;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }
    </style>
</head>
<body class="d-flex align-items-center justify-content-center p-3">

    <div class="card card-login">
        <div class="login-header">
            <div class="mb-2">
                <i class="fas fa-user-circle fa-3x text-white opacity-75"></i>
            </div>
            <h4 class="fw-bold m-0">Welcome Back!</h4>
            <p class="small opacity-75 mb-0">Silakan login untuk akses penuh</p>
        </div>

        <div class="card-body p-4 pt-4">
            
            <div class="alert-placeholder">
                <% if(request.getParameter("error")!=null) { %>
                    <div class="alert alert-danger alert-custom d-flex align-items-center rounded-3 bg-danger text-white bg-opacity-75">
                        <i class="fas fa-exclamation-triangle me-2"></i> 
                        <div>Username/Password Salah!</div>
                    </div>
                <% } else if(request.getParameter("registered")!=null) { %>
                    <div class="alert alert-success alert-custom d-flex align-items-center rounded-3 bg-success text-white bg-opacity-75">
                        <i class="fas fa-check-circle me-2"></i> 
                        <div>Daftar berhasil, silakan login!</div>
                    </div>
                <% } %>
            </div>

            <form action="app" method="POST">
                <input type="hidden" name="action" value="login">
                
                <div class="mb-3 position-relative input-group">
                    <i class="fas fa-user input-icon"></i>
                    <input type="text" name="username" class="form-control form-control-custom" placeholder="Username" required autocomplete="off">
                </div>

                <div class="mb-4 position-relative input-group">
                    <i class="fas fa-lock input-icon"></i>
                    <input type="password" name="password" class="form-control form-control-custom" placeholder="Password" required>
                </div>

                <button type="submit" class="btn btn-primary w-100 btn-login mb-3">
                    MASUK SEKARANG <i class="fas fa-arrow-right ms-2 small"></i>
                </button>
            </form>

            <div class="text-center mt-4">
                <p class="text-muted small mb-1">Belum punya akun?</p>
                <a href="register.jsp" class="fw-bold text-decoration-none text-primary">Daftar Akun Baru</a>
                
                <div class="my-4 border-top border-light"></div>
                
                <a href="app" class="text-secondary small text-decoration-none d-inline-flex align-items-center hover-underline">
                    <i class="fas fa-home me-2"></i> Kembali ke Beranda
                </a>
            </div>
        </div>
    </div>

</body>
</html>