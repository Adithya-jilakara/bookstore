package com.booknest.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.booknest.dao.UserDAO;
import com.booknest.model.User;

@WebServlet("/RegisterCustomer")
public class RegisterCustomer extends HttpServlet {
	//private static final long serialVersionUID = 1L;
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");

        User user = new User();

        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);
        user.setPhone(phone);
        user.setRole_id(3); // CUSTOMER role id
        user.setAccount_status("ACTIVE");

        UserDAO dao = new UserDAO();

        boolean status = dao.registerUser(user);

        if (status) {

        	response.sendRedirect("registerCustomer.jsp?success=1");

        } else {

            response.sendRedirect("registerCustomer.jsp?error=1");

        }
		
		
		
		
		
		
		
		
		
		
	}

}
