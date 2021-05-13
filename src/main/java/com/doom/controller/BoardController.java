package com.doom.controller;

import com.doom.domain.BoardVO;
import com.doom.service.BoardService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@Log4j2
@AllArgsConstructor
@RequestMapping("/board/*")
public class BoardController {

    private BoardService boardService;

    @GetMapping("/list")
    public void list(Model model) {
        log.info("list");

        model.addAttribute("list", boardService.getList());
    }

    @GetMapping("/get")
    public String get(@RequestParam("board_no") Long board_no, Model model) {

        log.info("/get");
        BoardVO detailByBoardNo = boardService.getDetailByBoardNo(board_no);
        model.addAttribute("board", detailByBoardNo);

        return "board/getDetail";
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
        boolean modify_TF = boardService.modify(boardVO);
        if (modify_TF) {
            rttr.addFlashAttribute("result", "success");
        }
        return "redirect:/board/list";
    }

    @PostMapping("/remove")
    public String remove(@RequestParam("board_no") Long board_no, RedirectAttributes rttr) {
        log.info("remove.....{}", board_no);
        boolean remove_TF = boardService.remove(board_no);
        if (remove_TF) {
            rttr.addFlashAttribute("result", "success");
        }
        return "redirect:/board/list";
    }
}
