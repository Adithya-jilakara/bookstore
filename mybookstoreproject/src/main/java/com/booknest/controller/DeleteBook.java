package com.booknest.controller;

import java.io.IOException;

import com.booknest.dao.SellerDAO;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/DeleteBook")
public class DeleteBook extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int bookId = Integer.parseInt(request.getParameter("bookId"));

        SellerDAO dao = new SellerDAO();
        HttpSession session = request.getSession(false);
        int sellerId = (Integer) session.getAttribute("sellerId");

        dao.deleteBook(bookId, sellerId);

        response.sendRedirect("SellerDashboard?success=delete");
    }
}


