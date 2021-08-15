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
import java.util.List;
import java.util.stream.Collectors;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.department.Department;
import model.request.Request;
import model.request.RequestFully;
import model.util.convert.ConverterFactory;

/**
 *
 * @author Hoang Lam
 */
public class ViewRequestServlet extends HttpServlet {

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
            out.println("<title>Servlet ViewRequestServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ViewRequestServlet at " + request.getContextPath() + "</h1>");
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
        System.out.println("do get view-request");
        Gettable<Department> departmentGetter
                = DepartmentDao.getDepartmentGetter(
                        SqlServerFactory.getConnectioner(),
                        ConverterFactory.getDepartmentConverter()
                );
        List<Department> listDepartment = departmentGetter.getAll();
        Searchable<Request> searcher = RequestDao.getRequestSeacher(SqlServerFactory.getConnectioner(), ConverterFactory.getRequestConverter());
        List<Request> listSelectedRequest = searcher.searchAll(listDepartment.get(0).getName(), RequestDao.DEPARTMENT);
        request.setAttribute("selectedDepartment", 0);
        request.setAttribute("listDepartment", listDepartment);
        request.setAttribute("listSelectedRequest", listSelectedRequest);
        request.getRequestDispatcher("performViewRequest.jsp").forward(request, response);
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
        if (request.getParameter("search") != null) {
            String title = request.getParameter("requestTitle");
            int departmentId = Integer.parseInt(request.getParameter("departmentSelect"));
            Searchable<Request> searcher = RequestDao.getRequestSeacher(SqlServerFactory.getConnectioner(), ConverterFactory.getRequestConverter());
            List<Request> listSelected = searcher.searchAll(title, RequestDao.TITLE);
            List<Request> listSelectedRequest = listSelected.stream().filter(m -> m.getReportTo().getId() == departmentId).collect(Collectors.toList());

            Gettable<Department> getter = DepartmentDao.getDepartmentGetter(SqlServerFactory.getConnectioner(), ConverterFactory.getDepartmentConverter());
            List<Department> listDepartment = getter.getAll();

            request.setAttribute("selectedDepartment", departmentId);
            request.setAttribute("listDepartment", listDepartment);
            request.setAttribute("listSelectedRequest", listSelectedRequest);
            request.getRequestDispatcher("performViewRequest.jsp").forward(request, response);
        } else {
            Gettable<RequestFully> getter = RequestDao.getRequestFullyGetter(SqlServerFactory.getConnectioner(), ConverterFactory.getRequestFullyConverter());
            int requestId = Integer.parseInt(request.getParameter("requsetIdSelected"));
            RequestFully selectedRequest = getter.get(requestId);

            request.getSession().setAttribute("file", selectedRequest.getFile());

            request.setAttribute("selectedRequest", selectedRequest);
            request.getRequestDispatcher("performSolveRequest.jsp").forward(request, response);
        }

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
