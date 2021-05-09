package com.doom.controller;

import lombok.extern.log4j.Log4j2;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration //WebApplicationContext라는 존재를 이용하기 위해서 사용.
@ContextConfiguration(classes = {com.doom.config.RootConfig.class, com.doom.config.ServletConfig.class})
@Log4j2
public class BoardControllerTests {

    @Autowired
    private WebApplicationContext webApplicationContext;

    private MockMvc mockMvc; //가짜 MVC

    @Before
    public void setup() {
        this.mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
    }

    @Test
    public void testList() throws Exception {
        log.info(
                mockMvc.perform(MockMvcRequestBuilders.get("/board/list"))
                .andReturn()
                .getModelAndView()
                .getModelMap());
    }

    @Test
    public void testGetDetailByBoardNo() throws Exception {
        log.info(mockMvc.perform(MockMvcRequestBuilders
        .get("/board/get")
        .param("board_no", "2"))
        .andReturn()
        .getModelAndView().getModelMap());
    }

    @Test
    public void testRegister() throws Exception {
        String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/board/register")
                .param("title", "테스트 새글 제목")//여기서의 param은 form에 <input>태그와 같은 기능이다.
                .param("content", "테스트 새글 내용")
                .param("writer", "doomsuzin")).andReturn().getModelAndView().getViewName();

        log.info(resultPage);
    }

    @Test
    public void testModify() throws Exception {
        mockMvc.perform(MockMvcRequestBuilders.post("/board/modify")
                .param("board_no", "1")
                .param("title", "수정된 테스트 새글 제목")
                .param("content", "수정된 테스트 새글 내용")
                .param("writer", "user000")).andReturn().getModelAndView().getViewName();
    }

    @Test
    public void testRemove() throws Exception {
        //삭제 전 데이터베이스에 게시물 번호 확인할 것.
        String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/board/remove")
                .param("board_no", "20")).andReturn().getModelAndView().getViewName();

        log.info(resultPage);
    }
}
