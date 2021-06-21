package com.doom.util;

import com.doom.domain.AttachVO;
import com.doom.exception.AttachFileException;
import lombok.extern.log4j.Log4j2;
import org.apache.commons.io.FilenameUtils;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.UUID;

@Component
@Log4j2
public class FileUtils {

    /** 오늘 날*/
    private final String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyMMdd"));

    private final String uploadPath = Paths.get("/Users","doompok","Desktop","study","upload",today).toString();

    private final String getRandomString() {
        return UUID.randomUUID().toString().replaceAll("-", "");
    }

    public List<AttachVO> uploadFiles(MultipartFile[] files, Long board_no) {

        //업로드 파일 정보를 담을 비어있는 리스트
        List<AttachVO> attachList = new ArrayList<>();

        //upload path에 해당하는 디렉토리가 존재하지 않을 경우, 부모디렉토리를 포함한 모든 디렉토리 생성.
        //mkdir은 해당 디렉토리가 존재하지 않을 시 디렉토리 생성을 불가하고 false를 반환
        File dir = new File(uploadPath);
        if (dir.exists() == false) {
            dir.mkdirs();
        }

        for (MultipartFile file : files) {
            log.info("FileUtils** >>>>>>{}", file);

            //파일이 비어있으면 비어있는 리스트 반환
            if (file.getSize() < 1) {
                continue;
            }
            try {
                /* 파일 확장자 */
                final String extension = FilenameUtils.getExtension(file.getOriginalFilename());

                //서버에 저장할 파일명 ( 랜덤문자열 + 확장자 )
                final String saveName = file.getOriginalFilename() + "_" + getRandomString() + "." + extension;

                //업로드 경로에 saveName과 동일한 이름을 가진 파일 생(저장)
                File target = new File(uploadPath, saveName);
                file.transferTo(target);

                //파일 정보 저장
                AttachVO attachVO = new AttachVO();
                attachVO.setBoard_no(board_no);
                attachVO.setOriginal_name(file.getOriginalFilename());
                attachVO.setSave_name(saveName);
                attachVO.setSize(file.getSize());

                log.info("FileUtils**.name >>>>>>{}", attachVO.getSave_name());

                //파일 정보 추가
                attachList.add(attachVO);
            } catch (IOException e) {
                throw new AttachFileException("[" + file.getOriginalFilename() + "] failed to save file...");
            } catch (Exception e) {
                throw new AttachFileException("[" + file.getOriginalFilename() + "] failed to save file...");
            }
        }
        return attachList;
    }

}
