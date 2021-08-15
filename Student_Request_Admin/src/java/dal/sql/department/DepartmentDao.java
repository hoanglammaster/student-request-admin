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

package dal.sql.department;

import dal.sql.Connections;
import dal.sql.Gettable;
import model.department.Department;
import model.util.convert.Convertible;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 *
 * @Created Jul 20, 2021  12:00:46 AM
 * 
 */

public class DepartmentDao {
    
    public static Gettable<Department> getDepartmentGetter(Connections connection, Convertible<Department> converter){
        return new DepartmentGetter(connection,converter);
    }
}
