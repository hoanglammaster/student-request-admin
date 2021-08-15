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
package model.util.convert;

import java.io.File;
import model.department.Department;
import model.request.Request;
import model.request.RequestFully;
import model.request.RequestSummary;
import model.student.Student;
import model.teacher.Teacher;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 *
 * @Created Jul 19, 2021 11:47:31 PM
 *
 */
public class ConverterFactory {

    public static Convertible<Department> getDepartmentConverter() {
        return new DepartmentConverter();
    }

    public static Convertible<Request> getRequestConverter() {
        return new RequestDefaultConverter();
    }

    public static Convertible<RequestFully> getRequestFullyConverter() {
        return new RequestFullyConverter();
    }

    public static Convertible<Teacher> getTeacherConverter() {
        return new TeacherConverter();
    }

    public static Convertible<Student> getStudentConverter() {
        return new StudentConverter();
    }
    public static Convertible<File> getFileConverter(){
        return new FileConverter();
    }
    public static Convertible<RequestSummary> getRequestSummaryConverter(){
        return new RequestSummaryConverter();
    }
}
