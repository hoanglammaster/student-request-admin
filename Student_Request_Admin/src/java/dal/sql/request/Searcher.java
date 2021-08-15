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
 * ***************************************************************
 */
package dal.sql.request;

import dal.sql.AbstractGetter;
import dal.sql.Connections;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.request.Request;
import model.util.convert.Convertible;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 *
 * @Created Jul 19, 2021 9:53:09 AM
 *
 */
class Searcher extends AbstractGetter<Request> implements RequestSearchable, BaseSearchRequest {

    public Searcher(Connections connectioner, Convertible<Request> converter) {
        super(connectioner, converter);
    }

//    @Override
//    public List<Request> getDefaul(String title) {
//        List<Request> listRequest = new ArrayList<>();
//        String query = "EXEC stp_SelectApplication ?";
//        try (Connection connection = connectioner.getConnection()) {
//            try (PreparedStatement statement = connection.prepareStatement(query)) {
//                statement.setString(1, title);
//                ResultSet result = statement.executeQuery();
//                RequestConvertable converter = RequestServiceFactory.getDefaultConverter();
//                while (result.next()) {
//                    listRequest.add(converter.convert(result));
//                }
//            }
//        } catch (SQLException ex) {
//            Logger.getLogger(Getter.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return listRequest;
//    }
//
//    @Override
//    public RequestFully getFully(int requestId) {
//        String query = "SELECT * FROM Applications app JOIN ApplicationDetails de ON app.AppId = de.Id\n"
//                + "WHERE AppId = ?";
//        try (Connection connection = connectioner.getConnection()) {
//            try (PreparedStatement statement = connection.prepareStatement(query)) {
//                statement.setInt(1, requestId);
//                ResultSet result = statement.executeQuery();
//                RequestFullyConvertible converter = RequestServiceFactory.getFullRequestConverter();
//                if (result.next()) {
//                    return converter.convert(result);
//                }
//            }
//        } catch (SQLException ex) {
//            Logger.getLogger(Getter.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return null;
//    }
//
//    @Override
//    public List<RequestSummary> getSummary() {
//        String query = "SELECT DepartmentName, COUNT(AppId) AS NumberOfRequest FROM Applications a\n"
//                + "JOIN Departments p ON a.Department = p.DepartmentId\n"
//                + " WHERE AppStatus IS NULL\n"
//                + "GROUP BY DepartmentName";
//        try(Connection connection = connectioner.getConnection()){
//            try(PreparedStatement statement = connection.prepareStatement(query)){
//                ResultSet result =  statement.executeQuery();
//                
//            }
//        } catch (SQLException ex) {
//            Logger.getLogger(Getter.class.getName()).log(Level.SEVERE, null, ex);
//        }
//    
    @Override
    public Request search(String str, int type) {
        String query = "";
        switch (type) {
            case DEPARTMENT:
                query = "EXEC stp_SelectApplicationWithDepartment ?";
                break;
            case TITLE:
                query = "EXEC stp_SelectApplication ?";
                break;
            default:
                throw new IllegalArgumentException("Type research not format!");
        }

        try (Connection connection = connectioner.getConnection()) {
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setString(1, str);
                ResultSet result = statement.executeQuery();
                if (result.next()) {
                    return converter.convert(result);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(Searcher.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    @Override
    public List<Request> searchAll(String str, int type) {
        List<Request> listRequest = new ArrayList<>();
        String query = "";
        switch (type) {
            case DEPARTMENT:
                query = "EXEC stp_SelectApplicationWithDepartment ?";
                break;
            case TITLE:
                query = "EXEC stp_SelectApplication ?";
                break;
            default:
                throw new IllegalArgumentException("Type research not format!");
        }
        try (Connection connection = connectioner.getConnection()) {
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setString(1, str);
                ResultSet result = statement.executeQuery();
                while (result.next()) {
                    listRequest.add(converter.convert(result));
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(Searcher.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listRequest;
    }

}
