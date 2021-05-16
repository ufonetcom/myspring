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

@Controller
@Log4j2
@AllArgsConstructor
@RequestMapping("/board/*")
public class BoardController {

    private BoardService boardService;

    @GetMapping("/list")
    public void list(@ModelAttribute("criteria") Criteria criteria, Model model) {
        log.info("list");

        model.addAttribute("list", boardService.getList(criteria));
    }

    @GetMapping({"/getDetail","/modify"})
    public void getDetail(@RequestParam("board_no") Long board_no, Model model) {

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
        boolean modify_TF = boardService.modify(boardVO);
        if (modify_TF) {
            rttr.addFlashAttribute("result", "modify-success");
        }
        return "redirect:/board/list";
    }

    @PostMapping("/remove")
    public String remove(@RequestParam("board_no") Long board_no, RedirectAttributes rttr) {
        log.info("remove.....{}", board_no);
        boolean remove_TF = boardService.remove(board_no);
        if (remove_TF) {
            rttr.addFlashAttribute("result", "delete-success");
        }
        return "redirect:/board/list";
    }
}
