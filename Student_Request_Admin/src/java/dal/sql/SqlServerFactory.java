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

package dal.sql;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 *
 * @Since Jul 5, 2021  8:38:35 AM
 * 
 */

public class SqlServerFactory {
    public static Connections getConnectioner(){
        return new Connectioner();
    }
}
