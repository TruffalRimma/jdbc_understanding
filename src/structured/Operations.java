package structured;

import java.math.BigDecimal;
import java.sql.*;

import static nonstructured.JavaDemoJDBC.*;

public class Operations {

    public static void main(String[] args) {
        Operations operations = new Operations();
        operations.simpleSelect();
    }

    public void simpleSelect() {
        String sql = "SELECT * FROM PRODUCTS";
        try (Connection connection = Util.getConnection();
             Statement statement = connection.createStatement()) {
            ResultSet resultSet = statement.executeQuery(sql);
            printResultSet(resultSet);
        } catch (SQLException exception) {
            exception.printStackTrace();
        }
    }

    public void insertion() {
        try (Connection connection = Util.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(
                     "INSERT INTO OFFICES (CITY, REGION, TARGET, SALES, OFFICE) VALUES (?, ?, ?, ?, ?)")) {
            preparedStatement.setString(1, "Dallas");
            preparedStatement.setString(2, "Western");
            preparedStatement.setBigDecimal(3, BigDecimal.valueOf(275000));
            preparedStatement.setBigDecimal(4, BigDecimal.ZERO);
            preparedStatement.setInt(5, 23);

            preparedStatement.executeUpdate();
        } catch (SQLException exception) {
            exception.printStackTrace();
        }
    }
}
