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
package dal.sql;

import dal.sql.Connections;
import model.util.convert.Convertible;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 *
 * @Created Jul 19, 2021 1:55:01 PM
 *
 */
public abstract class AbstractGetter<T>{

    protected Connections connectioner;
    protected Convertible<T> converter;
    protected AbstractGetter(Connections connectioner, Convertible<T> converter) {
        this.connectioner = connectioner;
        this.converter = converter;
    }
    
}
