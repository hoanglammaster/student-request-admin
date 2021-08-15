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
 * @Created Jul 19, 2021  11:03:40 AM
 * 
 */

 class SummaryRequest implements RequestSummary{
     private String department;
     private int numberOfRequest;
     private Date dateCreated;
    public SummaryRequest() {
    }

    public SummaryRequest(String department, int numberOfRequest,Date dateCreated) {
        this.department = department;
        this.numberOfRequest = numberOfRequest;
        this.dateCreated = dateCreated;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public int getNumberOfRequest() {
        return numberOfRequest;
    }

    public void setNumberOfRequest(int numberOfRequest) {
        this.numberOfRequest = numberOfRequest;
    }

    public Date getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(Date dateCreated) {
        this.dateCreated = dateCreated;
    }
    
}
