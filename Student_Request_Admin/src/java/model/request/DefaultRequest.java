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
import model.department.Department;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 *
 * @Created Jul 16, 2021  5:46:37 AM
 * 
 */

class DefaultRequest implements Request{

    private int requestId;
    private String requestTitle;
    private Date dateCreated;
    private Date dateClosed;
    private Boolean requestStatus;
    private Department department;

    public DefaultRequest() {
    }

    public DefaultRequest(int requestId, String requestTitle, Date dateCreated, Date dateClosed, Boolean requestStatus, Department department) {
        this.requestId = requestId;
        this.requestTitle = requestTitle;
        this.dateCreated = dateCreated;
        this.dateClosed = dateClosed;
        this.requestStatus = requestStatus;
        this.department = department;
    }
    
    @Override
    public int getRequestId() {
        return requestId;
    }

    @Override
    public String getTitle() {
        return requestTitle;
    }

    @Override
    public Date getDateCreated() {
        return dateCreated;
    }

    @Override
    public Date getDateClosed() {
        return dateClosed;
    }

    @Override
    public Boolean getStatus() {
        return requestStatus;
    }

    @Override
    public Department getReportTo() {
        return department;
    }

    @Override
    public void setRequestId(int id) {
        this.requestId = id;
    }

    @Override
    public void setTitle(String title) {
        this.requestTitle = title;
    }

    @Override
    public void setDateCreated(Date dateCreated) {
        this.dateCreated = dateCreated;
    }

    @Override
    public void setDateClosed(Date dateClosed) {
        this.dateClosed = dateClosed;
    }

    @Override
    public void setStatus(boolean status) {
        this.requestStatus = status;
    }

    @Override
    public void setReportTo(Department department) {
        this.department = department;
    }

}
