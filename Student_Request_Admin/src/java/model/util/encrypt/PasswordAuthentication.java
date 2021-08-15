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
package model.util.encrypt;

import java.util.regex.Pattern;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 *
 * @Since Jul 5, 2021 4:46:06 PM
 *
 */
public interface PasswordAuthentication extends Encryptable{

    public static final Pattern LAYOUT = Pattern.compile("\\$(\\d\\d?)\\$(\\d\\d?)\\$(.{43})");
    
    public boolean authentic(String password, String token);
}
