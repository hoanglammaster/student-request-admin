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
 * ***************************************************************
 */
package model.request;

import java.io.File;
import java.sql.Date;
import model.department.Department;
import model.student.Student;
import model.teacher.Teacher;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 *
 * @Created Jul 6, 2021 1:23:11 AM
 *
 */
public class RequestFactory {

    public static Request getDefaultRequest(int id, String requestTitle, Date dateCreated, Date dateClosed, Boolean status, Department department) {
        return new DefaultRequest(id, requestTitle, dateCreated, dateClosed, status, department);
    }

    public static RequestFully getFullyRequest(int requestId, Department department, String requestTitle, Date dateCreated, Date dateClosed, Boolean requestStatus, Student student, Teacher solved, String requestContent, File fileAttached, String solution) {
        return new FullRequest(requestId, requestTitle, dateCreated, dateClosed, requestStatus, department, student, solved, requestContent, fileAttached, solution);
    }

    public static RequestFully getFullyRequest(int requestId, Boolean requestStatus, Teacher solved, String solution) {
        return new FullRequest(requestId, requestStatus, solved, solution);
    }

    public static RequestSummary getSummaryRequest(String department, int numberOfRequest, Date dateCreated) {
        return new SummaryRequest(department, numberOfRequest, dateCreated);
    }
}
