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

import controller.utils.AppUtilsFactory;
import dal.sql.SqlServerFactory;
import dal.sql.Updatable;
import dal.sql.request.RequestDao;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.request.RequestFactory;
import model.request.RequestFully;
import model.teacher.TeacherFactory;

/**
 *
 * @author Hoang Lam
 */
public class SolveRequestServlet extends HttpServlet {

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
            out.println("<title>Servlet SolveRequestServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SolveRequestServlet at " + request.getContextPath() + "</h1>");
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
        System.out.println("do get solve-request");
        request.getRequestDispatcher("view-request").forward(request, response);
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
        HttpSession session = request.getSession();
        try {
            int requestId = Integer.parseInt(request.getParameter("requestId"));
            boolean appStatus = request.getParameter("requestState").equals("approved");
            int solvedId = request.getParameter("solvedId") == null ? AppUtilsFactory.getReceiver().getFromSession(session).getId() : Integer.parseInt(request.getParameter("solvedId"));
            String solution = request.getParameter("solution");
            RequestFully requestFully = RequestFactory.getFullyRequest(requestId, appStatus, TeacherFactory.getDefaultTeacher(solvedId, null), solution);
            
            Updatable<RequestFully> updater = RequestDao.getRequestFullyUpdater(SqlServerFactory.getConnectioner());
          //  updater.update(requestFully,Updatable.);

            AppUtilsFactory.getNotifier().sendNotify("Save success!", response);
        } catch (NumberFormatException ex) {
            Logger.getLogger(SolveRequestServlet.class.getName()).log(Level.SEVERE, null, ex);
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
