/****************************************************************
* Copyright [2021] [FPT University]          
*                                                             
* This file create by [Hoang Lam]                                 
* If you want to use this file in your project,                
* please contact to <https://www.facebook.com/hoanglammaster> 
* or <hoanglammaster@gmail.com>          
* Do not use without permission                                
*                                                             
* “All I know is that I do not know anything”― Socrates      
*****************************************************************/

package controller.utils;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 *
 * @Created Jul 20, 2021  10:32:02 PM
 * 
 */

 class Notifier implements Notify{

    @Override
    public void sendNotify(String msg, HttpServletResponse response) {
        try (PrintWriter writer = response.getWriter()) {
            writer.println("<script type=\"text/javascript\">");
            writer.println("alert('"+msg+"');");
            writer.println("location='home';");
            writer.println("</script>");
        } catch (IOException ex) {
            Logger.getLogger(Notifier.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
