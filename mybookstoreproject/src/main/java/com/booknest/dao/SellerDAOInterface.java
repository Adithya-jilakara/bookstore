package com.booknest.dao;

import com.booknest.model.Seller;

public interface SellerDAOInterface {
	 boolean registerSeller(Seller seller);

	 public Seller loginSeller(String email,String password);

	 public boolean verifySeller(int storeId);

}
