<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Login - BookNest</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

<style>
body {
	background: #f5f5f6;
	font-family: 'Segoe UI', sans-serif;
}

/* login container */
.login-container {
	height: 100vh;
	display: flex;
	align-items: center;
	justify-content: center;
}

/* card */
.login-card {
	width: 380px;
	background: white;
	padding: 35px;
	border-radius: 10px;
	box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
}

/* logo */
.logo {
	text-align: center;
	margin-bottom: 20px;
}

.logo img {
	height: 55px;
}

/* button */
.btn-login {
	background: #ff3f6c;
	color: white;
	font-weight: 600;
}

.btn-login:hover {
	background: #e7335f;
	color: white;
}

.error-msg {
	color: red;
	text-align: center;
	margin-bottom: 10px;
}
</style>

</head>

<body>

	<div class="login-container">

		<div class="login-card">

			<div class="logo">
				<img src="images/bookstorelogo.png">
			</div>

			<h4 class="text-center mb-3">Login to BookNest</h4>

			<%
			String error = request.getParameter("error");
			if (error != null) {
			%>

			<div class="error-msg">Wrong Email or Password</div>

			<%
			}
			%>

			<form action="LoginCustomer" method="post">

				<div class="mb-3">

					<label>Email</label> <input type="email" name="email"
						class="form-control" required>

				</div>

				<div class="mb-3">

					<label>Password</label> <input type="password" name="password"
						class="form-control" required>

				</div>

				<button type="submit" class="btn btn-login w-100">Login</button>

			</form>

			<hr>

			<p class="text-center">

				New to BookNest ? <a href="registerCustomer.jsp"> Create Account
				</a>

			</p>

		</div>

	</div>

</body>
</html>