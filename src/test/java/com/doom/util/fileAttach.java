package com.doom.util;

import lombok.extern.log4j.Log4j2;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.doom.config.RootConfig.class})
@Log4j2
public class fileAttach {


    private final String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyMMdd"));

    @Test
    public void dateTest() {
        log.info("오늘 날짜 테스트 : {}", today);
    }

}
