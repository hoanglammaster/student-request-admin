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

package model.teacher;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 *
 * @Created Jul 19, 2021  2:08:08 AM
 * 
 */

public class TeacherFactory {
    
    public static Teacher getDefaultTeacher(){
        return new DefaultTeacher();
    }
    
    public static Teacher getDefaultTeacher(int id, String name){
        return new DefaultTeacher(id,name);
    }
}
