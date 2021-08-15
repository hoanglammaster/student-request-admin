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

package dal.sql;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 * @param <T>
 * @Created Jul 20, 2021  9:42:34 PM
 * 
 */

public interface Updatable<T>{

    /**
     * Change data using my permission
     */
    public static final int MYSELT = 0;

    /**
     * Change data using someone else's permission
     */
    public static final int OTHER = 1;
    public void update(T t,int type);
}
