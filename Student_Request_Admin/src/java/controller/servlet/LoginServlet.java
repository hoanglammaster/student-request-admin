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

import controller.error.ErrorHandlerFactory;
import controller.utils.AppUtilsFactory;
import controller.utils.UserStoragable;
import dal.sql.SqlServerFactory;
import dal.sql.user.UserDao;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.util.encrypt.PasswordAuthentication;
import model.util.encrypt.EncrypterFactory;
import controller.error.ErrorHandler;
import dal.sql.Connections;
import dal.sql.user.Loginable;
import java.util.Optional;
import model.user.User;

/**
 *
 * @author Hoang Lam
 */
public class LoginServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private Loginable loginner;
    private ErrorHandler errorHandler;
    private UserStoragable storager;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LoginServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginServlet at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("performLogin.jsp").forward(request, response);
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
            throws ServletException, IOException 
    {
        Connections connectioner = SqlServerFactory.getConnectioner();
        PasswordAuthentication authenticator = EncrypterFactory.getPasswordAuthenticator(EncrypterFactory.getPasswordEncrypter());
        
        loginner = UserDao.getUserLoginner(connectioner, authenticator);
        errorHandler = ErrorHandlerFactory.getLoginErrorHandler();
        
        String username = request.getParameter("username").trim();
        String password = request.getParameter("password").trim();
        
        if (username.isEmpty() || password.isEmpty()) {
            errorHandler.showError(response, "Username or password can not be empty. Try again!");
        } else {

            
            Optional<User> userLogin = loginner.login(username, password);
            if (!userLogin.isPresent()) {
                errorHandler.showError(response, "Username or password incorrect. Try again!");
            } else {
                storager = AppUtilsFactory.getStorager();
                storager.storeToSession(request.getSession(), userLogin.get());
                response.sendRedirect("home");
            }
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
