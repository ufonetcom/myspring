package com.doom.persistence;

import lombok.extern.log4j.Log4j2;
import org.junit.Test;

import java.sql.Connection;
import java.sql.DriverManager;

import static org.springframework.test.util.AssertionErrors.fail;

@Log4j2
public class JDBCTests {

    static{
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Test
    public void testConnection() {

        try (Connection conn =
                     DriverManager.getConnection("jdbc:mysql://localhost:3306/myspringdb?serverTimezone=Asia/Seoul",
                             "root", "12345")) {
            log.info(conn);
        } catch (Exception e) {
            fail(e.getMessage());
        }
    }
}
