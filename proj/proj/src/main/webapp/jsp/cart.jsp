<%@ page import="model.Cart" %>
<%@ page import="model.Item" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Shopping Cart</title>
    <link rel="stylesheet" href="css/style.css" type="text/css"/>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
</head>
<body>
    <h2>Shopping Cart</h2>
    <p><a href="http://localhost:8080/proj/books">Back to Home</a></p>

    <%
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null || cart.getItems().isEmpty()) {
            out.println("<p id='emptyCartMessage'>Your cart is empty.</p>");
        } else {
    %>
    <table>
        <thead>
            <tr>
                <th>Item ID</th>
                <th>Name</th>
                <th>Quantity</th>
                <th>Price</th>
                <th>Total</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                for (Item item : cart.getItems()) {
            %>
            <tr id="itemRow_<%= item.getItemId() %>">
                <td><%= item.getItemId() %></td>
                <td><%= item.getProdName() %></td>
                <td>
                    <input type="number" name="quantity" value="<%= item.getOrderedQty() %>" min="1">
                </td>
                <td><%= item.getPrice() %></td>
                <td><%= item.getPrice() * item.getOrderedQty() %></td>
                <td>
                    <button onclick="updateItemQuantity(event, '<%= item.getItemId() %>')">Update</button>
                    <button onclick="removeItem(event, '<%= item.getItemId() %>')">Remove</button>
                </td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>
    <p>Total Price: $<span id="totalPrice"><%= cart.calculateTotal() %></span></p>

    <!-- Checkout Button -->
    <form action="<%= request.getContextPath() %>/Checkout" method="post">
        <input type="submit" value="Checkout" />
    </form>

    <%
        }
    %>

    <script>
	    function updateItemQuantity(event, itemId) {
	        event.preventDefault();
	        var row = $("#itemRow_" + itemId);
	        var quantity = row.find("input[name='quantity']").val();
	        var price = row.find("td:nth-child(4)").text(); // Assuming the price is in the fourth column
	
	        if (parseInt(quantity) > 0) {
	            $.ajax({
	                url: "<%= request.getContextPath() %>/cartServlet",
	                type: "POST",
	                data: {
	                    action: "update",
	                    itemId: itemId,
	                    newQuantity: quantity
	                },
	                success: function(response) {
	                    alert("Quantity updated successfully!");
	
	                    // Update the total price for the item in the table
	                    var newTotal = parseFloat(price) * parseInt(quantity);
	                    row.find("td:nth-child(5)").text(newTotal.toFixed(2)); // Update the Total column
	
	                    // Update the total cart price
	                    $("#totalPrice").text(response.totalPrice);
	                },
	                error: function() {
	                    alert("Error updating item quantity.");
	                }
	            });
	        } else {
	            alert("Quantity must be greater than 0.");
	        }
	    }

        function removeItem(event, itemId) {
            event.preventDefault();

            $.ajax({
                url: "<%= request.getContextPath() %>/cartServlet",
                type: "POST",
                data: {
                    action: "remove",
                    itemId: itemId
                },
                success: function(response) {
                    alert("Item removed successfully!");
                    $("#itemRow_" + itemId).remove();

                    // Check if any items are left in the cart
                    if ($("table tbody tr").length === 0) {
                        $("#totalPrice").text('0');
                        $("table").hide(); // Hide the table
                        $("form").hide(); // Hide the checkout form
                        $("#emptyCartMessage").show(); // Show the empty cart message
                    } else {
                        $("#totalPrice").text(response.totalPrice);
                    }
                },
                error: function() {
                    alert("Error removing item from cart.");
                }
            });
        }
    </script>
</body>
</html>
