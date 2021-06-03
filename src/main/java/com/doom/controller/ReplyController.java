package com.doom.controller;

import com.doom.domain.ReplyVO;
import com.doom.service.ReplyService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@Log4j2
@AllArgsConstructor
@RequestMapping("/replies/*")
public class ReplyController {

    private ReplyService replyService;

    @GetMapping("/{board_no}")
    public List<ReplyVO> replyList(@PathVariable("board_no") Long board_no, @ModelAttribute("params") ReplyVO params) {
        log.info("게시글 번호 : {}", board_no);
        return replyService.getReplyList(params);
    }

    @PostMapping("/new")
    public String register(@RequestBody ReplyVO params) {
        boolean registerTF = replyService.register(params);
        log.info("컨트롤러 등록 tf : {}", registerTF);
        return (registerTF == true ? "regSuccess" : "regFail");
    }

    @DeleteMapping("/{reply_no}")
    public String remove(@PathVariable("reply_no") Long reply_no) {
        boolean deleteTF = replyService.remove(reply_no);
        return (deleteTF == true ? "delSuccess" : "delFail");
    }
}
