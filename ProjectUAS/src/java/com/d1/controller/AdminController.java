/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.d1.controller;

import com.d1.model.Product;
import com.d1.repository.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

/**
 *
 * @author Rangga
 */
@WebServlet(name = "AdminController", urlPatterns = {"/admin"})
public class AdminController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession s = req.getSession();
        if (s.getAttribute("role") == null || !s.getAttribute("role").equals("ADMIN")) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String action = req.getParameter("action");
        if (action == null) action = "dashboard";

        switch (action) {
            case "dashboard":
                req.setAttribute("products", ProductRepository.findAll());
                req.setAttribute("orders", OrderRepository.getAllOrders());
                req.getRequestDispatcher("admin_dashboard.jsp").forward(req, resp);
                break;
            case "delete":
                ProductRepository.deleteProduct(req.getParameter("id"));
                resp.sendRedirect("admin");
                break;
            case "verify":
                OrderRepository.verifyOrder(Integer.parseInt(req.getParameter("id")));
                resp.sendRedirect("admin");
                break;
            case "edit":
                req.setAttribute("product", ProductRepository.findById(req.getParameter("id")));
                req.getRequestDispatcher("product_form.jsp").forward(req, resp);
                break;
            case "add":
                req.getRequestDispatcher("product_form.jsp").forward(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        Product p = new Product(id, req.getParameter("name"), req.getParameter("desc"), 
                                Double.parseDouble(req.getParameter("price")), req.getParameter("image"));
        
        if (ProductRepository.findById(id) != null) ProductRepository.updateProduct(p);
        else ProductRepository.addProduct(p);
        
        resp.sendRedirect("admin");
    }
}