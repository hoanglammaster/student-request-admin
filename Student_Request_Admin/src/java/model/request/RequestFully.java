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
import model.student.Student;
import model.teacher.Teacher;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 *
 * @Created Jul 16, 2021 5:53:10 AM
 *
 */
public interface RequestFully extends Request {

    public Student getStudent();

    public void setStudent(Student student);

    public String getContent();

    public void setContent(String content);

    public Teacher getSolved();

    public void setSolved(Teacher employee);

    public File getFile();

    public void setFile(File file);

    public String getSolution();

    public void setSolution(String solution);
}
