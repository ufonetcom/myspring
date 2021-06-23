package com.doom.util;

import com.doom.domain.AttachVO;
import com.doom.service.BoardService;
import com.doom.service.ReplyService;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.nio.file.Paths;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.doom.config.RootConfig.class})
@Log4j2
public class fileAttach {

    @Setter(onMethod_ = @Autowired)
    private BoardService boardService;

    private final String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyMMdd"));



    @Test
    public void dateTest() {
        log.info("오늘 날짜 테스트 : {}", today);
        AttachVO fileInfo = boardService.getAttachDetail((long)1);

        String uploadDate = String.format(fileInfo.getRegdate().toString(), DateTimeFormatter.ofPattern("yyMMdd"));
        String uploadDate2 = String.format("yyMMdd", fileInfo.getRegdate());

        DateFormat inDate = new SimpleDateFormat("yyMMdd");
        String uploadDate3 = inDate.format(fileInfo.getRegdate());

        log.info("날짜 >>>> {}", uploadDate);
        log.info("날짜 >>>> {}", uploadDate2);
        log.info("날짜 >>>> {}", uploadDate3);


    }

    @Test
    public void pathTest() {
        String uploadPath = Paths.get("/Users","doompok","Desktop","study","upload",today).toString();
        log.info(uploadPath);


    }

}
