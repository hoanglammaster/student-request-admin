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

package model.util.convert;

import dal.sql.Gettable;
import dal.sql.SqlServerFactory;
import dal.sql.department.DepartmentDao;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.department.Department;
import model.request.Request;
import model.request.RequestFactory;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 *
 * @Created Jul 19, 2021  11:03:58 PM
 * 
 */

class RequestDefaultConverter implements RequesDefaultConvertible{

    public RequestDefaultConverter() {
    }
    
    @Override
    public Request convert(ResultSet result) {
        try {

            int requestId = result.getInt("AppId");
            String requestTitle = result.getString("Title");
            Date dateCreated = result.getDate("DateCreated");

            Date dateClosed = null;
            Date temp = result.getDate("DateClose");
            if (!result.wasNull()) {
                dateClosed = temp;
            }
            
            Boolean requestStatus = result.getBoolean("AppStatus");
            if(result.wasNull()){
                requestStatus = null;
            }
            
            int departmentId = result.getInt("Department");
            Department department = null;
            if (!result.wasNull()) {
                Gettable<Department> getter = DepartmentDao.getDepartmentGetter(SqlServerFactory.getConnectioner(), ConverterFactory.getDepartmentConverter());
                department = getter.get(departmentId);
            }

            return RequestFactory.getDefaultRequest(requestId, requestTitle, dateCreated, dateClosed, requestStatus, department);

        } catch (SQLException ex) {
            Logger.getLogger(RequestDefaultConverter.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;

    }

}
