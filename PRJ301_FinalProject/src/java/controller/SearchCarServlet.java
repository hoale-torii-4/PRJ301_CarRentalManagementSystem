package controller;

import DAO.CarDAO;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Car;

@WebServlet(name = "SearchCarServlet", urlPatterns = {"/SearchCarServlet"})
public class SearchCarServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("query");
        CarDAO carDAO = new CarDAO();
        List<String> suggestions = carDAO.getCarSuggestions(keyword);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print(new Gson().toJson(suggestions)); // Chuyển danh sách thành JSON
        out.flush();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("query");

        CarDAO carDAO = new CarDAO();
        List<Car> searchResults = carDAO.searchCars(keyword);

        request.setAttribute("searchQuery", keyword);
        request.setAttribute("searchResults", searchResults);

        request.getRequestDispatcher("CreateInvoice.jsp").forward(request, response);
    }
}