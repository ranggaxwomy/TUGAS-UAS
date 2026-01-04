package com.d1.repository;

import com.d1.model.Product;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class OrderRepository {

    public static void createOrder(String name, double total, String username, List<Product> cart) {
        Connection con = null;
        try {
            con = DBUtil.getConnection();
            con.setAutoCommit(false); 

            String sqlOrder = "INSERT INTO orders (customer_name, total_price, username, order_date, status) VALUES (?, ?, ?, NOW(), 'Pending')";
            PreparedStatement psOrder = con.prepareStatement(sqlOrder, Statement.RETURN_GENERATED_KEYS);
            psOrder.setString(1, name);
            psOrder.setDouble(2, total);
            psOrder.setString(3, username);
            psOrder.executeUpdate();

            ResultSet rsKeys = psOrder.getGeneratedKeys();
            int orderId = 0;
            if (rsKeys.next()) {
                orderId = rsKeys.getInt(1);
            }

            String sqlItem = "INSERT INTO order_items (order_id, product_id, price) VALUES (?, ?, ?)";
            PreparedStatement psItem = con.prepareStatement(sqlItem);

            for (Product p : cart) {
                psItem.setInt(1, orderId);
                psItem.setString(2, p.getId());
                psItem.setDouble(3, p.getPrice());
                psItem.addBatch();
            }
            psItem.executeBatch();

            con.commit(); 
        } catch (Exception e) {
            e.printStackTrace();
            try { if (con != null) con.rollback(); } catch (Exception ex) {}
        } finally {
            try { if (con != null) con.close(); } catch (Exception ex) {}
        }
    }

    public static List<Map<String, Object>> getOrdersByUser(String username) {
        List<Map<String, Object>> list = new ArrayList<>();
        try (Connection con = DBUtil.getConnection()) {
            String sql = "SELECT * FROM orders WHERE username = ? ORDER BY order_date DESC";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                int orderId = rs.getInt("id");
                
                map.put("id", orderId);
                map.put("name", rs.getString("customer_name"));
                map.put("total", rs.getDouble("total_price"));
                map.put("status", rs.getString("status"));
                map.put("date", rs.getTimestamp("order_date"));
                
                List<Product> items = new ArrayList<>();
                String sqlItems = "SELECT p.* FROM order_items oi JOIN products p ON oi.product_id = p.id WHERE oi.order_id = ?";
                PreparedStatement psItems = con.prepareStatement(sqlItems);
                psItems.setInt(1, orderId);
                ResultSet rsItems = psItems.executeQuery();
                
                while(rsItems.next()) {
                    items.add(new Product(
                        rsItems.getString("id"),
                        rsItems.getString("name"),
                        rsItems.getString("description"),
                        rsItems.getDouble("price"),
                        rsItems.getString("image_url")
                    ));
                }
                
                map.put("items", items);
                list.add(map);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public static List<Map<String, Object>> getAllOrders() {
        List<Map<String, Object>> list = new ArrayList<>();
        try (Connection con = DBUtil.getConnection()) {
            String sql = "SELECT * FROM orders ORDER BY order_date DESC";
            ResultSet rs = con.createStatement().executeQuery(sql);
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("id", rs.getInt("id"));
                map.put("name", rs.getString("customer_name"));
                map.put("total", rs.getDouble("total_price"));
                map.put("status", rs.getString("status"));
                list.add(map);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public static void verifyOrder(int id) {
        try (Connection con = DBUtil.getConnection()) {
            PreparedStatement ps = con.prepareStatement("UPDATE orders SET status='Selesai' WHERE id=?");
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }
}