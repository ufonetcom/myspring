package com.doom.util;

import org.springframework.stereotype.Component;

import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

@Component
public class FileUtils {

    /** 오늘 날*/
    private final String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyMMdd"));

    private final String uploadPath = Paths.get("").toString();

}
