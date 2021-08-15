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

package model.util.convert;

import java.sql.ResultSet;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 * @param <T>
 *
 * @Created Jul 19, 2021  1:10:28 PM
 * 
 */

public interface Convertible <T>{
    T convert(ResultSet result);
}
