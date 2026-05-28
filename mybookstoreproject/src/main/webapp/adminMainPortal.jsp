<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.booknest.model.User"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BookNest Admin Dashboard</title>

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

/* Content Area */
.content {
	margin-left: 240px;
	padding: 20px;
}

/* Top navbar */
.topbar {
	background: white;
	padding: 10px 20px;
	border-bottom: 1px solid #ddd;
}

/* Dashboard cards */
.card {
	border: none;
	border-radius: 10px;
	box-shadow: 0px 2px 8px rgba(0, 0, 0, 0.1);
}

.sidebar {
	height: 100vh;
	width: 240px;
	position: fixed;
	background: #212529;
	padding-top: 20px;
	display: flex;
	flex-direction: column;
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

	<!-- Sidebar -->

	<div class="sidebar d-flex flex-column justify-content-between">

		<!-- TOP -->
		<div>
			<h3>BookNest Admin</h3>

			<a href="#" class="nav-link active"
				onclick="showSection('dashboard', this); return false;">
				Dashboard </a> <a href="#" class="nav-link"
				onclick="showSection('books', this); return false;"> My books </a> <a
				href="#" class="nav-link"
				onclick="showSection('addBook', this); return false;"> Add Book
			</a> <a href="#" class="nav-link"
				onclick="showSection('orders', this); return false;"> Orders </a> <a
				href="#" class="nav-link"
				onclick="showSection('reports', this); return false;"> Reports </a>

			<a href="#" class="nav-link"
				onclick="showSection('profile', this); return false;">  Profile Management</a>
			<a href="LogoutAdmin" class="nav-link text-danger"> <i
				class="fa fa-sign-out-alt"></i> Logout
			</a>
		</div>



	</div>


	<!-- Main Content -->

	<div class="content">

		<!-- Top Navbar -->

		<div class="topbar d-flex justify-content-between">

			<h4>Dashboard</h4>

			<div>
				<i class="fa fa-bell me-3"></i> <i class="fa fa-user-circle"></i>
			</div>

		</div>


		<!-- Dashboard Cards -->
		<div id="dashboardSection">

			<div class="container-fluid mt-4">

				<div class="row">

					<div class="col-md-3">
						<div class="card bg-primary text-white">
							<div class="card-body">
								<h5>Total Sellers</h5>
								<h3><%=request.getAttribute("totalSellers")%></h3>
							</div>
						</div>
					</div>


					<div class="col-md-3">
						<div class="card bg-warning text-white">
							<div class="card-body">
								<h5>Pending Sellers</h5>
								<h3><%=request.getAttribute("pendingSellers")%></h3>
							</div>
						</div>
					</div>


					<div class="col-md-3">
						<div class="card bg-success text-white">
							<div class="card-body">
								<h5>Total Customers</h5>
								<h3><%=request.getAttribute("totalCustomers")%></h3>
							</div>
						</div>
					</div>


					<div class="col-md-3">
						<div class="card bg-danger text-white">
							<div class="card-body">
								<h5>Total Books</h5>
								<h3><%=request.getAttribute("totalBooks")%></h3>
							</div>
						</div>
					</div>
					<!-- BOOKS -->
					<div id="booksSection" style="display: none;">
						<h3>My Books</h3>
						<p>Books data will come here...</p>
					</div>

					<!-- ADD BOOK -->
					<div id="addBookSection" style="display: none;">
						<h3>Add Book</h3>
						<input type="text" placeholder="Book Name"
							class="form-control mb-2">
						<button class="btn btn-primary">Add Book</button>
					</div>

					<!-- ORDERS -->
					<div id="ordersSection" style="display: none;">
						<h3>Orders</h3>
					</div>

					<!-- REPORTS -->
					<div id="reportsSection" style="display: none;">
						<h3>Reports</h3>
					</div>

					<!-- PROFILE -->
					<div id="profileSection" style="display: none;">
						<h3>Profile</h3>
					</div>

				</div>

			</div>
		</div>


		<!-- Example Table -->

		<!-- ================= RECENT SELLERS ================= -->
<div class="container-fluid mt-5">
    <div class="card">
        <div class="card-header bg-dark text-white">Recent Sellers</div>

        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Status</th>
                </tr>
            </thead>

            <tbody>
                <%
                List<User> sellers = (List<User>) request.getAttribute("recentSellers");

                if (sellers != null && !sellers.isEmpty()) {
                    for (User u : sellers) {
                %>
                <tr>
                    <td><%=u.getUser_id()%></td>
                    <td><%=u.getName()%></td>
                    <td><%=u.getEmail()%></td>
                    <td>
                        <%
                        String status = u.getAccount_status();

                        if ("ACTIVE".equalsIgnoreCase(status)) {
                        %>
                            <span class="badge bg-success">ACTIVE</span>
                        <%
                        } else if ("PENDING".equalsIgnoreCase(status)) {
                        %>
                            <span class="badge bg-warning">PENDING</span>
                        <%
                        } else {
                        %>
                            <span class="badge bg-danger">REJECTED</span>
                        <%
                        }
                        %>
                    </td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr>
                    <td colspan="4" class="text-center">No Sellers Found</td>
                </tr>
                <%
                }
                %>
            </tbody>
        </table>
    </div>
</div>


<!-- ================= RECENT CUSTOMERS ================= -->
<div class="container-fluid mt-4">
    <div class="card">
        <div class="card-header bg-dark text-white">Recent Customers</div>

        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Status</th>
                </tr>
            </thead>

            <tbody>
                <%
                List<User> customers = (List<User>) request.getAttribute("recentCustomers");

                if (customers != null && !customers.isEmpty()) {
                    for (User u : customers) {
                %>
                <tr>
                    <td><%=u.getUser_id()%></td>
                    <td><%=u.getName()%></td>
                    <td><%=u.getEmail()%></td>
                    <td>
                        <%
                        String status = u.getAccount_status();

                        if ("ACTIVE".equalsIgnoreCase(status)) {
                        %>
                            <span class="badge bg-success">ACTIVE</span>
                        <%
                        } else if ("PENDING".equalsIgnoreCase(status)) {
                        %>
                            <span class="badge bg-warning">PENDING</span>
                        <%
                        } else {
                        %>
                            <span class="badge bg-danger">REJECTED</span>
                        <%
                        }
                        %>
                    </td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr>
                    <td colspan="4" class="text-center">No Customers Found</td>
                </tr>
                <%
                }
                %>
            </tbody>
        </table>
    </div>
</div>


	<script>
		function showSection(section, element) {

			const sections = [ "dashboard", "books", "addBook", "orders",
					"reports", "profile" ];

			sections.forEach(function(id) {
				let sec = document.getElementById(id + "Section");
				if (sec)
					sec.style.display = "none";
			});

			document.getElementById(section + "Section").style.display = "block";

			document.querySelectorAll(".nav-link").forEach(function(link) {
				link.classList.remove("active");
			});

			element.classList.add("active");
		}
	</script>
</body>
</html>