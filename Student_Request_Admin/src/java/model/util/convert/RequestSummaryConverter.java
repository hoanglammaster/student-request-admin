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

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.request.RequestFactory;
import model.request.RequestSummary;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 *
 * @Created Jul 19, 2021  11:53:15 PM
 * 
 */

class RequestSummaryConverter implements RequestSummaryConvertible{

    @Override
    public RequestSummary convert(ResultSet result) {
        try {
            String department = result.getString("DepartmentName");
            int numberOfRequest = result.getInt("NumberOfRequest");
            Date dateCreated = result.getDate("DateCreated");
            return RequestFactory.getSummaryRequest(department, numberOfRequest,dateCreated);
        } catch (SQLException ex) {
            Logger.getLogger(RequestSummaryConverter.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
