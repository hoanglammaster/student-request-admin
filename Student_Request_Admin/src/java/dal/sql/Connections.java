package dal.sql;

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



import java.sql.Connection;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 *
 * @Since Jul 5, 2021  8:33:00 AM
 * 
 */

public interface Connections {
    public static final String CONNECTION_STRING = "jdbc:sqlserver://localhost:1433;user=sa;password=123;databaseName=FPT_EducationSystem";
    public static final String PROVIDER_NAME = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    
    public Connection getConnection();
}
