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
package controller.filter;

import controller.error.ErrorHandler;
import controller.error.ErrorHandlerFactory;
import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.user.User;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 *
 * @Created Jul 10, 2021 3:23:35 PM
 *
 */
public class Permissionner implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpSession session = httpRequest.getSession();
        
        User user = (User) session.getAttribute("user");
        if (user != null) {
            if(user.getRole() == User.STUDENT){
                ErrorHandler error = ErrorHandlerFactory.getAccessDeniedHandler();
                error.showError((HttpServletResponse) response, "Access Deny");
                session.setAttribute("user", null);
            }else{
                chain.doFilter(request, response);
            }
        } else {
            RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher("/login");
            dispatcher.forward(request, response);
        }
    }

    @Override
    public void destroy() {
    }

}
