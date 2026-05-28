package com.booknest.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.booknest.dao.SellerDAO;

@WebServlet("/UpdateBook")
public class UpdateBook extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int bookId = Integer.parseInt(request.getParameter("bookId"));
        String title = request.getParameter("title");
        double price = Double.parseDouble(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        String status = request.getParameter("status");

        SellerDAO dao = new SellerDAO();

        HttpSession session = request.getSession(false);
        int sellerId = (Integer) session.getAttribute("sellerId");

        boolean updated = dao.updateBook(bookId, title, price, stock, status, sellerId);

        if (updated) {
        	response.sendRedirect("SellerDashboard?success=update");
        } else {
            response.sendRedirect("SellerDashboard?error=1");
        }
    }
}
