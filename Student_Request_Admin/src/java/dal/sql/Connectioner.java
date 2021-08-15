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

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 *
 * @Since Jul 5, 2021  8:36:25 AM
 * 
 */

class Connectioner implements Connections{

    @Override
    public Connection getConnection() {
        try{
            Class.forName(PROVIDER_NAME);
            return DriverManager.getConnection(CONNECTION_STRING);
        }catch(ClassNotFoundException| SQLException ex){
            Logger.getLogger(Connectioner.class.getName()).log(Level.SEVERE, "Failed To Connect", ex);
            return null;
        }
    }

}
