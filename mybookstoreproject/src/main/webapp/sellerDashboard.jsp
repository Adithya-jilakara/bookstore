<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="com.booknest.model.Book"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BookNest Seller Dashboard</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<style>
body {
	background-color: #f4f6f9;
}

/* Sidebar */
.sidebar {
	height: 100vh;
	width: 240px;
	position: fixed;
	background: #212529;
	padding-top: 20px;
}

.sidebar h3 {
	color: white;
	text-align: center;
	margin-bottom: 30px;
}

.sidebar a {
	display: block;
	color: #ddd;
	padding: 12px 20px;
	text-decoration: none;
	font-size: 16px;
}

.sidebar a:hover {
	background: #0d6efd;
	color: white;
}

/* Content */
.content {
	margin-left: 240px;
	padding: 20px;
}

/* Topbar */
.topbar {
	background: white;
	padding: 10px 20px;
	border-bottom: 1px solid #ddd;
}

/* Cards */
.card {
	border: none;
	border-radius: 10px;
	box-shadow: 0px 2px 8px rgba(0, 0, 0, 0.1);
}

.sidebar a.active {
	background: #0d6efd;
	color: white;
	font-weight: bold;
	border-left: 4px solid #ffffff;
}
</style>

</head>

<body>
	<%
	String success = request.getParameter("success");
	String error = request.getParameter("error");
	%>
	<%
	if ("isbnrequired".equals(error)) {
	%>
	<div class="alert alert-danger">ISBN is required to avoid
		duplicates.</div>
	<%
	}
	%>

	<%
	if (success != null) {
	%>

	<%
	if ("add".equals(success)) {
	%>
	<div class="alert alert-success">Book added successfully!</div>

	<%
	} else if ("update".equals(success)) {
	%>
	<div class="alert alert-success">Book updated successfully!</div>

	<%
	} else if ("delete".equals(success)) {
	%>
	<div class="alert alert-success">Book deleted successfully!</div>
	<%
	}
	%>

	<%
	}
	%>
	<%
	String restoreId = request.getParameter("restoreId");
	%>


	<%
	if (restoreId != null) {
	%>

	<div class="alert alert-warning">
		This book already exists but is inactive.<br> Do you want to
		restore it? <br> <br> <a
			href="RestoreBook?bookId=<%=restoreId%>"
			class="btn btn-success btn-sm"> Restore </a> <a
			href="SellerDashboard" class="btn btn-secondary btn-sm"> Cancel </a>
	</div>

	<%
	}
	%>
	<%
	if ("restored".equals(success)) {
	%>
	<div class="alert alert-success">Book restored successfully!</div>
	<%
	}
	%>

	<%
	Book editBook = (Book) request.getAttribute("editBook");
	%>

	<!-- SIDEBAR -->
	<div class="sidebar">

		<h3>BookNest Seller</h3>

		<a href="SellerDashboard" class="nav-link active"
			onclick="showSection('dashboard');return false;">Dashboard</a> <a
			href="SellerDashboard" class="nav-link"
			onclick="showSection('books');return false;">My Books</a> <a
			href="SellerDashboard" class="nav-link"
			onclick="showSection('addBook');return false;">AddBook</a> <a
			href="SellerDashboard" class="nav-link"
			onclick="showSection('orders');return false;">Orders</a> <a
			href="SellerDashboard" class="nav-link"
			onclick="showSection('reports');return false;">Reports</a> <a
			href="SellerDashboard" class="nav-link"
			onclick="showSection('profile');return false;">Profile</a>
		<!-- LOGOUT AT BOTTOM -->
		<div>
			<a href="LogoutAdmin" class="nav-link text-danger"> <i
				class="fa fa-sign-out-alt"></i> Logout
			</a>
		</div>

	</div>

	<!-- MAIN CONTENT -->
	<div class="content">

		<!-- TOPBAR -->
		<div class="topbar d-flex justify-content-between align-items-center">

			<!-- LEFT: Logo + Title -->
			<div class="d-flex align-items-center">
				<img src="images/bookstorelogo.png" class="me-2"
					style="height: 40px; width: 100px;">
			</div>

			<!-- RIGHT: Icons -->
			<div>
				<i class="fa fa-bell me-3"></i> <i class="fa fa-user-circle"></i>
			</div>

		</div>
		<!-- ================= DASHBOARD ================= -->
		<div id="dashboardSection">



			<div class="container-fluid mt-4">

				<div class="row">

					<div class="col-md-3">
						<div class="card bg-primary text-white">
							<div class="card-body">
								<h5>Total Books</h5>
								<h3>${totalBooks}</h3>
							</div>
						</div>
					</div>

					<div class="col-md-3">
						<div class="card bg-success text-white">
							<div class="card-body">
								<h5>Total Orders</h5>
								<h3>${totalOrders}</h3>
							</div>
						</div>
					</div>

					<div class="col-md-3">
						<div class="card bg-warning text-white">
							<div class="card-body">
								<h5>Pending Orders</h5>
								<h3>${pendingOrders}</h3>
							</div>
						</div>
					</div>

					<div class="col-md-3">
						<div class="card bg-danger text-white">
							<div class="card-body">
								<h5>Revenue</h5>
								<h3>₹ ${totalRevenue}</h3>
							</div>
						</div>
					</div>

				</div>

			</div>

		</div>

		<!-- ================= MY BOOKS ================= -->
		<div id="booksSection" style="display: none;">

			<div class="container-fluid mt-4">

				<div class="card">
					<div class="card-header bg-dark text-white">My Books</div>

					<%
					List<Book> books = (List<Book>) request.getAttribute("bookList");

					int activeCount = 0;
					int inactiveCount = 0;

					if (books != null) {
						for (Book b : books) {
							if ("ACTIVE".equalsIgnoreCase(b.getBookStatus()))  {
						activeCount++;
							} else {
						inactiveCount++;
							}
						}
					}
					%>

					<div class="card-body">

						<!-- ✅ COUNTS (NOW VALID) -->
						<div class="mb-3">
							<span class="badge bg-success">Active: <%=activeCount%></span> <span
								class="badge bg-danger">Inactive: <%=inactiveCount%></span>
						</div>

						<table class="table table-striped">

							<thead>
								<tr>
									<th>ID</th>
									<th>Book Name</th>
									<th>Price</th>
									<th>Status</th>
									<th>Action</th>
								</tr>
							</thead>

							<tbody>

								<%
								if (books != null && !books.isEmpty()) {
									for (Book b : books) {
								%>

								<tr>
									<td><%=b.getBookId()%></td>
									<td><%=b.getTitle()%></td>
									<td><%=b.getPrice()%></td>
									<td><%=b.getBookStatus()%></td>

									<td>
										<%
										if ("ACTIVE".equals(b.getBookStatus())) {
										%>

										<button class="btn btn-warning btn-sm"
											onclick="openEdit(
                                        '<%=b.getBookId()%>',
                                        '<%=b.getTitle()%>',
                                        '<%=b.getAuthor()%>',
                                        '<%=b.getPublisher()%>',
                                        '<%=b.getPrice()%>',
                                        '<%=b.getStockQuantity()%>',
                                        '<%=b.getBookStatus()%>'
                                    )">
											Edit</button>

										<button class="btn btn-danger btn-sm"
											onclick="deleteBook(<%=b.getBookId()%>)">Delete</button> <%
 } else {
 %> <a href="RestoreBook?bookId=<%=b.getBookId()%>"
										class="btn btn-success btn-sm"> Restore </a> <%
 }
 %>
									</td>
								</tr>

								<%
								}
								} else {
								%>

								<tr>
									<td colspan="5" class="text-center text-danger">No books
										added yet</td>
								</tr>

								<%
								}
								%>

							</tbody>

						</table>

					</div>
				</div>

			</div>

		</div>
		<!-- ================= EDIT BOOK ================= -->
		<div id="editBookSection" style="display: none;">
			<div class="container-fluid mt-4">

				<div class="card">
					<div class="card-header bg-warning text-white">Edit Book
						Details</div>

					<div class="card-body">

						<form action="UpdateBook" method="post"
							enctype="multipart/form-data">

							<input type="hidden" id="edit_bookId" name="bookId"
								value="<%=(editBook != null) ? editBook.getBookId() : ""%>">

							<!-- Title -->
							<div class="mb-3">
								<label class="form-label">Title</label> <input type="text"
									id="edit_title" name="title" class="form-control"
									value="<%=(editBook != null) ? editBook.getTitle() : ""%>">
							</div>

							<!-- Author & ISBN -->
							<div class="row">
								<div class="col-md-6 mb-3">
									<label class="form-label">Author</label> <input type="text"
										id="edit_author" name="author" class="form-control"
										value="<%=(editBook != null && editBook.getAuthor() != null) ? editBook.getAuthor() : ""%>">
								</div>

								<div class="col-md-6 mb-3">
									<label class="form-label">ISBN</label> <input type="text"
										id="edit_isbn" name="isbn" class="form-control"
										value="<%=(editBook != null && editBook.getIsbn() != null) ? editBook.getIsbn() : ""%>">
								</div>
							</div>

							<!-- Publisher & Year -->
							<div class="row">
								<div class="col-md-6 mb-3">
									<label class="form-label">Publisher</label> <input type="text"
										id="edit_publisher" name="publisher" class="form-control"
										value="<%=(editBook != null && editBook.getPublisher() != null) ? editBook.getPublisher() : ""%>">
								</div>

								<div class="col-md-6 mb-3">
									<label class="form-label">Year</label> <input type="number"
										id="edit_year" name="year" class="form-control"
										value="<%=(editBook != null) ? editBook.getPublicationYear() : ""%>">
								</div>
							</div>

							<!-- Price & Stock -->
							<div class="row">
								<div class="col-md-6 mb-3">
									<label class="form-label">Price</label> <input type="number"
										id="edit_price" name="price" class="form-control"
										value="<%=(editBook != null) ? editBook.getPrice() : ""%>">
								</div>

								<div class="col-md-6 mb-3">
									<label class="form-label">Stock</label> <input type="number"
										id="edit_stock" name="stock" class="form-control"
										value="<%=(editBook != null) ? editBook.getStockQuantity() : ""%>">
								</div>
							</div>

							<!-- Category -->
							<div class="mb-3">
								<label class="form-label">Category</label> <select
									id="edit_category" name="category_id" class="form-control">
									<option value="1">Programming</option>
									<option value="2">Fiction</option>
								</select>
							</div>

							<!-- Description -->
							<div class="mb-3">
								<label class="form-label">Description</label>
								<textarea name="description" class="form-control">
