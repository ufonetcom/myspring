package com.doom.util;

import lombok.extern.log4j.Log4j2;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.nio.file.Paths;
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

    @Test
    public void pathTest() {
        String uploadPath = Paths.get("/Users","doompok","Desktop","study","upload",today).toString();
        log.info(uploadPath);
    }

}
