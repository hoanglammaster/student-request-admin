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

import javax.servlet.http.HttpSession;
import model.user.User;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 *
 * @Created Jul 10, 2021  7:47:24 PM
 * 
 */

public interface UserReceivable {
    public User getFromSession(HttpSession session);
}
