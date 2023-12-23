<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*, java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%request.getProtocol();%>

<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="stylesheet" href="css/bookstore.css" type="text/css" />
<script type="text/javascript" src="js/jquery-1.9.1.js"></script>
<script src="js/bookstore.js"></script>
</head>
<body>
	<div id="centered">

		<div>
			<jsp:include page="UserDashboard.jsp" flush="true" />
		</div>
		<br> <br>
		
		<div>
					<span class="latest-header">Recent Orders</span>
					
					<div class="latest-prods">
						<p class="latest-p">New Additions</p>
						<div class="latest-prod-additions" style="background:none;border-width:3px">
							<p class="latest-prod-additions-info"><span style="font-size: 24px"><b>ORDER ID: ${purchases[0].purchaseId}</b></span></p>
							<p class="latest-prod-additions-info">CONTENT: ${orderItms[0]}</p>
							<p class="latest-prod-additions-info"><span style="color:grey">SIZE: ${purchases[0].orderSize}</span></p>
							
							<p class="latest-prod-additions-info"><span style="color:grey"><i>cust</i> ${purchases[0].customerId}</span></p>
							<p class="latest-prod-additions-info"><span style="color:grey">${purchases[0].date}</span></p>
						</div>				
						<br>
						<div class="latest-prod-additions" style="background:none;border-width:3px">
							<p class="latest-prod-additions-info"><span style="font-size: 24px"><b>ORDER ID: ${purchases[1].purchaseId}</b></span></p>
							<p class="latest-prod-additions-info">CONTENT: ${orderItms[1]}</p>
							<p class="latest-prod-additions-info"><span style="color:grey">SIZE: ${purchases[1].orderSize}</span></p>
							<p class="latest-prod-additions-info"><span style="color:grey"><i>cust</i> ${purchases[1].customerId}</span></p>
							<p class="latest-prod-additions-info"><span style="color:grey">${purchases[1].date}</span></p>
						</div>
						<br>
						<div class="latest-prod-additions" style="background:none;border-width:3px">
							<p class="latest-prod-additions-info"><span style="font-size: 24px"><b>ORDER ID: ${purchases[2].purchaseId}</b></span></p>
							<p class="latest-prod-additions-info">CONTENT: ${orderItms[2]}</p>
							<p class="latest-prod-additions-info"><span style="color:grey">SIZE: ${purchases[2].orderSize}</span></p>
							<p class="latest-prod-additions-info"><span style="color:grey"><i>cust</i> ${purchases[2].customerId}</span></p>
							<p class="latest-prod-additions-info"><span style="color:grey">${purchases[2].date}</span></p>
						</div>
						<br>
						<div class="latest-prod-additions" style="background:none;border-width:3px">
							<p class="latest-prod-additions-info"><span style="font-size: 24px"><b>ORDER ID: ${purchases[3].purchaseId}</b></span></p>
							<p class="latest-prod-additions-info">CONTENT: ${orderItms[3]}</p>
							<p class="latest-prod-additions-info"><span style="color:grey">SIZE: ${purchases[3].orderSize}</span></p>
							<p class="latest-prod-additions-info"><span style="color:grey"><i>cust</i> ${purchases[3].customerId}</span></p>
							<p class="latest-prod-additions-info"><span style="color:grey">${purchases[3].date}</span></p>
						</div>
					</div>
				
				</div>
		<jsp:include page="footer.jsp" flush="true" />
	</div>

</body>
</html>