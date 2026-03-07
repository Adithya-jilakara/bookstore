<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Register - BookNest</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

<style>
body {
	background: #f5f5f6;
	font-family: 'Segoe UI', sans-serif;
}

.register-container {
	height: 100vh;
	display: flex;
	align-items: center;
	justify-content: center;
}

.register-card {
	width: 420px;
	background: white;
	padding: 35px;
	border-radius: 10px;
	box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
}

.logo {
	text-align: center;
	margin-bottom: 20px;
}

.logo img {
	height: 55px;
}

.btn-register {
	background: #ff3f6c;
	color: white;
	font-weight: 600;
}

.btn-register:hover {
	background: #e7335f;
	color: white;
}

.success-msg {
	color: green;
	text-align: center;
	margin-bottom: 10px;
}

.error-msg {
	color: red;
	text-align: center;
	margin-bottom: 10px;
}
</style>

</head>

<body>

	<div class="register-container">

		<div class="register-card">

			<div class="logo">
				<img src="images/bookstorelogo.png">
			</div>

			<h4 class="text-center mb-3">Create BookNest Account</h4>

			<%
			String success = request.getParameter("success");
			String error = request.getParameter("error");

			if (success != null) {
			%>

			<div class="success-msg">Registration Successful !</div>

			<div class="text-center mb-2">

				<a href="loginCustomer.jsp" class="btn btn-success"> Login Now </a>

			</div>

			<%
			} else if (error != null) {
			%>

			<div class="error-msg">Registration Failed. Try Again.</div>

			<%
			}
			%>

			<form action="RegisterCustomer" method="post">

				<div class="mb-3">

					<label>Full Name</label> <input type="text" name="name"
						class="form-control" required>

				</div>

				<div class="mb-3">

					<label>Email</label> <input type="email" name="email"
						class="form-control" required>

				</div>

				<div class="mb-3">

					<label>Password</label> <input type="password" name="password"
						class="form-control" required>

				</div>

				<div class="mb-3">

					<label>Phone</label> <input type="text" name="phone"
						class="form-control" required>

				</div>

				<button type="submit" class="btn btn-register w-100">
					Create Account</button>

			</form>

			<hr>

			<p class="text-center">

				Already have account ? <a href="loginCustomer.jsp"> Login </a>

			</p>

		</div>

	</div>

</body>
</html>