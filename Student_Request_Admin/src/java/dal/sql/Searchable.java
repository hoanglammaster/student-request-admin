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

import java.util.List;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 * @param <T>
 *
 * @Created Jul 20, 2021  2:08:38 AM
 * 
 */

public interface Searchable<T> {
    public T search(String str,int type);
    public List<T> searchAll(String str, int type);
}
