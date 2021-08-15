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

package model.request;

import java.sql.Date;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 *
 * @Created Jul 19, 2021  11:00:31 AM
 * 
 */

public interface RequestSummary {
    public String getDepartment();
    public void setDepartment(String department);
    public int getNumberOfRequest();
    public void setNumberOfRequest(int request);
    public Date getDateCreated();
    public void setDateCreated(Date dateCreated);
}
