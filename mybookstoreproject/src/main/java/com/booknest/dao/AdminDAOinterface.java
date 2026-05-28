package com.booknest.dao;

import java.util.List;

import com.booknest.model.User;

public interface AdminDAOinterface {
	
	public int getTotalSellers();
	public int getTotalBooks();
	public int getTotalCustomers();
	public int getPendingSellers();
	public List<User> getRecentSellers();
	public List<User> getRecentCustomers();
	
	
	

}
