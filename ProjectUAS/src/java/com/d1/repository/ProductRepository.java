/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.d1.repository;

import com.d1.model.Product;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author Rangga
 */
public class ProductRepository {

    public static List<Product> findAll() {
        List<Product> list = new ArrayList<>();
        try (Connection con = DBUtil.getConnection()) {
            String sql = "SELECT * FROM products";
            ResultSet rs = con.createStatement().executeQuery(sql);
            while (rs.next()) {
                list.add(new Product(
                    rs.getString("id"), rs.getString("name"),
                    rs.getString("description"), rs.getDouble("price"),
                    rs.getString("image_url")
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public static Product findById(String id) {
        Product p = null;
        try (Connection con = DBUtil.getConnection()) {
            String sql = "SELECT * FROM products WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                p = new Product(
                    rs.getString("id"), rs.getString("name"),
                    rs.getString("description"), rs.getDouble("price"),
                    rs.getString("image_url")
                );
            }
        } catch (Exception e) { e.printStackTrace(); }
        return p;
    }

    public static void addProduct(Product p) {
        try (Connection con = DBUtil.getConnection()) {
            String sql = "INSERT INTO products VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, p.getId());
            ps.setString(2, p.getName());
            ps.setString(3, p.getDescription());
            ps.setDouble(4, p.getPrice());
            ps.setString(5, p.getImageUrl());
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public static void updateProduct(Product p) {
        try (Connection con = DBUtil.getConnection()) {
            String sql = "UPDATE products SET name=?, description=?, price=?, image_url=? WHERE id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, p.getName());
            ps.setString(2, p.getDescription());
            ps.setDouble(3, p.getPrice());
            ps.setString(4, p.getImageUrl());
            ps.setString(5, p.getId());
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public static void deleteProduct(String id) {
        try (Connection con = DBUtil.getConnection()) {
            PreparedStatement ps = con.prepareStatement("DELETE FROM products WHERE id=?");
            ps.setString(1, id);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }
}