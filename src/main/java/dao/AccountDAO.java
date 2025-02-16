package dao;

import utils.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AccountDAO {
    public List<Account> getAccountsByUserId(int userId) throws SQLException, ClassNotFoundException {
        List<Account> accounts = new ArrayList<>();
        String sql = "SELECT account_id, account_type FROM tbl_accounts WHERE user_id = ?";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, userId);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    Account account = new Account();
                    account.setAccountId(resultSet.getInt("account_id"));
                    account.setAccountType(resultSet.getString("account_type"));
                    accounts.add(account);
                }
            }
        }
        return accounts;
    }
}