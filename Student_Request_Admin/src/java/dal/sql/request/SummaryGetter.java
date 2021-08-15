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
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.request.RequestSummary;
import model.util.convert.Convertible;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 *
 * @Created Jul 20, 2021 2:04:32 AM
 *
 */
class SummaryGetter extends AbstractGetter<RequestSummary> implements RequestSummaryGettable {

    public SummaryGetter(Connections connectioner, Convertible<RequestSummary> converter) {
        super(connectioner, converter);
    }

    @Override
    public RequestSummary get(int id) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public List<RequestSummary> getAll() {
        String query = "SELECT DepartmentName,COUNT(AppId) AS NumberOfRequest,DateCreated  FROM Applications a\n"
                + "JOIN Departments p ON a.Department = p.DepartmentId\n"
                + "WHERE AppStatus IS NULL \n"
                + "GROUP BY DepartmentName, DateCreated";
        List<RequestSummary> listRequestSummary = new ArrayList<>();
        try (Connection connection = connectioner.getConnection()) {
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                try (ResultSet result = statement.executeQuery()) {
                    while (result.next()) {
                        listRequestSummary.add(converter.convert(result));
                    }
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(SummaryGetter.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listRequestSummary;
    }

}
