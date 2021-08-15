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
package controller.error;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 *
 * @Created Jul 10, 2021 2:52:22 PM
 *
 */
public class ErrorHandlerFactory {

    public static ErrorHandler getLoginErrorHandler() {
        return new LoginErrorHandler();
    }

    public static ErrorHandler getAccessDeniedHandler() {
        return new AccessDeniedHandler();
    }
}
