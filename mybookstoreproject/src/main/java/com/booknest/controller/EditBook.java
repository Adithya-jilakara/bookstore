package com.booknest.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.booknest.dao.SellerDAO;
import com.booknest.model.Book;

@WebServlet("/EditBook")
public class EditBook extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int bookId = Integer.parseInt(request.getParameter("bookId"));

        SellerDAO dao = new SellerDAO();
        Book book = dao.getBookById(bookId);

        request.setAttribute("book", book);

        RequestDispatcher rd = request.getRequestDispatcher("editBook.jsp");
        rd.forward(request, response);
    }


}
