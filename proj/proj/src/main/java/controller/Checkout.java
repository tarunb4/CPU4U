package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.*;
import model.Cart;
import model.Item;

/**
 * Servlet implementation class Checkout
 */
@WebServlet("/Checkout")
public class Checkout extends HttpServlet {
	private static final long serialVersionUID = 1L;
	 private ItemDAOImpl itemDao;

	  
  
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Checkout() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        itemDao = new ItemDAOImpl(getServletContext());
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String stage = request.getParameter("stage");

        if ("payment".equals(stage)) {
            // Output HTML for payment form
            response.setContentType("text/html");
            response.getWriter().println("<html><body>");
            response.getWriter().println("<h2>Payment Information</h2>");
            response.getWriter().println("<form action='Checkout' method='post'>");
            response.getWriter().println("<input type='hidden' name='stage' value='complete'>");
            response.getWriter().println("<input type='text' name='creditCardNumber' placeholder='Credit Card Number' maxlength='16' pattern='\\d{16}'>");
            response.getWriter().println("<input type='text' name='expiryDate' placeholder='Expiry Date (MMYY)' maxlength='4' pattern='\\d{4}'>");
            response.getWriter().println("<input type='text' name='cvv' placeholder='CVV' maxlength='3' pattern='\\d{3}'>");
            response.getWriter().println("<input type='submit' value='Complete Order'>");
            response.getWriter().println("</form></body></html>");
        } else {
            // Default to shipping form
            response.setContentType("text/html");
            response.getWriter().println("<html><body>");
            response.getWriter().println("<h2>Shipping Information</h2>");
            response.getWriter().println("<form action='Checkout?stage=payment' method='post'>");
            response.getWriter().println("<input type='text' name='firstName' placeholder='First Name'>");
            response.getWriter().println("<input type='text' name='lastName' placeholder='Last Name'>");
            response.getWriter().println("<input type='text' name='address' placeholder='Street Address'>");
            response.getWriter().println("<input type='text' name='city' placeholder='City'>");
            response.getWriter().println("<input type='text' name='postalCode' placeholder='Postal Code'>");
            response.getWriter().println("<input type='text' name='province' placeholder='Province'>");
            response.getWriter().println("<input type='text' name='country' placeholder='Country'>");
            response.getWriter().println("<input type='submit' value='Proceed to Payment'>");
            response.getWriter().println("</form></body></html>");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String stage = request.getParameter("stage");

        if ("complete".equals(stage)) {
            // Retrieve cart from session
            Cart cart = (Cart) request.getSession().getAttribute("cart");

            if (cart != null && !cart.getItems().isEmpty()) {
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println("<html><body>");
                out.println("<p>Thank you for your order!</p>");

                // Display the cart items
                out.println("<h3>Your Order:</h3>");
                out.println("<table>");
                out.println("<tr><th>Item ID</th><th>Name</th><th>Quantity</th><th>Price</th><th>Total</th></tr>");
                for (Item item : cart.getItems()) {
                    out.println("<tr><td>" + item.getItemId() + "</td><td>" + item.getProdName() + "</td><td>" + 
                                item.getOrderedQty() + "</td><td>" + item.getPrice() + "</td><td>" + 
                                (item.getPrice() * item.getOrderedQty()) + "</td></tr>");
                }
                out.println("</table>");
                out.println("<p>Total Price: $" + cart.calculateTotal() + "</p>");

                // Clear the cart after displaying
                request.getSession().setAttribute("cart", new Cart());
                
                out.println("<a href='books'><button>Back to Home</button></a>");

                out.println("</body></html>");
            } else {
                // Handle the case where the cart is empty or null
                response.setContentType("text/html");
                response.getWriter().println("<html><body><p>Your cart is empty.</p></body></html>");
            }
        } else {
            doGet(request, response);
        }
    }
	

}
