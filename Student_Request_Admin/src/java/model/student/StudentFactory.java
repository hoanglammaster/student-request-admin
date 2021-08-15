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

package model.student;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 *
 * @Created Jul 19, 2021  2:12:44 AM
 * 
 */

public class StudentFactory {
    public static Student getDefaultStudent(){
        return new DefaultStudent();
    }
    public static Student getDefaultStudent(int id, String code, String fullName){
        return new DefaultStudent(id, code, fullName);
    }
}
