package com.booknest.dao;

import com.booknest.model.User;

public interface DAOInterface {
	
	public boolean registerUser(User user);
	public User loginUser(String email,String password);
	
	
	

}
