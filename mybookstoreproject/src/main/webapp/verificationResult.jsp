<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>

<title>Verification Status</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

</head>

<body class="bg-light">

	<img src="images/bookstorelogo.png"
		style="display: block; margin: auto; width: 200px;">

	<div class="container mt-5">

		<%
		String status = (String) request.getAttribute("status");

		if ("verified".equals(status)) {
		%>

		<div class="alert alert-success text-center">

			<h3>Verification Successful</h3>

			<a href="sellerHome.jsp" class="btn btn-success"> Go To
				Dashboard </a>

		</div>

		<%
		} else {
		%>

		<div class="alert alert-danger text-center">

			<h3>Verification Failed</h3>

			<p>Please contact support</p>

		</div>

		<%
		}
		%>

	</div>

</body>
</html>