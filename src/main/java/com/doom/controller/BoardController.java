package com.doom.controller;

import com.doom.common.Criteria;
import com.doom.domain.AttachVO;
import com.doom.domain.BoardVO;
import com.doom.service.BoardService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.file.Paths;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.List;

@Controller
@Log4j2
@AllArgsConstructor
@RequestMapping("/board/*")
public class BoardController {

    private BoardService boardService;

    @GetMapping("/list")
    public void list(@ModelAttribute("board") BoardVO board, Model model) {
        log.info("list");
        log.info("pageNo Test = {}", board.makeQueryString(board.getCurrentPageNo()));
        List<BoardVO> boardList = boardService.getList(board);
        model.addAttribute("boardList", boardList);
    }

    @GetMapping({"/getDetail", "/modify"})
    public void getDetail(@ModelAttribute("params") BoardVO params, @RequestParam("board_no") Long board_no, Model model) {

        log.info("/get or modify");
        BoardVO detailByBoardNo = boardService.getDetailByBoardNo(board_no);
        model.addAttribute("board", detailByBoardNo);

        List<AttachVO> fileList = boardService.getAttachFileList(board_no);
        model.addAttribute("fileList", fileList);
    }

    @GetMapping("/register")
    public String register() {
        return "board/register";
    }

    @PostMapping("/register")
    public String register(BoardVO boardVO, final MultipartFile[] files, RedirectAttributes rttr) {
        log.info("register : {}", boardVO);

        boolean isRegistered = boardService.register(boardVO, files);
        if (isRegistered == false) {
            rttr.addFlashAttribute("result", "register-fail");
        }
        rttr.addFlashAttribute("result", boardVO.getBoard_no());

        return "redirect:/board/list";
    }

    @PostMapping("/modify")
    public String modify(BoardVO boardVO, final MultipartFile[] files, RedirectAttributes rttr) {
        log.info("modify : {}", boardVO);
        log.info("pageNo!!! : {}", boardVO.getCurrentPageNo());

        log.info("files>>> {}", boardVO.getFileIdx_no());

        boolean modify_TF = boardService.modify(boardVO, files);

        if (modify_TF) {
            //수정과 삭제 post는 makeQueryString함수를 호출하게되면 더 깔끔해 질 수 있다.
            rttr.addAttribute("currentPageNo", boardVO.getCurrentPageNo());
            rttr.addAttribute("recordsPerPage", boardVO.getRecordsPerPage());
            rttr.addAttribute("pageSize", boardVO.getPageSize());
            rttr.addAttribute("searchType", boardVO.getSearchType());
            rttr.addAttribute("searchKeyword", boardVO.getSearchKeyword());

            rttr.addFlashAttribute("result", "modify-success");
        }
        return "redirect:/board/list";
    }

    @PostMapping("/remove")
    public String remove(BoardVO boardVO, @RequestParam("board_no") Long board_no, RedirectAttributes rttr) {
        log.info("remove.....{}", board_no);
        boolean remove_TF = boardService.remove(board_no);
        if (remove_TF) {
            rttr.addAttribute("currentPageNo", boardVO.getCurrentPageNo());
            rttr.addAttribute("recordsPerPage", boardVO.getRecordsPerPage());
            rttr.addAttribute("pageSize", boardVO.getPageSize());
            rttr.addAttribute("searchType", boardVO.getSearchType());
            rttr.addAttribute("searchKeyword", boardVO.getSearchKeyword());

            rttr.addFlashAttribute("result", "delete-success");
        }
        return "redirect:/board/list";
    }

    @GetMapping("download")
    public void downloadAttachFile(@RequestParam(value = "file_no", required = false) Long file_no, Model model, HttpServletResponse response) {
        if (file_no == null) {
            throw new RuntimeException("올바르지 않은 접근입니다.");
        }

        AttachVO fileInfo = boardService.getAttachDetail(file_no);
        if (fileInfo == null || "Y".equals(fileInfo.getDelete_yn())) {
            throw new RuntimeException("파일 경로를 찾을수 없습니다.");
        }
        DateFormat inDate = new SimpleDateFormat("yyMMdd");
        String uploadDate = inDate.format(fileInfo.getRegdate());

        String uploadPath = Paths.get("/Users","doompok","Desktop","study","upload",uploadDate).toString();

        String fileName = fileInfo.getOriginal_name();

        File file = new File(uploadPath, fileInfo.getSave_name());

        try {
            byte[] data = FileUtils.readFileToByteArray(file); //FileUtils 는 org.apache.commons.io 패키지에서 생성
            response.setContentType("application/octet-stream");
            response.setContentLength(data.length);
            response.setHeader("Content-Transfer-Encoding", "binary");
            response.setHeader("content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(fileName, "UTF-8") + "\";");

            response.getOutputStream().write(data); //다운로드 시작
            response.getOutputStream().flush(); //다운로드 완료
            response.getOutputStream().close(); //버퍼 정리하고 닫기
        } catch (IOException e) {
            throw new RuntimeException("다운로드에 실패하였습니다.");
        } catch (Exception e) {
            throw new RuntimeException("시스템에 문제가 생겼습니다.");
        }

    }
}
