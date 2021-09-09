package nonstructured;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.*;

public class JavaDemoJDBC {

    // соединение приложения с базой данных
    private static Connection connection = null;
    // можно посмотреть в закладке / настроить через консоль / чекнуть в воркбенче
    private static final String USERNAME = "root";
    private static final String PASSWORD = "password";
    private static final String URL = "jdbc:mysql://localhost:3306/test?serverTimezone=UTC";
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";


    public static void main(String[] args) throws SQLException {
        // класс для выполнения sql-запросов после подключения к бд
        Statement statement;

        // класс, который обрабатывает полученные результаты
        ResultSet resultSet;

        // подключение через обработчик исключений
        try {
            System.out.println("Устанавливаем соединение с БД");
            Class.forName(DRIVER);
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);

            // выполняем запросы
            String SQL = "SELECT * FROM OFFICES";
            String SQL2 =
                    "CREATE TABLE IF NOT EXISTS BLOB_OFFICES " +
                            "(ID BIGINT NOT NULL AUTO_INCREMENT, " +
                            "IMG LONGBLOB, " +
                            "DT DATE, PRIMARY KEY (ID))";


            statement = connection.createStatement();
            resultSet = statement.executeQuery(SQL);
            printResultSet(resultSet);
            statement.execute("DROP TABLE IF EXISTS BLOB_OFFICES");
            statement.executeUpdate(SQL2);

            // работа с BLOB
            BufferedImage image = ImageIO.read(new File("./resources/smile2.jpg"));
            Blob blob = connection.createBlob();

            // try-with-resources
            try(OutputStream os = blob.setBinaryStream(1)) {
                ImageIO.write(image, "jpg", os);
            }

            /*
            Для выполнения запроса PreparedStatement имеет три метода:

            1. boolean execute(): выполняет любую SQL-команду
            2. ResultSet executeQuery(): выполняет команду SELECT, которая возвращает данные в виде ResultSet
            3. int executeUpdate(): выполняет такие SQL-команды,
            как INSERT, UPDATE, DELETE, CREATE и возвращает количество измененных строк
             */

            PreparedStatement ps = connection.prepareStatement("INSERT INTO BLOB_OFFICES (IMG, DT) VALUES (?, ?)");
            ps.setBlob(1, blob);
            ps.setDate(2, new Date(System.currentTimeMillis()));
            ps.executeUpdate();

            // можно выводить динамически сфомированный стейтмент
            System.out.println(ps);

        } catch (SQLException | ClassNotFoundException | IOException throwable) {
            throwable.printStackTrace();
        } finally {
            // закрываем соединение с БД
            System.out.println("Закрываем соединение с БД");
            connection.close();
        }
    }

    // распечатать в виде таблицы
    public static void printResultSet(ResultSet rs) throws SQLException {
        ResultSetMetaData resultSetMetaData = rs.getMetaData();
        int columnsNumber = resultSetMetaData.getColumnCount();
        while (rs.next()) {
            for (int i = 1; i <= columnsNumber; i++) {
                if (i > 1) System.out.print(" | ");
                System.out.print(rs.getString(i));
            }
            System.out.println();
        }
    }
}