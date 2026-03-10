<!DOCTYPE html>
<html>
<head>

<title>Seller Login</title>

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

<style>

body{
background-color:#f3f3f3;
font-family: Arial, Helvetica, sans-serif;
}

.login-container{
max-width:400px;
margin:auto;
margin-top:60px;
}

.login-card{
border-radius:8px;
border:1px solid #ddd;
padding:30px;
background:white;
box-shadow:0 2px 6px rgba(0,0,0,0.1);
}

.logo{
display:block;
margin:auto;
width:180px;
margin-top:40px;
}

.login-title{
text-align:center;
font-weight:600;
margin-bottom:20px;
}

.form-control{
height:45px;
}

.btn-login{
background-color:#ffd814;
border-color:#fcd200;
color:black;
font-weight:600;
}

.btn-login:hover{
background-color:#f7ca00;
}

.footer-link{
text-align:center;
margin-top:15px;
}

</style>

</head>

<body>

<img src="images/bookstorelogo.png" class="logo">

<div class="login-container">

<div class="login-card">

<h4 class="login-title">Seller Login</h4>

<form action="sellerLogin" method="post">

<div class="mb-3">
<label class="form-label">Email</label>
<input type="email" name="email" class="form-control" required>
</div>

<div class="mb-3">
<label class="form-label">Password</label>
<input type="password" name="password" class="form-control" required>
</div>

<button class="btn btn-login w-100">Login</button>

</form>

<div class="footer-link">
<a href="index.jsp" class="btn btn-outline-secondary w-100 mt-3">
Back
</a>
</div>

</div>

</div>

</body>
</html>