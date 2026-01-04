/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.d1.controller;

import com.d1.model.Product;
import com.d1.repository.*;
import java.io.IOException;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

/**
 *
 * @author Rangga
 */
@WebServlet(name = "MainController", urlPatterns = {"/app"}) 
public class MainController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "home";

        switch (action) {
            case "add": addToCart(req, resp); break;
            case "cart": viewCart(req, resp); break;
            case "delete": deleteItem(req, resp); break;
            case "clear": clearCart(req, resp); break;
            case "checkout": viewCheckout(req, resp); break;
            case "history": viewHistory(req, resp); break;
            case "logout": 
                req.getSession().invalidate(); 
                resp.sendRedirect("index.jsp"); 
                break;
            default: viewHome(req, resp); break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        
        if ("place_order".equals(action)) processOrder(req, resp);
        else if ("login".equals(action)) handleLogin(req, resp);
        else if ("register".equals(action)) handleRegister(req, resp);
    }

    private void viewHome(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("products", ProductRepository.findAll());
        req.getRequestDispatcher("index.jsp").forward(req, resp);
    }

    private void handleLogin(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String role = UserRepository.login(req.getParameter("username"), req.getParameter("password"));
        if (role != null) {
            HttpSession s = req.getSession();
            s.setAttribute("user", req.getParameter("username"));
            s.setAttribute("role", role);
            resp.sendRedirect("ADMIN".equals(role) ? "admin" : "app");
        } else {
            resp.sendRedirect("login.jsp?error=true");
        }
    }

    private void handleRegister(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        UserRepository.register(req.getParameter("username"), req.getParameter("password"));
        resp.sendRedirect("login.jsp?registered=true");
    }

    private void addToCart(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Product p = ProductRepository.findById(req.getParameter("id"));
        int count = 0;
        if (p != null) {
            HttpSession session = req.getSession();
            List<Product> cart = (List<Product>) session.getAttribute("cart");
            if (cart == null) {
                cart = new ArrayList<>();
                session.setAttribute("cart", cart);
            }
            cart.add(p);
            count = cart.size();
        }
        if ("true".equals(req.getParameter("ajax"))) {
            resp.getWriter().write(String.valueOf(count));
        } else {
            resp.sendRedirect("app");
        }
    }

    private void viewCart(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        updateTotal(req);
        req.getRequestDispatcher("cart.jsp").forward(req, resp);
    }

    private void deleteItem(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            int idx = Integer.parseInt(req.getParameter("idx"));
            List<Product> cart = (List<Product>) req.getSession().getAttribute("cart");
            if(cart != null) cart.remove(idx);
        } catch (Exception e) {}
        resp.sendRedirect("app?action=cart");
    }

    private void clearCart(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.getSession().removeAttribute("cart");
        resp.sendRedirect("app?action=cart");
    }

    private void viewCheckout(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (req.getSession().getAttribute("user") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }
        updateTotal(req);
        req.getRequestDispatcher("checkout.jsp").forward(req, resp);
    }

    private void processOrder(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String addr = req.getParameter("address");
        List<Product> cart = (List<Product>) req.getSession().getAttribute("cart");

        Map<String, String> err = new HashMap<>();
        if (name == null || name.length() < 4) err.put("name", "Nama minimal 3 huruf");
        if (addr == null || addr.isEmpty()) err.put("address", "Alamat wajib diisi");
        if (cart == null || cart.isEmpty()) err.put("cart", "Keranjang kosong");

        updateTotal(req);
        if (err.isEmpty()) {
            String currentUser = (String) req.getSession().getAttribute("user");
            
            OrderRepository.createOrder(name, (double)req.getAttribute("totalPrice"), currentUser, cart);
            
            req.setAttribute("customerName", name);
            req.setAttribute("customerAddress", addr);
            req.setAttribute("paymentType", req.getParameter("payment"));
            req.getSession().removeAttribute("cart");
            req.getRequestDispatcher("invoice.jsp").forward(req, resp);
        } else {
            req.setAttribute("errors", err);
            req.setAttribute("oldName", name);
            req.setAttribute("oldAddress", addr);
            viewCheckout(req, resp);
        }
    }
    
    private void viewHistory(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String user = (String) session.getAttribute("user");
        
        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        req.setAttribute("history", OrderRepository.getOrdersByUser(user));
        req.getRequestDispatcher("history.jsp").forward(req, resp);
    }
    
    private void logout(HttpServletRequest req, HttpServletResponse resp) throws IOException {
    req.getSession().invalidate(); 
    
    resp.sendRedirect("app"); 
    }

    private void updateTotal(HttpServletRequest req) {
        List<Product> cart = (List<Product>) req.getSession().getAttribute("cart");
        double total = (cart != null) ? cart.stream().mapToDouble(Product::getPrice).sum() : 0;
        req.setAttribute("totalPrice", total);
    }
}