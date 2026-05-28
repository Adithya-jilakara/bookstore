package com.booknest.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import com.booknest.dao.SellerDAO;
import com.booknest.model.Book;

@WebServlet("/SellerDashboard")
public class SellerDashboard extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
	        throws ServletException, IOException {

	    HttpSession session = request.getSession(false);

	    if (session == null) {
	        response.sendRedirect("loginCustomer.jsp");
	        return;
	    }

	    Integer sellerId = (Integer) session.getAttribute("sellerId");

	    if (sellerId == null) {
	        response.sendRedirect("loginCustomer.jsp");
	        return;
	    }

	    SellerDAO dao = new SellerDAO();

	    int totalBooks = dao.getTotalBooks(sellerId);
	    int totalOrders = dao.getTotalOrders(sellerId);
	    int pendingOrders = dao.getPendingOrders(sellerId);
	    double totalRevenue = dao.getTotalRevenue(sellerId);
	    List<Book> books = dao.getSellerBooks(sellerId);
	    request.setAttribute("bookList", books);
	    request.setAttribute("totalBooks", totalBooks);
	    request.setAttribute("totalOrders", totalOrders);
	    request.setAttribute("pendingOrders", pendingOrders);
	    request.setAttribute("totalRevenue", totalRevenue);
	    String editId = request.getParameter("editId");

	    if (editId != null) {
	        int bookId = Integer.parseInt(editId);
	        Book editBook = dao.getBookById(bookId);

	        request.setAttribute("editBook", editBook);
	    }

	    RequestDispatcher rd = request.getRequestDispatcher("sellerDashboard.jsp");
	    rd.forward(request, response);
	}

}
