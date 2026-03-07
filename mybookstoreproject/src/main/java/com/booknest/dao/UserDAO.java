package com.booknest.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.booknest.model.User;
import com.booknest.utility.DBConnection;

public class UserDAO implements DAOInterface{
	Connection con=null;
	@Override
	
	//**********************************REGISTRATION OF USER*****************************************
	public boolean registerUser(User user) {
		 boolean status = false;

	        try {
	        	DBConnection db=new DBConnection();

	            con = db.getConnection();

	            PreparedStatement ps = con.prepareStatement("INSERT INTO users(name,email,password,phone,role_id,account_status) VALUES(?,?,?,?,?,?)");

	            ps.setString(1, user.getName());
	            ps.setString(2, user.getEmail());
	            ps.setString(3, user.getPassword());
	            ps.setString(4, user.getPhone());
	            ps.setInt(5, user.getRole_id());
	            ps.setString(6, user.getAccount_status());

	            int row = ps.executeUpdate();

	            if (row > 0) {
	                status = true;
	            }

	        } catch (Exception e) {
	            e.printStackTrace();
	        }

	        return status;
	}

	
	//*******************************************LOGIN OF USER********************************************************
	@Override
	public User loginUser(String email, String password) {

        User user = null;

        try {
        	DBConnection db=new DBConnection();
            con = db.getConnection();

            String sql = "SELECT * FROM users WHERE email=? AND password=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                user = new User();

                user.setUser_id(rs.getInt("user_id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setRole_id(rs.getInt("role_id"));
                user.setAccount_status(rs.getString("account_status"));
                user.setCreatedDate(rs.getString("created_date"));

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
	}
	
	 
	
	
	
	
	
	

}
