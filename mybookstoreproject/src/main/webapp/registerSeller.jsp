<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">
<title>BookNest Seller Registration</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

<style>

body{
background:#eef1f5;
font-family: 'Segoe UI', Arial;
}

/* NAVBAR */

.navbar{
background:#131921;
padding:12px 25px;
}

.logo{
height:42px;
}

/* CENTER FORM */

.form-wrapper{
max-width:700px;
margin:auto;
margin-top:4px;
}

/* CARD */

.card{
border-radius:20px;
border:none;
padding:20px;
box-shadow:0 8px 20px rgba(0,0,0,0.08);
}

/* HEADINGS */

h3{
font-weight:600;
color:#131921;
}

/* STEP NAVIGATION */

.step-container{
display:flex;
justify-content:space-between;
margin-bottom:25px;
position:relative;
}

.step{
flex:1;
text-align:center;
position:relative;
}

.step::after{
content:'';
position:absolute;
top:15px;
right:-50%;
width:100%;
height:3px;
background:#ddd;
z-index:-1;
}

.step:last-child::after{
display:none;
}

.step-circle{
width:32px;
height:32px;
border-radius:50%;
background:#ccc;
color:white;
margin:auto;
line-height:32px;
font-size:14px;
font-weight:bold;
}

.step.active .step-circle{
background:#28a745;
}

.step.active p{
color:#28a745;
font-weight:600;
}

.step p{
font-size:13px;
margin-top:5px;
}

/* INPUT STYLE */

.form-control{
border-radius:6px;
padding:10px;
font-size:14px;
}

.form-control:focus{
border-color:#FF9900;
box-shadow:0 0 0 0.1rem rgba(255,153,0,0.25);
}

/* LABEL */

label{
font-size:14px;
font-weight:500;
margin-bottom:2px;
}

/* BUTTON STYLE */

.btn-main{
background:#ff3f6c;
color:white;
font-weight:600;
padding:8px 20px;
border-radius:6px;
border:none;
}

.btn-main:hover{
background:#e68a00;
}

.btn-secondary{
padding:6px 15px ;
margin-top:5px;
margin-left:5px;

}

/* BACK BUTTON */

.home-btn{
margin-top:25px;
}

</style>

</head>

<body>

	<!-- NAVBAR -->

	<nav class="navbar px-4">

		<img src="images/bookstorelogo.png" class="logo">

	</nav>
     <a href="index.jsp" class="btn btn-secondary" > ⬅ Back to Home
						</a>

	<div class="form-wrapper">
	

		<div class="card">

			<h3 class="text-center mb-4">Create Seller Account</h3>

			<!-- STEP NAVIGATION -->

			<div class="step-container">

				<div class="step active" id="navStep1">
					<div class="step-circle">1</div>
					<p>Account</p>
				</div>

				<div class="step" id="navStep2">
					<div class="step-circle">2</div>
					<p>Business</p>
				</div>

				<div class="step" id="navStep3">
					<div class="step-circle">3</div>
					<p>Verification</p>
				</div>
			</div>


			<form action="sellerRegister" method="post" enctype="multipart/form-data">

				<!-- STEP 1 -->

				<div id="step1">

					<h5>Step 1 : Account Information</h5>

					<div class="row mt-3">

						<div class="col-md-6">
							<label>Full Name</label> <input type="text" name="name" class="form-control" required>
						</div>

						<div class="col-md-6">
							<label>Email</label> <input type="email" name="email"
								class="form-control" required>
						</div>

					</div>

					<div class="row mt-3">

						<div class="col-md-6">
							<label>Password</label> <input type="password" name="password"
								class="form-control" required>
						</div>

						<div class="col-md-6">
							<label>Phone</label><input type="text" name="phone" class="form-control" required>
						</div>

					</div>
					
					<div class="text-end mt-4">
						

						<button type="button" class="btn btn-main" onclick="nextStep(1)">
							Next →</button>

					</div>


				</div>
				


				<!-- STEP 2 -->

				<div id="step2" style="display: none">

					<h5>Step 2 : Business Information</h5>

					<div class="row mt-3">

						<div class="col-md-6">
							<label>Business Type</label> <select name="businessType"
								class="form-control">
								<option>Individual Seller</option>
								<option>Registered Bookstore</option>
								<option>Publishing House</option>
							</select>
						</div>

						<div class="col-md-6">
							<label>Business Name</label> <input type="text"
								name="storeName" class="form-control">
						</div>

					</div>

					<div class="row mt-3">

						<div class="col-md-6">
							<label>City</label> <input type="text" name="city"
								class="form-control">
						</div>

						<div class="col-md-6">
							<label>State</label> <input type="text" name="state"
								class="form-control">
						</div>

					</div>

					<div class="mt-4 d-flex justify-content-between">

						<button type="button" class="btn btn-secondary"
							onclick="prevStep(2)">← Back</button>

						<button type="button" class="btn btn-main" onclick="nextStep(2)">
							Next →</button>

					</div>

				</div>


				<!-- STEP 3 -->

				<div id="step3" style="display: none">

					<h5>Step 3 : Identity Verification</h5>

					<div class="row mt-3">

						<div class="col-md-6">
							<label>ID Type</label> <select name="idType" class="form-control">
								<option>Aadhar</option>
								<option>PAN</option>
								<option>Passport</option>
							</select>
						</div>

						<div class="col-md-6">
							<label>ID Number</label> <input type="text" name="idNumber"
								class="form-control">
						</div>

					</div>

					<div class="mt-3">

						<label>Upload ID Proof</label> <input type="file" name="idDocument" class="form-control" required>

					</div>

					<div class="form-check mt-3">

						<input type="checkbox" class="form-check-input" required>

						<label class="form-check-label"> I confirm the information
							provided is correct. </label>

					</div>

					<div class="mt-4 d-flex justify-content-between">

						<button type="button" class="btn btn-secondary"
							onclick="prevStep(3)">← Back</button>

						<button type="submit" class="btn btn-main">Submit
							Registration</button>

					</div>

				</div>

			</form>

		</div>

	</div>




	<script>
		function nextStep(step) {

			document.getElementById("step" + step).style.display = "none";
			document.getElementById("step" + (step + 1)).style.display = "block";

			document.getElementById("navStep" + step).classList
					.remove("active");
			document.getElementById("navStep" + (step + 1)).classList
					.add("active");

		}

		function prevStep(step) {

			document.getElementById("step" + step).style.display = "none";
			document.getElementById("step" + (step - 1)).style.display = "block";

			document.getElementById("navStep" + step).classList
					.remove("active");
			document.getElementById("navStep" + (step - 1)).classList
					.add("active");

		}
	</script>

</body>
</html>