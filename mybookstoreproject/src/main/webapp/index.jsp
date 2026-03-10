<%@ page import="com.booknest.model.User"%>
<%
User user = (User) session.getAttribute("user");
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>BookNest - Your Home for Every Book</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
body {
	background: #e6e6e6;
	font-family: 'Segoe UI', sans-serif;
}

/* NAVBAR */
.navbar {
	background: #ffffff;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
	padding-top: 5px;
	padding-bottom: 5px;
}

/* LOGO */
.navbar-brand {
	margin-right: 30px;
}

.navbar-brand img {
	height: 55px;
	width: auto;
	object-fit: contain;
}

/* CATEGORY MENU */
.navbar-nav .nav-item {
	margin-right: 18px;
}

.nav-link {
	font-weight: 600;
	font-size: 14px;
	color: #222 !important;
}

.nav-link:hover {
	color: #ff6a00 !important;
}

/* SEARCH BAR */
.search-box {
	width: 460px;
	margin-left: 35px;
	margin-right: 25px;
}

.search-group input {
	border-right: 0;
}

.search-group button {
	border-left: 0;
	background: linear-gradient(135deg, #8e44ad, #2980b9);
	color: white;
}

/* RIGHT ICONS */
.nav-icons {
	display: flex;
	align-items: center;
	gap: 32px;
}

.nav-icons button {
	background: none;
	border: none;
	font-size: 20px;
	color: #222;
}

/* HERO SECTION */
.hero {
	height: 420px;
}

.carousel-item img {
	height: 420px;
	object-fit: cover;
	filter: brightness(70%);
}

.hero-text {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	color: white;
	text-align: center;
	width: 70%;
}

.hero-text h1 {
	font-size: 48px;
	font-weight: 700;
}

.hero-text p {
	font-size: 18px;
}

/* CATEGORY BOX */
.category-box {
	padding: 28px;
	background: linear-gradient(135deg, #8e44ad, #2980b9);
	color: white;
	border-radius: 10px;
	font-weight: 600;
	text-align: center;
	border: none;
	width: 100%;
}

/* BOOK CARD */
.book-card {
	background: white;
	border-radius: 12px;
	box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
	padding: 15px;
	transition: 0.3s;
}

.book-card:hover {
	transform: translateY(-5px);
}

.book-img {
	height: 200px;
	width: 100%;
	object-fit: contain;
	border-radius: 8px;
	background: white;
}

/* FOOTER */
.footer {
	background: #111;
	color: white;
	padding: 40px;
	margin-top: 60px;
	text-align: center;
}

/* FIXED WARNING */
.dropdown-menu {
	background: #E6E9EB;
	right: auto;
	left: 0;
}
</style>

</head>

<body>

	<nav class="navbar navbar-expand-lg">

		<div class="container-fluid">

			<a class="navbar-brand" href="index.jsp"> <img
				src="images/bookstorelogo.png">
			</a>

			<button class="navbar-toggler" data-bs-toggle="collapse"
				data-bs-target="#navMenu">
				<span class="navbar-toggler-icon"></span>
			</button>

			<div class="collapse navbar-collapse" id="navMenu">

				<ul class="navbar-nav">

					<li class="nav-item"><a class="nav-link" href="#">Books</a></li>
					<li class="nav-item"><a class="nav-link" href="#">Categories</a></li>
					<li class="nav-item"><a class="nav-link" href="#">Authors</a></li>
					<li class="nav-item"><a class="nav-link" href="#">Publishers</a></li>
					<li class="nav-item"><a class="nav-link" href="#">Stores</a></li>
					<li class="nav-item"><a class="nav-link" href="#">Reviews</a></li>

				</ul>

				<form action="SearchBookServlet" method="get" class="search-box">

					<div class="input-group search-group">

						<input class="form-control" name="keyword"
							placeholder="Search books, authors, ISBN...">

						<button type="submit" class="btn">
							<i class="fa fa-search"></i>
						</button>

					</div>

				</form>

				<div class="nav-icons">

					<!-- PROFILE ICON ALWAYS PRESENT -->

					<div class="dropdown">

						<button class="btn" data-bs-toggle="dropdown">
							<i class="fa fa-user-circle" style="font-size: 22px;"></i>
						</button>

						<ul class="dropdown-menu">

							<%
							if (user == null) {
							%>

							<li><a class="dropdown-item" href="loginCustomer.jsp"> <i
									class="fa fa-sign-in-alt"></i> Login
							</a></li>

							<li><a class="dropdown-item" href="registerCustomer.jsp">
									<i class="fa fa-user-plus"></i> Register as Customer
							</a></li>
							<li><a class="dropdown-item" href="registerSeller.jsp">
									<i class="fa fa-user-plus"></i> Register as seller
							</a></li>

							<%
							} else {
							%>

							<li class="dropdown-item-text">Hello <strong><%=user.getName()%></strong>
							</li>

							<li><hr class="dropdown-divider"></li>

							<li><a class="dropdown-item" href="#"> <i
									class="fa fa-user"></i> My Profile
							</a></li>

							<li><a class="dropdown-item" href="#"> <i
									class="fa fa-box"></i> My Orders
							</a></li>

							<li><a class="dropdown-item" href="#"> <i
									class="fa fa-heart"></i> Wishlist
							</a></li>

							<li><hr class="dropdown-divider"></li>

							<li><a class="dropdown-item text-danger"
								href="LogoutCustomer"> <i class="fa fa-sign-out-alt"></i>
									Logout
							</a></li>

							<%
							}
							%>

						</ul>

					</div>

					<form action="WishlistServlet" method="get">
						<button type="submit">
							<i class="fa fa-heart"></i>
						</button>
					</form>

					<form action="CartServlet" method="get">
						<button type="submit">
							<i class="fa fa-shopping-cart"></i>
						</button>
					</form>

				</div>

			</div>

		</div>

	</nav>

	<!-- HERO CAROUSEL -->

	<div id="heroCarousel" class="carousel slide hero"
		data-bs-ride="carousel">

		<div class="carousel-inner">

			<div class="carousel-item active">

				<img src="images/bookimag4.jpg" class="d-block w-100">

				<div class="hero-text">

					<h1>BookNest</h1>

					<p>Your Home for Every Book. Explore thousands of titles and
						discover your next favorite read. Festival Sale Coming Soon – Up
						to 40% OFF!</p>

				</div>

			</div>

			<div class="carousel-item">

				<img src="images/bookimg3.jpg" class="d-block w-100">

				<div class="hero-text">

					<h1>Discover New Worlds</h1>

					<p>Find best selling novels, classics and modern stories from
						top authors.</p>

				</div>

			</div>

			<div class="carousel-item">

				<img src="images/bookimg1.jpg" class="d-block w-100">

				<div class="hero-text">

					<h1>Knowledge at Your Fingertips</h1>

					<p>Explore technology, science and self-help books to upgrade
						your skills.</p>

				</div>

			</div>

		</div>

		<button class="carousel-control-prev" type="button"
			data-bs-target="#heroCarousel" data-bs-slide="prev">

			<span class="carousel-control-prev-icon"></span>

		</button>

		<button class="carousel-control-next" type="button"
			data-bs-target="#heroCarousel" data-bs-slide="next">

			<span class="carousel-control-next-icon"></span>

		</button>

	</div>

	<!-- CATEGORIES -->

	<div class="container">

		<h2 class="text-center mt-5 mb-4">Browse Categories</h2>

		<div class="row g-4">

			<div class="col-md-3">

				<form action="CategoryServlet">
					<input type="hidden" name="category" value="Fiction">
					<button class="category-box">Fiction</button>
				</form>

			</div>

			<div class="col-md-3">

				<form action="CategoryServlet">
					<input type="hidden" name="category" value="Self Help">
					<button class="category-box">Self Help</button>
				</form>

			</div>

			<div class="col-md-3">

				<form action="CategoryServlet">
					<input type="hidden" name="category" value="Technology">
					<button class="category-box">Technology</button>
				</form>

			</div>

			<div class="col-md-3">

				<form action="CategoryServlet">
					<input type="hidden" name="category" value="History">
					<button class="category-box">History</button>
				</form>

			</div>

		</div>

	</div>

	<!-- FEATURED BOOKS -->

	<div class="container">

		<h2 class="text-center mt-5 mb-4">Featured Books</h2>

		<div class="row g-4">

			<div class="col-md-3">
				<div class="book-card">
					<div class="book-img">
						<img src="images/penguin.jpg"
							style="width: 100%; height: 200px; object-fit: cover; border-radius: 8px;">
					</div>
					<h5 class="mt-2">Men without Women</h5>
					<p>₹399</p>
					<form action="CartServlet" method="post">
						<input type="hidden" name="bookId" value="101">
						<button class="btn btn-primary w-100">Add to Cart</button>
					</form>
				</div>
			</div>

			<div class="col-md-3">
				<div class="book-card">
					<div class="book-img">
						<img src="images/a-brief-history-of-time.jpeg"
							style="width: 100%; height: 200px; object-fit: cover; border-radius: 8px;">
					</div>
					<h5 class="mt-2">A Brief History Of Time</h5>
					<p>₹282</p>
					<form action="CartServlet" method="post">
						<input type="hidden" name="bookId" value="101">
						<button class="btn btn-primary w-100">Add to Cart</button>
					</form>
				</div>
			</div>

			<div class="col-md-3">
				<div class="book-card">
					<div class="book-img">
						<img src="images/as-a-man-thinketh.jpeg"
							style="width: 100%; height: 200px; object-fit: cover; border-radius: 8px;">
					</div>
					<h5 class="mt-2">As a man Thinketh</h5>
					<p>₹125</p>
					<form action="CartServlet" method="post">
						<input type="hidden" name="bookId" value="101">
						<button class="btn btn-primary w-100">Add to Cart</button>
					</form>
				</div>
			</div>

			<div class="col-md-3">
				<div class="book-card">
					<div class="book-img">
						<img src="images/Wings-of-Fire.jpg"
							style="width: 100%; height: 200px; object-fit: cover; border-radius: 8px;">
					</div>
					<h5 class="mt-2">Wings Of Fire</h5>
					<p>₹182</p>
					<form action="CartServlet" method="post">
						<input type="hidden" name="bookId" value="101">
						<button class="btn btn-primary w-100">Add to Cart</button>
					</form>
				</div>
			</div>

		</div>

	</div>

	<div class="footer">
		<p>© 2026 BookNest</p>
		<p>Your Home for Every Book</p>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>