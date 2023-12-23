<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*, java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
List<String> imageUrls = new ArrayList<>();
imageUrls.add("images/Laptop.png");
imageUrls.add("images/Desktop.png");
imageUrls.add("images/Monitor.png");
imageUrls.add("images/Keyboard.png");
imageUrls.add("images/Mouse2.png");
imageUrls.add("images/Headphones.png");
imageUrls.add("images/Speaker.png");
imageUrls.add("images/Tablet.png");
imageUrls.add("images/Router.png");
imageUrls.add("images/Printer.png");
imageUrls.add("images/Scanner.png");
imageUrls.add("images/Webcam.png");
imageUrls.add("images/External Drive.png");
imageUrls.add("images/Graphics Card.png");
imageUrls.add("images/RAM.png");

request.setAttribute("imageUrls", imageUrls);
%>

<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<script src="js/jquery-1.9.1.js"></script>
<link rel="stylesheet" href="css/bookstore.css" type="text/css" />
<script src="js/bookstore.js"></script>
<script>
        function addToCart(event, itemId) {
            event.preventDefault(); // Prevent the default form submission

            var quantity = $(event.target).find("input[name='quantity']").val();

            $.ajax({
                url: "<%= request.getContextPath() %>/cartServlet",
                type: "POST",
                data: {
                    action: "addToCart",
                    itemId: itemId,
                    quantity: quantity
                },
                success: function(response) {
                    alert("Item added to cart successfully!");
                    // Update the cart display or quantity here
                },
                error: function() {
                    alert("Error adding item to cart.");
                }
            });
        }
</script>


</head>
<body>
	<div id="centered">
		<jsp:include page="header.jsp" flush="true" />
		<jsp:include page="leftColumn.jsp" flush="true" />
	</div>
	<br>
	<span class="big-par">All ${brand} Products</span>

	<div class="grid">
		<c:forEach var="item" items="${brandProds}">
			<div class="card" id="product-${loop.index}">
				<div class="prodIm">
					<img class="brand-image" src="${url[item.brandName]}" alt="Product Image" data-brand="${item.brandName}">
					
				</div>
				<p>
					<span class="header-featured">${item.prodName}</span> <span
						class="info-featured">${item.prodInfo}</span> <span
						class="info-featured">$${item.price}</span> <span
						class="info-featured">Quantity remaining:
						${item.quantityAvail}</span>
				</p>
				<form onsubmit="addToCart(event, '${item.itemId}')">
                        <input type="hidden" name="itemId" value="${item.itemId}">
                        <input type="number" name="quantity" value="1" min="1" max="${item.quantityAvail}">
                        <input type="submit" value="ADD TO CART" class="featured-add-button">
               	</form>
			</div>
		</c:forEach>
	</div>

</body>
</html>
