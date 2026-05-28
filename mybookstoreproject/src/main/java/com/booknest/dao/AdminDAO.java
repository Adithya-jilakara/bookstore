package com.booknest.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.booknest.model.User;
import com.booknest.utility.DBConnection;

public class AdminDAO implements AdminDAOinterface {

	public int getTotalSellers() {
		int count = 0;
		try {
			Connection con = DBConnection.getConnection();
			String sql = "SELECT COUNT(*) FROM users WHERE role_id=2";
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	public int getPendingSellers() {
		int count = 0;
		try {
			Connection con = DBConnection.getConnection();
			String sql = "SELECT COUNT(*) FROM users WHERE role_id=2 AND account_status='PENDING'";
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	// TOTAL CUSTOMERS
	public int getTotalCustomers() {
	    int count = 0;
	    try {
	        Connection con = DBConnection.getConnection();
	        String sql = "SELECT COUNT(*) FROM users WHERE role_id=3";
	        PreparedStatement ps = con.prepareStatement(sql);
	        ResultSet rs = ps.executeQuery();

	        if(rs.next()){
	            count = rs.getInt(1);
	        }
	    } catch(Exception e){
	        e.printStackTrace();
	    }
	    return count;
	}

	// TOTAL BOOKS
	public int getTotalBooks() {
	    int count = 0;
	    try {
	        Connection con = DBConnection.getConnection();
	        String sql = "SELECT COUNT(*) FROM books";
	        PreparedStatement ps = con.prepareStatement(sql);
	        ResultSet rs = ps.executeQuery();

	        if(rs.next()){
	            count = rs.getInt(1);
	        }
	    } catch(Exception e){
	        e.printStackTrace();
	    }
	    return count;
	}

	// RECENT SELLERS
	public List<User> getRecentSellers() {
		List<User> list = new ArrayList<>();
		

	    try {
	    	 Connection con = DBConnection.getConnection();

	         String sql = "SELECT * FROM users WHERE role_id=2 ORDER BY user_id DESC LIMIT 5";

	         PreparedStatement ps = con.prepareStatement(sql);

	         ResultSet rs = ps.executeQuery();

	         while (rs.next()) {
	             User u = new User();

	             u.setUser_id(rs.getInt("user_id"));
	             u.setName(rs.getString("name"));
	             u.setEmail(rs.getString("email"));
	             u.setAccount_status(rs.getString("account_status"));

	             list.add(u);
	         }

	    } catch(Exception e){
	        e.printStackTrace();
	    }

	    return list;
	}

	// RECENT SELLERS
	
		public List<User> getRecentCustomers() {
			List<User> list = new ArrayList<>();
			

		    try {
		    	 Connection con = DBConnection.getConnection();

		         String sql = "SELECT * FROM users WHERE role_id=3 ORDER BY user_id DESC LIMIT 5";

		         PreparedStatement ps = con.prepareStatement(sql);

		         ResultSet rs = ps.executeQuery();

		         while (rs.next()) {
		             User u = new User();

		             u.setUser_id(rs.getInt("user_id"));
		             u.setName(rs.getString("name"));
		             u.setEmail(rs.getString("email"));
		             u.setAccount_status(rs.getString("account_status"));

		             list.add(u);
		         }

		    } catch(Exception e){
		        e.printStackTrace();
		    }

		    return list;
		}

}
