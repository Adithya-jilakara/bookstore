package com.booknest.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;

import java.io.IOException;

import com.booknest.dao.SellerDAO;
import com.booknest.model.Book;

@WebServlet("/AddBook")
@MultipartConfig
public class AddBook extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    	HttpSession session = request.getSession();

    	Object obj = session.getAttribute("sellerId");

    	System.out.println("SESSION sellerId = " + obj);
        Integer sellerIdObj = (Integer) session.getAttribute("sellerId");

        if (sellerIdObj == null) {
        	 System.out.println("Session lost ❌");
            response.sendRedirect("loginCustomer.jsp");
            return;
        }

        int sellerId = sellerIdObj;

        // get form data
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String isbn = request.getParameter("isbn");
        String publisher = request.getParameter("publisher");
        int publication_year = Integer.parseInt(request.getParameter("year"));
        int price = Integer.parseInt(request.getParameter("price"));
        int categoryId = Integer.parseInt(request.getParameter("category_id"));
        String description = request.getParameter("description");

        // image upload
        Part file = request.getPart("image");
        String fileName = file.getSubmittedFileName();

        // safe upload path
        String uploadPath = request.getServletContext().getRealPath("/images");

        // create folder if not exists
        java.io.File dir = new java.io.File(uploadPath);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        // save file
        file.write(uploadPath + java.io.File.separator + fileName);

        // store relative path in DB
        String imagePath = "images/" + fileName;
        if (isbn == null || isbn.trim().isEmpty()) {
            response.sendRedirect("SellerDashboard?error=isbnrequired");
            return;
        }

        SellerDAO dao = new SellerDAO();
        Book existing = dao.checkExistingBook(isbn, sellerId);

        if (existing != null) {

            if ("ACTIVE".equals(existing.getBookStatus())) {
                // already active
                response.sendRedirect("SellerDashboard?error=exists");
                return;

            } else if ("INACTIVE".equals(existing.getBookStatus())) {
                // exists but inactive → ask restore
            	response.sendRedirect("SellerDashboard?restoreId=" + existing.getBookId());
                return;
            }
        }

        // step-by-step DB operations
        int authorId = dao.getOrCreateAuthor(author);
        int publisherId = dao.getOrCreatePublisher(publisher);

        int bookId = dao.addBook(title,isbn, description, price,
                categoryId, publisherId,publication_year, sellerId, imagePath);

        dao.addBookAuthor(bookId, authorId);

        // redirect after success

        if (bookId > 0) {
        	response.sendRedirect("SellerDashboard?success=add");
        } else {
            response.sendRedirect("SellerDashboard?error=1");
        }

    }
}
