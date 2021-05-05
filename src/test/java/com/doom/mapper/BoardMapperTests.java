package com.doom.mapper;

import junit.framework.TestCase;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.doom.config.RootConfig.class})
@Log4j2
public class BoardMapperTests {

    @Setter(onMethod_ = @Autowired)
    private BoardMapper mapper;

    @Test
    public void testGetList() {
        mapper.getList().forEach(boardVO -> log.info(boardVO));
    }

}