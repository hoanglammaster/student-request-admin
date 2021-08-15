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
package controller.error;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 *
 * @Created Jul 10, 2021 2:49:37 PM
 *
 */
class LoginErrorHandler implements ErrorHandler {

    @Override
    public void showError(HttpServletResponse response, String error) {
        try {
            PrintWriter writer = response.getWriter();
            writer.println("<script type=\"text/javascript\">");
            writer.println("alert('"+error+"');");
            writer.println("location='performLogin.jsp';");
            writer.println("</script>");
        } catch (IOException ex) {
            System.out.println(ex);
        }
    }

}
