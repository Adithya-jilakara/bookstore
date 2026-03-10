package com.booknest.controller;
import org.mindrot.jbcrypt.BCrypt;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;

import com.booknest.dao.SellerDAO;
import com.booknest.model.Seller;

@WebServlet("/sellerRegister")
@MultipartConfig
public class SellerRegister extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
        String phone = request.getParameter("phone");

        String storeName = request.getParameter("storeName");
        String storePhone = request.getParameter("storePhone");
        String city = request.getParameter("city");
        String state = request.getParameter("state");

        String idType = request.getParameter("idType");
        String idNumber = request.getParameter("idNumber");

        Part filePart = request.getPart("idDocument");
        String fileName = filePart.getSubmittedFileName();

        String uploadPath = getServletContext().getRealPath("") + "uploads";

        File uploadDir = new File(uploadPath);

        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        filePart.write(uploadPath + File.separator + fileName);

        String filePath = "uploads/" + fileName;

        Seller seller = new Seller();

        seller.setName(name);
        seller.setEmail(email);
        seller.setPassword(hashedPassword);
        seller.setPhone(phone);

        seller.setStoreName(storeName);
        seller.setStorePhone(storePhone);
        seller.setCity(city);
        seller.setState(state);

        seller.setIdType(idType);
        seller.setIdNumber(idNumber);
        seller.setIdDocument(filePath);

        SellerDAO dao = new SellerDAO();

        boolean status = dao.registerSeller(seller);

        if (status) {
            response.sendRedirect("sellerRegistrationSuccess.jsp");
        }
	}

}
