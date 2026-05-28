package com.booknest.controller;

import java.io.IOException;
import java.sql.ResultSet;
import java.util.List;

import com.booknest.dao.AdminDAO;
import com.booknest.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@WebServlet("/AdminDashboard")
public class AdminDashboard extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        AdminDAO dao = new AdminDAO();

        request.setAttribute("totalSellers", dao.getTotalSellers());
        request.setAttribute("pendingSellers", dao.getPendingSellers());
        request.setAttribute("totalCustomers", dao.getTotalCustomers());
        request.setAttribute("totalBooks", dao.getTotalBooks());
        // Seller list
        List<User> sellers = dao.getRecentSellers();
        request.setAttribute("recentSellers", sellers);
        //customer list
        List<User> customers = dao.getRecentCustomers();
        request.setAttribute("recentCustomers", customers);
        // Forward to JSP
        request.getRequestDispatcher("adminMainPortal.jsp")
               .forward(request, response);
    }

}
