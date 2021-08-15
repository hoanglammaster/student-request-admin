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

import java.io.File;
import java.sql.Date;
import model.department.Department;
import model.student.Student;
import model.teacher.Teacher;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 *
 * @Created Jul 16, 2021 5:55:44 AM
 *
 */
class FullRequest extends DefaultRequest implements RequestFully {

    private Student student;
    private Teacher solved;
    private String requestContent;
    private File fileAttached;
    private String solution;

    public FullRequest() {
    }
    public FullRequest(int requestId, Boolean requestStatus, Teacher solved, String solution){
        super(requestId,null,null,null,requestStatus,null);
        this.student = null;
        this.solved = solved;
        this.requestContent = null;
        this.fileAttached = null;
        this.solution = solution;
    }
    public FullRequest(int requestId, String requestTitle, Date dateCreated, Date dateClosed, Boolean requestStatus,Department department, Student student, Teacher solved, String requestContent, File fileAttached, String solution) {
        super(requestId, requestTitle, dateCreated, dateClosed, requestStatus, department);
        this.student = student;
        this.solved = solved;
        this.requestContent = requestContent;
        this.fileAttached = fileAttached;
        this.solution = solution;
    }

    @Override
    public Student getStudent() {
        return student;
    }

    @Override
    public String getContent() {
        return requestContent;
    }

    @Override
    public Teacher getSolved() {
        return solved;
    }

    @Override
    public File getFile() {
        return fileAttached;
    }

    @Override
    public String getSolution() {
        return solution;
    }

    @Override
    public void setSolution(String solution) {
        this.solution = solution;
    }

    @Override
    public void setStudent(Student student) {
        this.student = student;
    }

    @Override
    public void setContent(String content) {
        this.requestContent = content;
    }

    @Override
    public void setSolved(Teacher solved) {
        this.solved = solved;
    }

    @Override
    public void setFile(File file) {
        this.fileAttached = file;
    }

}
