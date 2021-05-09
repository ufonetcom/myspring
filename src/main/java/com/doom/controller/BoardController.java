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

    @PostMapping("/register")
    public String register(BoardVO boardVO, RedirectAttributes rttr) {
        log.info("register : {}", boardVO);

        boardService.register(boardVO);

        rttr.addFlashAttribute("result", boardVO.getBoard_no());

        return "redirect:/board/list";
    }
}