<%=(editBook != null && editBook.getDescription() != null) ? editBook.getDescription() : ""%>
    </textarea>
							</div>

							<!-- Image -->
							<div class="mb-3">
								<label class="form-label">Image</label> <input type="file"
									name="image" class="form-control">
							</div>

							<!-- Status -->
							<div class="mb-3">
								<label class="form-label">Status</label> <select
									id="edit_status" name="status" class="form-control">
									<option value="ACTIVE"
										<%=(editBook != null && "ACTIVE".equals(editBook.getBookStatus())) ? "selected" : ""%>>
										ACTIVE</option>

									<option value="INACTIVE"
										<%=(editBook != null && "INACTIVE".equals(editBook.getBookStatus())) ? "selected" : ""%>>
										INACTIVE</option>
								</select>
							</div>

							<button class="btn btn-success w-100">Update Book</button>

						</form>
					</div>
				</div>

			</div>
		</div>
		<!-- ================= ADD BOOK ================= -->
		<div id="addBookSection" style="display: none;">

			<div class="container-fluid mt-4">

				<div class="card">
					<div class="card-header bg-primary text-white">Add New Book</div>

					<div class="card-body">

						<form action="AddBook" method="post" enctype="multipart/form-data">

							<input type="text" name="title" class="form-control mb-3"
								placeholder="Book Title" required> <input type="text"
								name="author" class="form-control mb-3"
								placeholder="Author Name" required> <input type="text"
								name="isbn" class="form-control mb-3" placeholder="ISBN Number"><input
								type="text" name="publisher" class="form-control mb-3"
								placeholder="Publisher Name" required><input
								type="number" name="year" class="form-control mb-3"
								placeholder="Publication Year"> <input type="number"
								name="price" class="form-control mb-3" placeholder="Price"
								required> <select name="category_id"
								class="form-control mb-3">

								<option value="">Select Category</option>
								<option value="1">Programming</option>
								<option value="2">Fiction</option>
								<option value="3">Science</option>
								<option value="4">History</option>
								<option value="5">autobiography</option>
								<option value="6">biography</option>
								<option value="7">non-fiction</option>
								<option value="8">philosophy</option>
								<option value="9">mythology</option>




							</select>

							<textarea name="description" class="form-control mb-3"
								placeholder="Description"></textarea>

							<input type="file" name="image" class="form-control mb-3">

							<button class="btn btn-success w-100">Add Book</button>

						</form>

					</div>
				</div>

			</div>

		</div>

		<!-- ================= ORDERS ================= -->
		<div id="ordersSection" style="display: none;">

			<div class="container-fluid mt-4">

				<div class="card">
					<div class="card-header bg-dark text-white">Orders</div>

					<div class="card-body">

						<table class="table table-bordered">

							<thead>
								<tr>
									<th>Order ID</th>
									<th>Book</th>
									<th>Customer</th>
									<th>Status</th>
								</tr>
							</thead>

							<tbody>

								<tr>
									<td>O101</td>
									<td>Java Basics</td>
									<td>Rahul</td>
									<td><span class="badge bg-warning">Pending</span></td>
								</tr>

								<tr>
									<td>O102</td>
									<td>Spring Boot</td>
									<td>Ankit</td>
									<td><span class="badge bg-success">Delivered</span></td>
								</tr>

							</tbody>

						</table>

					</div>
				</div>

			</div>

		</div>

		<!-- ================= REPORTS ================= -->
		<div id="reportsSection" style="display: none;">

			<div class="container-fluid mt-4">

				<div class="card">
					<div class="card-header bg-dark text-white">Reports</div>

					<div class="card-body">

						<p>Sales analytics and reports will come here...</p>

					</div>
				</div>

			</div>

		</div>

		<!-- ================= PROFILE ================= -->
		<div id="profileSection" style="display: none;">

			<div class="container-fluid mt-4">

				<div class="card">
					<div class="card-header bg-dark text-white">Profile</div>

					<div class="card-body">

						<p>Name: Seller Name</p>
						<p>Email: seller@gmail.com</p>

						<button class="btn btn-primary">Edit Profile</button>

					</div>
				</div>

			</div>

		</div>

	</div>
	<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	%>

	<!-- JS -->
	<script>
		function showSection(section) {

			// hide all sections
			const sections = [ "dashboard", "books", "addBook", "orders",
        "reports", "profile", "editBook" ];
			sections.forEach(function(id) {
				document.getElementById(id + "Section").style.display = "none";
			});

			// show selected section
			document.getElementById(section + "Section").style.display = "block";

			// REMOVE active from all nav links
			const links = document.querySelectorAll(".nav-link");
			links.forEach(function(link) {
				link.classList.remove("active");
			});

			// ADD active to clicked link
			event.target.classList.add("active");
		}
		function openEdit(id, title, author, publisher, price, stock, status) {

		    // First show books section
		    showSection("books");

		    // Then show edit section
		    document.getElementById("editBookSection").style.display = "block";

		    // Fill data
		    document.getElementById("edit_bookId").value = id;
		    document.getElementById("edit_title").value = title;
		    document.getElementById("edit_author").value = author;
		    document.getElementById("edit_publisher").value = publisher;
		    document.getElementById("edit_price").value = price;
		    document.getElementById("edit_stock").value = stock;
		    document.getElementById("edit_status").value = status;
		}
		function deleteBook(bookId) {

		    if (confirm("Are you sure?")) {
		        window.location.href = "DeleteBook?bookId=" + bookId;
		    }
		}
		function editBook(bookId) {
		    window.location.href = "SellerDashboard?editId=" + bookId;
		}
		 window.onload = function () {

		        const urlParams = new URLSearchParams(window.location.search);

		        if (urlParams.get("success") === "restored") {
		            showSection("books"); // 👈 auto open My Books
		        }
		    }
	</script>
</body>
</html>