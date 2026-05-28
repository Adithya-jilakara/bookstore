package com.booknest.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.mindrot.jbcrypt.BCrypt;

import com.booknest.model.Book;
import com.booknest.model.Seller;
import com.booknest.utility.DBConnection;

public class SellerDAO implements SellerDAOInterface {
	Connection con = null;

	@Override
	public boolean registerSeller(Seller seller) {

	    PreparedStatement ps = null;
	    ResultSet rs = null;
	    boolean status = false;

	    try {

	        Connection con = DBConnection.getConnection();

	        // ✅ Check if email already exists
	        String checkEmail = "SELECT * FROM users WHERE email=?";
	        ps = con.prepareStatement(checkEmail);
	        ps.setString(1, seller.getEmail());

	        rs = ps.executeQuery();

	        if (rs.next()) {
	            return false; // email already exists
	        }

	        // ✅ Hash password (IMPORTANT)
	        String hashedPassword = BCrypt.hashpw(seller.getPassword(), BCrypt.gensalt());

	        // ✅ Insert seller into users table
	        String sql = "INSERT INTO users(name,email,password,phone,role_id,account_status) VALUES(?,?,?,?,?,?)";

	        ps = con.prepareStatement(sql);

	        ps.setString(1, seller.getName());
	        ps.setString(2, seller.getEmail());
	        ps.setString(3, hashedPassword);
	        ps.setString(4, seller.getPhone());
	        ps.setInt(5, 2); // role_id = seller
	        ps.setString(6, "pending"); // waiting for admin approval

	        int i = ps.executeUpdate();

	        if (i > 0) {
	            status = true;
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
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
	public boolean verifySeller(int userId) {

	    boolean status = false;

	    try {
	        Connection con = DBConnection.getConnection();

	        String sql = "UPDATE users SET account_status='active' WHERE user_id=? AND role_id=2";

	        PreparedStatement ps = con.prepareStatement(sql);
	        ps.setInt(1, userId);

	        int i = ps.executeUpdate();

	        if (i > 0) {
	            status = true;
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return status;
	}

	@Override
	public int getTotalBooks(int sellerId) {

	    int count = 0;

	    try {
	        Connection con = DBConnection.getConnection();

	        int storeId = getStoreIdBySellerId(sellerId);

	        String sql = "SELECT COUNT(*) FROM store_books sb " +
	                     "JOIN books b ON sb.book_id = b.book_id " +
	                     "WHERE b.seller_id=? AND sb.store_id=? AND sb.book_status='ACTIVE'";

	        PreparedStatement ps = con.prepareStatement(sql);
	        ps.setInt(1, sellerId);
	        ps.setInt(2, storeId);

	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
	            count = rs.getInt(1);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return count;
	}

	@Override
	public double getTotalRevenue(int sellerId) {
		double total = 0;

		try {
			DBConnection db = new DBConnection();
			Connection con = db.getConnection();

			String sql = "SELECT SUM(oi.price * oi.quantity) " + "FROM order_items oi "
					+ "JOIN store_books sb ON oi.store_book_id = sb.store_book_id "
					+ "JOIN books b ON sb.book_id = b.book_id " + "WHERE b.seller_id = ?";

			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, sellerId);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				total = rs.getDouble(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return total;
	}

	@Override
	public int getPendingOrders(int sellerId) {
		int count = 0;

		try {
			DBConnection db = new DBConnection();
			Connection con = db.getConnection();

			String sql = "SELECT COUNT(DISTINCT o.order_id) " + "FROM orders o "
					+ "JOIN order_items oi ON o.order_id = oi.order_id "
					+ "JOIN store_books sb ON oi.store_book_id = sb.store_book_id "
					+ "JOIN books b ON sb.book_id = b.book_id "
					+ "WHERE b.seller_id = ? AND o.order_status = 'PENDING'";

			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, sellerId);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				count = rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return count;
	}

	@Override
	public int getTotalOrders(int sellerId) {
		int count = 0;

		try {
			Connection con = DBConnection.getConnection();

			String sql = "SELECT COUNT(DISTINCT o.order_id) " + "FROM orders o "
					+ "JOIN order_items oi ON o.order_id = oi.order_id "
					+ "JOIN store_books sb ON oi.store_book_id = sb.store_book_id "
					+ "JOIN books b ON sb.book_id = b.book_id " + "WHERE b.seller_id = ?";
			PreparedStatement ps = con.prepareStatement(sql);

			ps.setInt(1, sellerId);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				count = rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return count;
	}

	@Override
	public int getOrCreateAuthor(String name) {
		int id = 0;
		try {
			Connection con = DBConnection.getConnection();

			String check = "SELECT author_id FROM authors WHERE author_name=?";
			PreparedStatement ps = con.prepareStatement(check);
			ps.setString(1, name);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				id = rs.getInt(1);
			} else {
				String insert = "INSERT INTO authors(author_name) VALUES(?)";
				PreparedStatement ps2 = con.prepareStatement(insert, Statement.RETURN_GENERATED_KEYS);
				ps2.setString(1, name);
				ps2.executeUpdate();

				ResultSet rs2 = ps2.getGeneratedKeys();
				if (rs2.next())
					id = rs2.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return id;
	}

	@Override
	public int getOrCreatePublisher(String name) {
		int id = 0;
		try {
			Connection con = DBConnection.getConnection();

			String check = "SELECT publisher_id FROM publishers WHERE publisher_name=?";
			PreparedStatement ps = con.prepareStatement(check);
			ps.setString(1, name);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				id = rs.getInt(1);
			} else {
				String insert = "INSERT INTO publishers(publisher_name) VALUES(?)";
				PreparedStatement ps2 = con.prepareStatement(insert, Statement.RETURN_GENERATED_KEYS);
				ps2.setString(1, name);
				ps2.executeUpdate();

				ResultSet rs2 = ps2.getGeneratedKeys();
				if (rs2.next())
					id = rs2.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return id;
	}

	@Override
	public void addBookAuthor(int bookId, int authorId) {
		try {
			Connection con = DBConnection.getConnection();

			String sql = "INSERT INTO book_authors(book_id, author_id) VALUES(?,?)";

			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, bookId);
			ps.setInt(2, authorId);

			ps.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public int addBook(String title, String isbn, String description, int price, int categoryId, int publisherId,
			int publication_year, int sellerId, String imagePath) {

		int bookId = 0;
		Connection con = null;

		try {
			con = DBConnection.getConnection();
			con.setAutoCommit(false);

			String sql = "INSERT INTO books(title,isbn,description,category_id,publisher_id,publication_year,seller_id,image_path) "
					+ "VALUES(?,?,?,?,?,?,?,?)";

			PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

			ps.setString(1, title);
			ps.setString(2, isbn);
			ps.setString(3, description);
			ps.setInt(4, categoryId);
			ps.setInt(5, publisherId);
			ps.setInt(6, publication_year);
			ps.setInt(7, sellerId);
			ps.setString(8, imagePath);

			int rows = ps.executeUpdate();

			if (rows == 0) {
				con.rollback();
				return 0;
			}

			ResultSet rs = ps.getGeneratedKeys();
			if (rs.next()) {
				bookId = rs.getInt(1);
			}

			if (bookId > 0) {

				int storeId = getStoreIdBySellerId(sellerId);
				String storeSql = "INSERT INTO store_books(store_id, book_id, price, stock_quantity, book_status) VALUES(?,?,?,?,?)";

				PreparedStatement ps2 = con.prepareStatement(storeSql);

				ps2.setInt(1, storeId);
				ps2.setInt(2, bookId);
				ps2.setDouble(3, price);
				ps2.setInt(4, 10);
				ps2.setString(5, "ACTIVE");

				ps2.executeUpdate();
			}

			con.commit();

		} catch (Exception e) {
			e.printStackTrace();
			try {
				if (con != null)
					con.rollback();
			} catch (Exception ex) {
				ex.printStackTrace();
			}
			return 0;
		}

		return bookId;
	}

	@Override
	public int getStoreIdBySellerId(int sellerId) {

	    int storeId = 0;

	    try {
	        Connection con = DBConnection.getConnection();

	        String sql = "SELECT sb.store_id FROM store_books sb " +
	                     "JOIN books b ON sb.book_id = b.book_id " +
	                     "WHERE b.seller_id=? LIMIT 1";

	        PreparedStatement ps = con.prepareStatement(sql);
	        ps.setInt(1, sellerId);

	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
	            storeId = rs.getInt("store_id");
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return storeId;
	}

	@Override
	public List<Book> getSellerBooks(int sellerId) {

	    List<Book> list = new ArrayList<>();

	    try {
	        Connection con = DBConnection.getConnection();

	        String sql = "SELECT b.book_id, b.title, sb.price, sb.stock_quantity, sb.book_status " +
	                "FROM books b " +
	                "JOIN store_books sb ON b.book_id = sb.book_id " +
	                "WHERE b.seller_id=?";

	       

	        PreparedStatement ps = con.prepareStatement(sql);
	        ps.setInt(1, sellerId);

	        ResultSet rs = ps.executeQuery();

	        while (rs.next()) {
	            Book b = new Book();

	            b.setBookId(rs.getInt("book_id"));
	            b.setTitle(rs.getString("title"));
	            b.setPrice(rs.getDouble("price"));
	            b.setStockQuantity(rs.getInt("stock_quantity"));

	            String status = rs.getString("book_status");
	            if (status == null) {
	                status = "INACTIVE";
	            }

	            b.setBookStatus(status);

	            list.add(b);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return list;
	}

	@Override
	public Book getBookById(int bookId) {

		Book b = null;

		try {
			Connection con = DBConnection.getConnection();

			String sql = "SELECT b.*, sb.price, sb.stock_quantity, sb.book_status, " +
		             "a.author_name, p.publisher_name " +
		             "FROM books b " +
		             "LEFT JOIN store_books sb ON b.book_id = sb.book_id " +
		             "JOIN book_authors ba ON b.book_id = ba.book_id "+
		             "JOIN authors a ON ba.author_id = a.author_id " +
		             "JOIN publishers p ON b.publisher_id = p.publisher_id " +
		             "WHERE b.book_id=?";

			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, bookId);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				b = new Book();

				b.setBookId(rs.getInt("book_id"));
				b.setTitle(rs.getString("title"));
				b.setIsbn(rs.getString("isbn"));
				b.setAuthor(rs.getString("author_name"));
				b.setPublisher(rs.getString("publisher_name"));
				b.setDescription(rs.getString("description"));
				b.setCategoryId(rs.getInt("category_id"));
				b.setPublisherId(rs.getInt("publisher_id"));
				b.setPublicationYear(rs.getInt("publication_year"));
				b.setSellerId(rs.getInt("seller_id"));
				b.setImagePath(rs.getString("image_path"));

				b.setPrice(rs.getDouble("price"));
				b.setStockQuantity(rs.getInt("stock_quantity"));
				b.setBookStatus(rs.getString("book_status"));
				
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return b;
	}

	public boolean updateBook(int bookId, String title, double price, int stock, String status, int sellerId) {

	    boolean updated = false;

	    try {
	        Connection con = DBConnection.getConnection();

	        // update books
	        String sql1 = "UPDATE books SET title=? WHERE book_id=?";
	        PreparedStatement ps1 = con.prepareStatement(sql1);
	        ps1.setString(1, title);
	        ps1.setInt(2, bookId);
	        ps1.executeUpdate();

	        // ✅ FIX HERE
	        int storeId = getStoreIdBySellerId(sellerId);

	        String sql2 = "UPDATE store_books SET price=?, stock_quantity=?, book_status=? WHERE book_id=? AND store_id=?";
	        PreparedStatement ps2 = con.prepareStatement(sql2);

	        ps2.setDouble(1, price);
	        ps2.setInt(2, stock);
	        ps2.setString(3, status);
	        ps2.setInt(4, bookId);
	        ps2.setInt(5, storeId);

	        int i = ps2.executeUpdate();

	        if (i > 0) {
	            updated = true;
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return updated;
	}
	@Override
	public void deleteBook(int bookId, int sellerId) {

	    try {
	        Connection con = DBConnection.getConnection();

	        int storeId = getStoreIdBySellerId(sellerId);

	        String sql = "UPDATE store_books SET book_status='INACTIVE' WHERE book_id=? AND store_id=?";
	        PreparedStatement ps = con.prepareStatement(sql);

	        ps.setInt(1, bookId);
	        ps.setInt(2, storeId);

	        ps.executeUpdate();

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}

	@Override
	public Book checkExistingBook(String isbn, int sellerId) {

	    Book b = null;

	    try {
	        Connection con = DBConnection.getConnection();

	        String sql = "SELECT b.book_id, b.title, sb.book_status " +
	                     "FROM books b JOIN store_books sb ON b.book_id=sb.book_id " +
	                     "WHERE b.isbn=? AND b.seller_id=?";

	        PreparedStatement ps = con.prepareStatement(sql);
	        ps.setString(1, isbn);
	        ps.setInt(2, sellerId);

	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
	            b = new Book();
	            b.setBookId(rs.getInt("book_id"));
	            b.setTitle(rs.getString("title"));
	            b.setBookStatus(rs.getString("book_status"));
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return b;
	}

	@Override
	public void restoreBook(int bookId, int sellerId) {

	    try {
	        Connection con = DBConnection.getConnection();

	        int storeId = getStoreIdBySellerId(sellerId);

	     // check
	     String checkSql = "SELECT * FROM store_books WHERE book_id=? AND store_id=?";
	     PreparedStatement checkPs = con.prepareStatement(checkSql);
	     checkPs.setInt(1, bookId);
	     checkPs.setInt(2, storeId);

	     ResultSet rs = checkPs.executeQuery();

	     if (rs.next()) {

	         String updateSql = "UPDATE store_books SET book_status='ACTIVE' WHERE book_id=? AND store_id=?";
	         PreparedStatement ps = con.prepareStatement(updateSql);

	         ps.setInt(1, bookId);
	         ps.setInt(2, storeId);

	         ps.executeUpdate();

	     } else {

	         String insertSql = "INSERT INTO store_books(store_id, book_id, price, stock_quantity, book_status) VALUES(?,?,?,?,?)";
	         PreparedStatement ps = con.prepareStatement(insertSql);

	         ps.setInt(1, storeId);
	         ps.setInt(2, bookId);
	         ps.setDouble(3, 0);
	         ps.setInt(4, 0);
	         ps.setString(5, "ACTIVE");

	         ps.executeUpdate();
	     }
	        

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}
	
	
}
