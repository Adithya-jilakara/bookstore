package com.booknest.dao;

import java.util.List;

import com.booknest.model.Book;
import com.booknest.model.Seller;

public interface SellerDAOInterface {
	 boolean registerSeller(Seller seller);

	 public Seller loginSeller(String email,String password);

	 public boolean verifySeller(int storeId);
	 public int getStoreIdBySellerId(int sellerId);
	 
	 public int getTotalBooks(int sellerId);
	 public int getTotalOrders(int sellerId);
	 public double getTotalRevenue(int sellerId);
	 public int getPendingOrders(int sellerId);
	 public int getOrCreateAuthor(String name);
	 public int getOrCreatePublisher(String name);
	 public void addBookAuthor(int bookId, int authorId);
	 public int addBook(String title,String isbn, String description, int price,int categoryId, int publisherId,int publication_year, int sellerId, String imagePath);
	 public List<Book> getSellerBooks(int sellerId);
	 public Book getBookById(int bookId);
	 public boolean updateBook(int bookId, String title, double price, int stock, String status, int sellerId);
	 public void deleteBook(int bookId, int sellerId);
	 public Book checkExistingBook(String isbn, int sellerId);
	 public void restoreBook(int bookId,int sellerId);

		   

}
