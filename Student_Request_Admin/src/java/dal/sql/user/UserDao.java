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

package dal.sql.user;

import model.util.encrypt.PasswordAuthentication;
import dal.sql.Connections;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 *
 * @Created Jul 12, 2021  11:02:08 PM
 * 
 */

public class UserDao {
    
    public static Loginable getUserLoginner(Connections connectioner,PasswordAuthentication authenticator){
        return new Loginner(connectioner,authenticator);
    }
}
