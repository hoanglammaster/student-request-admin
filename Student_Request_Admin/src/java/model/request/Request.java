/** **************************************************************
 * Copyright [2021] [FPT University]
 *
 * This file create by [Hoang Lam]
 * If you want to use this file in your project,
 * please contact to <https://www.facebook.com/hoanglammaster>
 * or <hoanglammaster@gmail.com>
 * Do not use without permission
 *
 * “All I know is that I do not know anything”― Socrates      
****************************************************************
 */
package model.request;

import java.sql.Date;
import model.department.Department;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 *
 * @Created Jul 5, 2021 9:59:08 PM
 *
 */
public interface Request {

    public int getRequestId();

    public void setRequestId(int id);

    public String getTitle();

    public void setTitle(String title);

    public Date getDateCreated();

    public void setDateCreated(Date dateCreated);

    public Date getDateClosed();

    public void setDateClosed(Date dateClosed);

    /**
     *
     * @return Nullable
     */
    public Boolean getStatus();

    public void setStatus(boolean status);

    public Department getReportTo();

    public void setReportTo(Department department);
    
}
