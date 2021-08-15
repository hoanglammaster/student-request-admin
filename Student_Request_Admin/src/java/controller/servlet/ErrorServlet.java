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
****************************************************************
 */
package controller.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Hoang Lam
 */
@WebServlet(name = "ErrorServlet", urlPatterns = {"/errors"})
public class ErrorServlet extends HttpServlet {
    private static final String DEFAULT_NAME = "Unknown";
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
            out.println("<title>Servlet ErrorServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ErrorServlet at " + request.getContextPath() + "</h1>");
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
        // Analyze the servlet exception       
      Throwable exception = (Throwable)
      request.getAttribute("javax.servlet.error.exception");
      Integer errorCode = (Integer)
      request.getAttribute("javax.servlet.error.status_code");
      String servletName = (String)
      request.getAttribute("javax.servlet.error.servlet_name");
         
      if (servletName == null) {
         servletName = DEFAULT_NAME;
      }
      String requestUri = (String)
      request.getAttribute("javax.servlet.error.request_uri");
      
      if (requestUri == null) {
         requestUri = DEFAULT_NAME;
      }
      String errorMsg="";
      if(errorCode == null){
          errorCode = 0;
      }
      switch (errorCode) {
            case 400: {
                errorMsg = "Http Error Code: 400. Bad Request";
                break;
            }
            case 401: {
                errorMsg = "Http Error Code: 401. Unauthorized";
                break;
            }
            case 404: {
                errorMsg = "Http Error Code: 404. Resource not found";
                break;
            }
            case 500: {
                errorMsg = "Http Error Code: 500. Internal Server Error";
                break;
            }
            default :
                errorMsg = "Access Deny!";
        }
      if(exception!= null){
        request.setAttribute("exception", exception.getMessage());
      }else{
          request.setAttribute("exception", DEFAULT_NAME);
      }
      String homePageURL = response.encodeURL("http://localhost:8080")+request.getContextPath()+"/home";
      request.setAttribute("errorMsg", errorMsg);
      request.setAttribute("servletName", servletName);
      request.setAttribute("errorCode", errorCode);
      request.setAttribute("requestURI",requestUri);
      request.setAttribute("homePageURL", homePageURL);
      request.getRequestDispatcher("errorPage.jsp").forward(request, response);
      
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
        this.doGet(request, response);
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
