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

import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpSession;
import model.user.User;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 *
 * @Created Jul 10, 2021  7:48:17 PM
 * 
 */

class ReceiveUser implements UserReceivable{

    @Override
    public User getFromSession(HttpSession session) {
        try{
            return (User) session.getAttribute("user");
        }catch(NullPointerException|ClassCastException ex){
            Logger.getLogger(ReceiveUser.class.getName()).log(Level.SEVERE, "User Not Exist In Session", ex);
            return null;
        }
    }
}
