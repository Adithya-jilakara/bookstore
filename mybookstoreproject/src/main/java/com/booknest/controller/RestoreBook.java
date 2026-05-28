package com.booknest.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.booknest.dao.SellerDAO;

@WebServlet("/RestoreBook")
public class RestoreBook extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    int bookId = Integer.parseInt(request.getParameter("bookId"));

	    // ✅ GET SESSION
	    HttpSession session = request.getSession(false);

	    if (session == null) {
	        response.sendRedirect("loginCustomer.jsp");
	        return;
	    }

	    // ✅ GET sellerId FROM SESSION
	    Integer sellerId = (Integer) session.getAttribute("sellerId");

	    if (sellerId == null) {
	        response.sendRedirect("loginCustomer.jsp");
	        return;
	    }

	    // ✅ NOW sellerId EXISTS → no error
	    SellerDAO dao = new SellerDAO();
	    dao.restoreBook(bookId, sellerId);

	    response.sendRedirect("SellerDashboard?success=restored&ts=" + System.currentTimeMillis());
	}

}
