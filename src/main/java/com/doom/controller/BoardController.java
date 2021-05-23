package com.doom.controller;

import com.doom.common.Criteria;
import com.doom.domain.BoardVO;
import com.doom.service.BoardService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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

    @GetMapping({"/getDetail","/modify"})
    public void getDetail(@ModelAttribute("params") BoardVO params, @RequestParam("board_no") Long board_no, Model model) {

        log.info("/get or modify");
        BoardVO detailByBoardNo = boardService.getDetailByBoardNo(board_no);
        model.addAttribute("board", detailByBoardNo);
    }

    @GetMapping("/register")
    public String register() {
        return "board/register";
    }

    @PostMapping("/register")
    public String register(BoardVO boardVO, RedirectAttributes rttr) {

        log.info("register : {}", boardVO);

        boardService.register(boardVO);

        rttr.addFlashAttribute("result", boardVO.getBoard_no());

        return "redirect:/board/list";
    }

    @PostMapping("/modify")
    public String modify(BoardVO boardVO, RedirectAttributes rttr) {
        log.info("modify : {}", boardVO);
        log.info("pageNo!!! : {}", boardVO.getCurrentPageNo());
        boolean modify_TF = boardService.modify(boardVO);
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
}
