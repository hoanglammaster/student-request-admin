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
package model.util.convert;

import dal.sql.Gettable;
import dal.sql.SqlServerFactory;
import dal.sql.department.DepartmentDao;
import dal.sql.file.FileDao;
import dal.sql.student.StudentDao;
import dal.sql.teacher.TeacherDao;
import java.io.File;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.department.Department;
import model.request.RequestFactory;
import model.request.RequestFully;
import model.student.Student;
import model.teacher.Teacher;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 *
 * @Created Jul 19, 2021 11:11:58 PM
 *
 */
class RequestFullyConverter implements RequestFullyConvertible {

    @Override
    public RequestFully convert(ResultSet result) {
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

            int teacherId = result.getInt("Solved");
            Teacher solve = null;
            if (!result.wasNull()) {
                Gettable<Teacher> getter = TeacherDao.getTeacherGetter(SqlServerFactory.getConnectioner(), ConverterFactory.getTeacherConverter());
                solve = getter.get(teacherId);
            }

            int studentId = result.getInt("Student");
            Student student = null;
            if (!result.wasNull()) {
                Gettable<Student> getter = StudentDao.getStudentGetter(SqlServerFactory.getConnectioner(), ConverterFactory.getStudentConverter());
                student = getter.get(studentId);
            }

            String requestContent = result.getString("Content");
            File fileAttached = null;
            int fileId = result.getInt("FileAttached");
            if (!result.wasNull()) {
                Gettable<File> getter = FileDao.getFileGetter(SqlServerFactory.getConnectioner(), ConverterFactory.getFileConverter());
                fileAttached = getter.get(fileId);
            }

            String solution = result.getString("Solution");
            if (!result.wasNull()) {
                solution = "";
            }

            return RequestFactory.getFullyRequest(requestId, department, requestTitle, dateCreated, dateClosed, requestStatus, student, solve, requestContent, fileAttached, solution);

        } catch (SQLException ex) {
            Logger.getLogger(RequestFullyConverter.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

}
