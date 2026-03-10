package com.booknest.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.mindrot.jbcrypt.BCrypt;

import com.booknest.model.Seller;
import com.booknest.utility.DBConnection;

public class SellerDAO implements SellerDAOInterface{
	Connection con=null;
	@Override
	public boolean registerSeller(Seller seller) {

		PreparedStatement psUser = null;
		PreparedStatement psStore = null;
		ResultSet rs = null;
		DBConnection db=new DBConnection();
		boolean status=false;

		try {

		    con = db.getConnection();
		    String checkEmail = "SELECT * FROM users WHERE email=?";

		    PreparedStatement checkPs = con.prepareStatement(checkEmail);
		    checkPs.setString(1, seller.getEmail());

		    ResultSet r = checkPs.executeQuery();

		    if(r.next()){
		        return false; // email already exists
		    }

		    String userSql = "INSERT INTO users(name,email,password,phone,role_id,account_status) VALUES(?,?,?,?,?,?)";

		    psUser = con.prepareStatement(userSql, java.sql.Statement.RETURN_GENERATED_KEYS);

		    psUser.setString(1, seller.getName());
		    psUser.setString(2, seller.getEmail());
		    psUser.setString(3, seller.getPassword());
		    psUser.setString(4, seller.getPhone());
		    psUser.setInt(5, 2);
		    psUser.setString(6, "pending");

		    psUser.executeUpdate();

		    rs = psUser.getGeneratedKeys();

		    int ownerUserId = 0;

		    if (rs.next()) {
		        ownerUserId = rs.getInt(1);
		    }

		    String storeSql = "INSERT INTO bookstores(owner_user_id,store_name,store_phone,city,state,id_document,id_type,id_number,verification_status,status) VALUES(?,?,?,?,?,?,?,?,?,?)";

		    psStore = con.prepareStatement(storeSql);

		    psStore.setInt(1, ownerUserId);
		    psStore.setString(2, seller.getStoreName());
		    psStore.setString(3, seller.getStorePhone());
		    psStore.setString(4, seller.getCity());
		    psStore.setString(5, seller.getState());
		    psStore.setString(6, seller.getIdDocument());
		    psStore.setString(7, seller.getIdType());
		    psStore.setString(8, seller.getIdNumber());
		    psStore.setString(9, "pending");
		    psStore.setString(10, "inactive");

		    int i = psStore.executeUpdate();

		    if (i > 0) {
		        status = true;
		    }

		} catch (Exception e) {
		    e.printStackTrace();
		}

		finally {

		    try {
		        if (rs != null) rs.close();
		        if (psUser != null) psUser.close();
		        if (psStore != null) psStore.close();
		        if (con != null) con.close();
		    } catch (Exception e) {
		        e.printStackTrace();
		    }

		}
		return status;
	}

	@Override
	 public Seller loginSeller(String email, String password) {

        Seller seller = null;

        try {

            DBConnection db = new DBConnection();
            Connection con = db.getConnection();

            String sql = "SELECT * FROM users WHERE email=? AND role_id=2 AND account_status='active'";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, email);
            

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                String dbPassword = rs.getString("password");

                if (BCrypt.checkpw(password, dbPassword)) {

                    seller = new Seller();

                    seller.setOwnerUserId(rs.getInt("user_id"));
                    seller.setName(rs.getString("name"));
                    seller.setEmail(rs.getString("email"));
                    seller.setPhone(rs.getString("phone"));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return seller;
	}

	@Override
	public boolean verifySeller(int storeId) {
		 

		 boolean status = false;

	        try {

	            DBConnection db = new DBConnection();
	            Connection con = db.getConnection();

	            String sql = "UPDATE bookstores SET verification_status='verified', status='active' WHERE store_id=?";

	            PreparedStatement ps = con.prepareStatement(sql);

	            ps.setInt(1, storeId);

	            int i = ps.executeUpdate();

	            if (i > 0) {
	                status = true;
	            }

	        } catch (Exception e) {
	            e.printStackTrace();
	        }

	        return status;
	}

	

}
