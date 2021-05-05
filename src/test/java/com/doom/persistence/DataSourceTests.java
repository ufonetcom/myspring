package com.doom.persistence;

import com.doom.config.RootConfig;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import javax.sql.DataSource;
import java.sql.Connection;

import static org.junit.Assert.fail;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {RootConfig.class})
@Log4j2
public class DataSourceTests {
    @Autowired
    private DataSource dataSource;

    @Setter(onMethod_ = {@Autowired})
    private SqlSessionFactory sqlSessionFactory;


    @Test
    public void testConnection() {
        try (Connection conn = dataSource.getConnection()) {
            log.info(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Test
    public void testMyBatis() {
        try(SqlSession sqlsession = sqlSessionFactory.openSession();
            Connection con = sqlsession.getConnection();
            ){
            log.info(sqlsession);
            log.info(con);
        } catch (Exception e) {
            fail(e.getMessage());
        }
    }
}
