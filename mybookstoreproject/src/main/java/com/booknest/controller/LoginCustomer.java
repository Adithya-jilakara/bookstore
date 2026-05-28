package com.booknest.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.booknest.dao.UserDAO;
import com.booknest.model.User;

@WebServlet("/LoginCustomer")
public class LoginCustomer extends HttpServlet {
	//private static final long serialVersionUID = 1L;

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 String email = request.getParameter("email");
	        String password = request.getParameter("password");

	        UserDAO dao = new UserDAO();

	        User user = dao.loginUser(email, password);

if(user == null){
    System.out.println("User is NULL ❌");
}else{
    System.out.println("User FOUND ✅");
    System.out.println("Role: " + user.getRole_id());
    System.out.println("Status: " + user.getAccount_status());
}

	        if (user != null && user.getAccount_status().trim().equalsIgnoreCase("ACTIVE")) {
	        	
	        	int role_id=user.getRole_id();
	        	
	        	if(role_id==1) {
	        		HttpSession session = request.getSession();

		            session.setAttribute("user", user);

		            response.sendRedirect("AdminDashboard");
	        		
	        	}
	        	else if(role_id==2) {
	        		HttpSession session = request.getSession();
	        		session.setAttribute("sellerId", Integer.valueOf(user.getUser_id()));
	        		session.setMaxInactiveInterval(30 * 60); // 30 min session
		            session.setAttribute("user", user);

		            response.sendRedirect("SellerDashboard");
	        	}
	        	else if(role_id==3) {
	        		HttpSession session = request.getSession();

		            session.setAttribute("user", user);

		            response.sendRedirect("index.jsp");
	        	}
	            

	        } 
	        else {

	            response.sendRedirect("loginCustomer.jsp?error=1");

	        }
	}

}
