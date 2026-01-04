<%-- 
    Document   : register
    Created on : Dec 1, 2025, 2:06:02 PM
    Author     : Rangga
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <title>Daftar Akun - Ujang Amazon</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body {
            background: linear-gradient(135deg, #f0fdf4 0%, #c6f6d5 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .card-register {
            border: none;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            overflow: hidden;
            width: 100%;
            max-width: 400px;
        }
        .register-header {
            background: linear-gradient(to right, #198754, #20c997);
            padding: 2rem 1rem 3rem 1rem;
            text-align: center;
            color: white;
            position: relative;
        }
        .register-header::after {
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
            box-shadow: 0 0 0 4px rgba(25, 135, 84, 0.1);
            border-color: #198754;
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
            color: #198754;
        }
        .btn-register {
            border-radius: 10px;
            padding: 12px;
            font-weight: 600;
            letter-spacing: 0.5px;
            transition: transform 0.2s, box-shadow 0.2s;
            background: linear-gradient(to right, #198754, #157347);
            border: none;
        }
        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(25, 135, 84, 0.3);
            background: linear-gradient(to right, #157347, #146c43);
        }
    </style>
</head>
<body class="d-flex align-items-center justify-content-center p-3">

    <div class="card card-register">
        <div class="register-header">
            <div class="mb-2">
                <i class="fas fa-user-plus fa-3x text-white opacity-75"></i>
            </div>
            <h4 class="fw-bold m-0">Buat Akun Baru</h4>
            <p class="small opacity-75 mb-0">Bergabunglah bersama kami sekarang</p>
        </div>

        <div class="card-body p-4 pt-4">
            <form action="app" method="POST">
                <input type="hidden" name="action" value="register">
                
                <div class="mb-3 position-relative input-group">
                    <i class="fas fa-user input-icon"></i>
                    <input type="text" name="username" class="form-control form-control-custom" placeholder="Username" required autocomplete="off">
                </div>

                <div class="mb-4 position-relative input-group">
                    <i class="fas fa-key input-icon"></i>
                    <input type="password" name="password" class="form-control form-control-custom" placeholder="Password" required>
                </div>

                <button type="submit" class="btn btn-success w-100 btn-register mb-3">
                    DAFTAR SEKARANG
                </button>
            </form>

            <div class="text-center mt-3">
                <p class="text-muted small mb-1">Sudah punya akun?</p>
                <a href="login.jsp" class="fw-bold text-decoration-none text-success">
                    Login di sini <i class="fas fa-sign-in-alt ms-1"></i>
                </a>
            </div>
        </div>
    </div>

</body>
</html>