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

package model.util.encrypt;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 *
 * @Since Jul 5, 2021  4:51:12 PM
 * 
 */

interface Encryptable {
    public static final int DEFAULT_COST = 16;
    public static final String ALGORITHM = "PBKDF2WithHmacSHA512";
    public static final int SIZE = 128;
    
}
