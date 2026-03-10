package com.booknest.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.booknest.dao.SellerDAO;
import com.booknest.model.Seller;


@WebServlet("/sellerLogin")
public class SellerLogin extends HttpServlet {
	//private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		 String email = request.getParameter("email");
	        String password = request.getParameter("password");

	        SellerDAO dao = new SellerDAO();

	        Seller seller = dao.loginSeller(email, password);

	        if (seller != null) {

	            HttpSession session = request.getSession();

	            session.setAttribute("seller", seller);

	            response.sendRedirect("sellerHome.jsp");

	        } else {

	        	request.setAttribute("status", "failed");
	        	request.getRequestDispatcher("verificationResult.jsp").forward(request,response);

	        }
	}

}
