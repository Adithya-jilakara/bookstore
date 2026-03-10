package com.booknest.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.booknest.dao.SellerDAO;
import com.booknest.utility.DBConnection;

@WebServlet("/verifySeller")
public class VerifySeller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		 int storeId = Integer.parseInt(request.getParameter("storeId"));

	        SellerDAO dao = new SellerDAO();

	        boolean status = dao.verifySeller(storeId);

	        if (status) {
	            response.sendRedirect("sellerRegistrationSuccess.jsp");
	        }
	}
}
