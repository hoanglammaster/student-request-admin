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

package dal.sql.request;

import dal.sql.Connections;
import dal.sql.Gettable;
import dal.sql.Searchable;
import dal.sql.Updatable;
import model.request.Request;
import model.request.RequestFully;
import model.request.RequestSummary;
import model.util.convert.Convertible;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 *
 * @Created Jul 19, 2021  10:12:01 AM
 * 
 */

public class RequestDao implements BaseSearchRequest{
    
    public static Searchable<Request> getRequestSeacher(Connections connection, Convertible<Request> converter){
        return new Searcher(connection, converter);
    }
    
    public static Gettable<RequestFully> getRequestFullyGetter(Connections connection, Convertible<RequestFully> converter){
        return new FullyGetter(connection, converter);
    } 
    
    public static Gettable<RequestSummary> getRequestSummaryGetter(Connections connection, Convertible<RequestSummary> converter){
        return new SummaryGetter(connection, converter);
    }
    public static Updatable<RequestFully> getRequestFullyUpdater(Connections connectioner){
        return new RequestFullyUpdater(connectioner);
    }
}
