/** **************************************************************
 * Copyright [2021] [FPT University]
 *
 * This file create by [Hoang Lam]
 * If you want to use this file in your project,
 * please contact to <https://www.facebook.com/hoanglammaster>
 * or <hoanglammaster@gmail.com>
 * Do not use without permission
 *
 * “All I know is that I do not know anything”― Socrates
 * ***************************************************************
 */
package controller.servlet;

import dal.sql.Gettable;
import dal.sql.Searchable;
import dal.sql.SqlServerFactory;
import dal.sql.department.DepartmentDao;
import dal.sql.request.RequestDao;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.time.LocalDate;
import java.time.Period;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.department.Department;
import model.request.Request;
import model.request.RequestFactory;
import model.request.RequestSummary;
import model.util.convert.ConverterFactory;

/**
 *
 * @author Hoang Lam
 */
public class HomeServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet HomeServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomeServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Gettable<RequestSummary> getter = RequestDao.getRequestSummaryGetter(SqlServerFactory.getConnectioner(), ConverterFactory.getRequestSummaryConverter());
        List<RequestSummary> listRequest = getter.getAll();

        List<RequestSummary> requestToDays = listRequest.stream().filter(m -> m.getDateCreated().toLocalDate().equals(LocalDate.now())).collect(Collectors.toList());
        List<RequestSummary> requestBefores = listRequest.stream().filter(m -> m.getDateCreated().toLocalDate().compareTo(LocalDate.now()) < 0).collect(Collectors.toList());
        Optional<RequestSummary> lastSummary
                = requestBefores.stream()
                        .min(
                                (sum1, sum2)
                                -> (sum1.getDateCreated().compareTo(sum2.getDateCreated()))
                        );

        Period periodDate = Period
                .between(lastSummary
                        .orElse(RequestFactory.getSummaryRequest("", -1, Date.valueOf(LocalDate.now())))
                        .getDateCreated().toLocalDate(),
                        LocalDate.now());
        String lastDate = " ";
        if (periodDate.getYears() != 0) {
            lastDate += periodDate.getYears() + " years -";
        }
        if (periodDate.getYears() != 0) {
            lastDate += periodDate.getMonths() + " months -";
        } else {
            if (periodDate.getMonths() != 0) {
                lastDate += periodDate.getMonths() + " months -";
            }
        }
        lastDate += periodDate.getDays() + " days";

        Map<String, Integer> maps = new HashMap<>();
        requestBefores.stream().forEach((m)
                -> {
            maps.put(
                    m.getDepartment(),
                    maps.getOrDefault(m.getDepartment(), 0) + m.getNumberOfRequest());
        }
        );
        
        request.setAttribute("lastDate", lastDate);
        request.setAttribute("requestToDays", requestToDays);
        request.setAttribute("requestBefores", maps);
        request.getRequestDispatcher("home.jsp").forward(request, response);

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Enumeration<String> name = request.getParameterNames();
        List<Request> listSelectedRequest = null;
        while(name.hasMoreElements()){
            Searchable<Request> getter = RequestDao.getRequestSeacher(SqlServerFactory.getConnectioner(), ConverterFactory.getRequestConverter());
            listSelectedRequest = getter.searchAll(name.nextElement(),RequestDao.DEPARTMENT);
        }
        Gettable<Department> getter = DepartmentDao.getDepartmentGetter(SqlServerFactory.getConnectioner(), ConverterFactory.getDepartmentConverter());
        List<Department> listDepartment = getter.getAll();
        
        request.setAttribute("selectedDepartment", listDepartment.get(0).getId());
        request.setAttribute("listDepartment", listDepartment);
        request.setAttribute("listSelectedRequest", listSelectedRequest);
        request.getRequestDispatcher("performViewRequest.jsp").forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
